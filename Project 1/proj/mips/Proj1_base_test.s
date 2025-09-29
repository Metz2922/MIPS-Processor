######Test of MIPS Processor#######
#add, addi, addiu, addu, and, andi, 
#lui, lw, nor, xor, xori, or,
#ori, slt, slti, sll, srl, sra, 
#sw, sub, subu, beq, bne, j, jal, jr
li $t0, 10 
li $t1, 20 
li $t2, 30 
li $t3, 40 
li $t4, 0xF0F0F0F0 
li $t5, 0x0F0F0F0F 
li $t6, 0x10010030

sw $t4, 0($t6)

# Add and sub 
add $t6, $t0, $t1     # $t6 = $t0 + $t1 = 10 + 20 = 30 
sub $t7, $t6, $t2     # $t7 = $t6 - $t2 = 30 - 30 = 0 
addu $t8, $t3, $t0     # $t8 = $t3 + $t0 = 40 + 10 = 50 
subu $t9, $t3, $t1     # $t9 = $t3 - $t1 = 40 - 20 = 20 

# JAL
jal Logical

# Addi 
addi $s0, $t0, 5       # $s0 = $t0 + 5 = 10 + 5 = 15 
addi $s0, $t0, -5      # $s0 = $t0 + -5 = 10 - 5 = 5
addiu $s0, $s0, -5     # $s0 = $s0 + -5 = 5 - 5 = 0
slti $s1, $t0, 15      # $s1 = ($t0 < 15) ? 1 : 0 = 1
repl.qb $s2, 0x1F

# Logical Immediate
andi $s2, $t4, 0x0F0F0F0F # $s2 = $t4 & 0x0F0F0F0F = 0xF0F0F0F0 & 0x0F0F0F0F = 0x00000000 
ori $s3, $t4, 0x0F0F0F0F  # $s3 = $t4 | $t5 = 0xF0F0F0F0 | 0x0F0F0F0F = 0xFFFFFFFF 
xori $s4, $t4, 0x0F0F0F0F # $s4 = $t4 ^ $t5 = 0xF0F0F0F0 ^ 0x0F0F0F0F = 0xFFFFFFFF 

# Shift Operations 
sll $s6, $t0, 2       # $s6 = $t0 << 2 = 10 << 2 = 40 
srl $s7, $t4, 4       # $s7 = $t4 >> 4 = 0x0F0F0F0F 
sra $t0, $t3, 1       # $t0 = $t3 >>> 1 = 40 >> 1 = 20 

# Lw, Sw Test
li $t6, 0x10010030
lw $t2, 0($t6)

# Branches 
bne $t0, $t1, end    # If $t0 == $t1, fail (should not jump) 
beq $t0, $t1, pass    # If $t0 != $t7, jump over add, tripping mars difference(should jump) 
addi $t6, $t0, 4 

pass: 
j end 

Logical: 
and $s2, $t4, $t5     # $s2 = $t4 & $t5 = 0xF0F0F0F0 & 0x0F0F0F0F = 0x00000000 
or $s3, $t4, $t5     # $s3 = $t4 | $t5 = 0xF0F0F0F0 | 0x0F0F0F0F = 0xFFFFFFFF 
xor $s4, $t4, $t5     # $s4 = $t4 ^ $t5 = 0xF0F0F0F0 ^ 0x0F0F0F0F = 0xFFFFFFFF 
nor $s5, $t4, $t5     # $s5 = ~($t4 | $t5) = ~(0xF0F0F0F0 | 0x0F0F0F0F) = 0x00000000 
jr $ra

end: 
halt
