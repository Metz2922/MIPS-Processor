######Bubble Sort########
#.data
#array: .word 9, 3, 7, 1, 8, 5, 4, 2, 6 #Example unsorted array
#n:     .word 9   #Number of elements in array

main:
# Load array size
addi $t0, $0, 9		 # Size of array = 9

# Load array base address and values into array
# base address arbitrarily chosen because .data was causing the program to act up
li   $t1, 0x10010000

li   $t2, 9
sw   $t2, 0($t1)

li   $t2, 3
sw   $t2, 4($t1)

li   $t2, 7
sw   $t2, 8($t1)

li   $t2, 1
sw   $t2, 0xC($t1)

li   $t2, 8
sw   $t2, 0x10($t1)

li   $t2, 5
sw   $t2, 0x14($t1)

li   $t2, 4
sw   $t2, 0x18($t1)

li   $t2, 2
sw   $t2, 0x1C($t1)

li   $t2, 6
sw   $t2, 0x20($t1)

outer_loop:
add  $t2, $0, $0   # i = 0
sub  $t3, $t0, $t2  # set limits of j loop
addi $t3, $t3, -1  # $t3 = n - i - 1

inner_loop:
beq  $t3, $0, outer_loop_end # If j >= n-i-1, end inner loop
sll  $t4, $t2, 2	     # Array index
add  $t5, $t1, $t4	     # $t5 = offset = base address
lw   $t6, 0($t5)	     # $t6 = array[j]
lw   $t7, 4($t5) 	     # $t7 = array[j+1]
ble  $t6, $t7, no_swap	     # If array[j] >= array[j+1], no swap
sw   $t7, 0($t5)	     # swap
sw   $t6, 4($t5)	     # swap

no_swap:
addi $t2, $t2, 1	     # increment
addi $t3, $t3, -1	     # update condition
j inner_loop		     # next loop

outer_loop_end:
addi $t0, $t0, -1	     # iterate
bgt  $t0, $0, outer_loop     # if looping is not done, back to start
j exit

exit:
halt
