######Merge Sort########
## TODO - Add NOPs to make the program work with software scheduled pipeline
## Only handles even array sizes

# $a1 = length given to function, $a0 = starting address for function
# things saved in the stack of a given call: 0($sp) - return address, 4($sp) - length of each subarray, 8($sp) - given base address for array

main:
# Load array size
addi $a1, $0, 8		 # Size of array = 8
sll $a1, $a1, 2    # Convert to addresses

# Load array base address and values into array
# base address arbitrarily chosen because .data was causing the program to act up
li   $a0, 0x10010000

li   $t2, 9
sw   $t2, 0($a0)

li   $t3, 3
sw   $t3, 4($a0)

li   $t4, 7
sw   $t4, 8($a0)

li   $t5, 1
sw   $t5, 0xC($a0)

li   $t6, 8
sw   $t6, 0x10($a0)

li   $t7, 5
sw   $t7, 0x14($a0)

li   $t2, 4
sw   $t2, 0x18($a0)

li   $t3, 2
sw   $t3, 0x1C($a0)

jal mergeSort
j exit

mergeSort:
addi $t2, $0, 4
beq $a1, $t2, mergeReturnNoStack #if array size not 1 word, or 4 bytes keep going

#Prep for jals, split length, save to stack
srl $a1, $a1, 1 #Divide length by 2 to get size of each subarray

addi $sp, $sp, -16 #word aligned stack because I'm feeling cautious
sw $ra, 0($sp) #Store return address for jal
sw $a0, 8($sp) #Store base address
sw $a1, 4($sp) #Store length of half of array

#Run mergeSort on each half of the array

jal mergeSort
lw $a0, 8($sp) #Get base address back
lw $a1, 4($sp) #Get length of array back
add $a0, $a0, $a1 #add length of array to base address to get second half of array for next mergeSort

jal mergeSort
lw $a0, 8($sp)
lw $a1, 4($sp)

mergeBegin:
#Merge the two arrays in ascending order
# $t1 = number of things taken from subarray 1, $t2 = number of things taken from subarray 2
# $t3 = value from subarray 1 being compared, $t4 = value from subarray 2 being compared
# $t5 = base address of subarray 2 to make things easier, $t6 = address to pull from
# $t0 = base address that things are being stored in, $t7 = next address to store things in
add $t5, $a0, $a1
addi $t1, $0, 0
addi $t2, $0, 0
addi $t0, $0, 0x10010100 #my arbitrarily chosen destination for the sorted array since I can't layer it on itself until I'm done, 
#and I don't trust the stack to not overflow on this even though I've got other problems in here limiting size and usability
addi $t7, $t0, 0 #the destination that will be written to

mergeContinue:
#import values
add $t6, $a0, $t1
lw $t3, 0($t6) #setup value being compared from array 1
add $t6, $t5, $t2
lw $t4, 0($t6) #setup value being compared from array 2

slt $at, $t3, $t4 #if value at start of subarray 1 is less than subarray 2, set
beq $at, $0, mergeTwo

mergeOne:
sw $t3, 0($t7)
addi $t1, $t1, 4 #increase address by 1
addi $t7, $t7, 4 #increase storage address by 4
j mergeChecks

mergeTwo: 
sw $t4, 0($t7)
addi $t2, $t2, 4
addi $t7, $t7, 4

mergeChecks: #checks if either array is empty
beq $a1, $t1, shovelTwo #if array 1 has been depleted, shove the contents of array two into the completed array
beq $a1, $t2, shovelOne #if array 2 has been depleted, shove the contents of array one into the completed array
j mergeContinue #if not, continue merging as before

shovelOne:
add $t6, $a0, $t1
lw $t3, 0($t6)
sw $t3, 0($t7)
addi $t1, $t1, 4
addi $t7, $t7, 4
bne $a1, $t1, shovelOne #if array still has not been emptied, repeat, if not go to cleanup
j mergeCleanup

shovelTwo:
add $t6, $t5, $t2
lw $t4, 0($t6)
sw $t4, 0($t7)
addi $t2, $t2, 4
addi $t7, $t7, 4
bne $a1, $t2, shovelTwo #if array still has not been emptied, repeat, if not go to cleanup

mergeCleanup: #saves array in place it came from
sll $a1, $a1, 1 #multiply length by 2 to get to the full length of the array
addi $t2, $a0, 0 #destination address that will be incremented 
addi $t3, $0, 0 #length counter
mergeCleanupLoop:
lw $t1, 0($t0)
sw $t1, 0($t2)
addi $t0, $t0, 4
addi $t2, $t2, 4
addi $t3, $t3, 4
bne $t3, $a1, mergeCleanupLoop #if the output mem has been filled, move on

mergeReturn:
lw $ra, 0($sp)
addi $sp, $sp, 16 #return stack to previous state before being called
#if the array is of size 1, return to source to get merged
mergeReturnNoStack:#this exists for the 1 length arrays
jr $ra

exit:
halt
