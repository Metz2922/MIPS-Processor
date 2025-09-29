####### a simple test ############
# test all supported instructions, avoiding all data hazards
# add, addi, addiu, addu, and, andi, lui, lw, nor, xor, xori, or,
# ori, slt, slti, sll, srl, sra, sw, sub, subu, beq, bne, j, jal, jr

main:

xori $t6, $0, 15
lui $t0, 0x1001
ori $t1, $0, 8
sub $t5, $0, $t6
subu $t6, $t6, $t0
addi $t2, $0, 4
addiu $t3, $0, 50
add $t0, $t0, $t1
addu, $t2, $t2, $t1
sll $t5, $t5, 2
sw $t3, 0($t0)
and $t7, $t6, $t3
andi $t2, $t2, 16
srl $t5, $t5, 2
lw $t7, 0($t0)
nor $t8, $t6, $t1
xor $t5, $t5, $t2
or $t0, $t0, $t7
lui $1,0x1001
beq $0, $0, branchval
nop
nop
continue1:
slt $t9, $t1, $t3
slti $t8, $t3, 1
sra $t4, $t4, 1
bne $t9, $t5, branchval2
nop
nop
continue2:
jal jalval
nop
j exit
nop

jalval:
nop
jr $ra
nop
nop

branchval:
j continue1
nop

branchval2:
j continue2
nop

exit:
halt