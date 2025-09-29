### LOAD HAZARD TEST ###
li $t0, 29
li $t1, 0x10010000
sw $t0, 0($t1)
lw $t2, 0($t1)
addi $t3, $t2, 5

halt