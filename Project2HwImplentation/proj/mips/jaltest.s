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
end:
	j exit
	nop
	nop
sequence:
	subi $s0, $s0, 2
	j end
	nop
	nop
exit:
	halt

