### Test Jumps for instruction fetch clearing ###
j continue
addi $t0, $0, 4
addi $t1, $0, 6

continue:
sll $t2, $0, 6

exit:
halt