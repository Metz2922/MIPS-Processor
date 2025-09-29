main:
	addi $s0, $0, 0x1001
	addi $t0, $0, 0x1011
	nop
	nop
	slt $t0, $0, $s0
	sra $s0, $s0, 2
	nop
	nop
	lui $s0, 0x1234
	j exit
	nop
	nop
exit:
	halt

