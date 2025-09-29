.data
.text
.globl main
main:
   #this is simply testing a common case to see if two registers contain the same value.
    # Start Test
    addi $1, $0, 7     #adding the value 7 to register 1
    addi $2, $0, 7     #adding the value 7 to register 2
nop
nop
    bne $2, $1,  exit #checking to see if both registers contain some value, if so exit.
nop
nop
add $1, $0, $0
    # End Test
exit:
    # Exit program
    halt
