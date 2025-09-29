### Tests Branch Prediction ###
### Also tests if correct prediction execution is used and not flushed indescriminately ###
li $t0, 68
li $t1, 67

bne $t0, $t1, not
addi $t0, $t0, 5
j next

not:
addi $t1, $t1, 7

next:
beq $t0, $t1, notnot
addi $t0, $t0, 4
j exit

notnot:
addi $t1, $t1, 6

exit:
halt