.data
.text
.globl main
main:
# This test is an edge case to see if you can jr if the register holds the first possible address of an instruction
#It is important to see if you can jump to begging of code
    # Start Test
    addi $1, $0, 1
    nop
    nop
    beq $1, $2, end
nop
nop
    lui $1, 0x0040 # Loading edge case of initial program memory location
    addi $2,$0,1 # Change beq to true
nop
    jr $1 #Jump to the initial program memory location
nop
nop
    # End Test
	end:
    # Exit program
    halt
