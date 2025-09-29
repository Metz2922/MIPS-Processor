main:
addi $t0, $0, 3
nop
addi $t1, $0, 0
nop
addi $t1, $t0, 1 # check if t0 has 3
nop
j label
	nop
	nop
halt

label:
addi, $t0, $0, 1 #if $t0 is 1 jump succeded
halt

