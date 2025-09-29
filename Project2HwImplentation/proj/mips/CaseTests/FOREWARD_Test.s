### Forewarding test, should skip mem stage for applicable lines ###
li $t0, 5
li $t1, 6
li $s0, 0x10011000

add $t2, $t1, $t0
addi $t1, $t1, 3

sw $t2, 0($s0)

exit:
halt