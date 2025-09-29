### Tests flushing from mispredictions ###
li $t0, 5
li $t1, 8

bne $t0, $t1, not
addi $t0, $t0, 5
sll $t2, $t1, 1
j next

not:
addi $t1, $t1, 7
srl $t3, $t0, 1

next:
beq $t0, $t1, notnot
addi $t0, $t0, 4
nor $t4, $t1, $t0
j exit

notnot:
not $t6, $t1
addi $t1, $t1, 6

exit:
halt