main:
	addi $s0, $0, 0x1001
	addi $t0, $0, 0x1011
	slt $t0, $0, $s0
	sra $s0, $s0, 2
	lui $s0, 0x1234
	j exit
exit:
	halt

