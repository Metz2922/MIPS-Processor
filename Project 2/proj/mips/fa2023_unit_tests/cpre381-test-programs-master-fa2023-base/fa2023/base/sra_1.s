.data
.text
.globl main
main:
	# This file is designed to test that each type of average case works with the sra instruction.
	# Start Test
	# Test 1: Check a positive even number 30, expected result: 15
	addi $t0, $0, 30
nop
nop
	sra $t0, $t0, 1
	nop
nop
	# Test 2: Check a positive odd number 15, expected result: 7
	sra $t0, $t0, 1
	nop
nop
	# Test 3: Keep shifting right, expected result: 3
	sra $t0, $t0, 1
	nop
nop
	# Test 4: Keep shifting right, expected result: 1
	sra $t0, $t0, 1
	nop
nop
	# Test 5: Keep shifting right, expected result: 0
	sra $t0, $t0, 1
	nop
nop
	# Test 6: Check a negative even number -50, expected result: -25
	addi $t0, $0, -50
nop
nop
	sra $t0, $t0, 1
	nop
nop
	# Test 7: Check a negative odd number -25, expected result : -13
	sra $t0, $t0, 1
	nop
nop
	# Test 8: Keep shifting right, expected result: -7
	sra $t0, $t0, 1
	nop
nop
	# Test 9: Keep shifting right, expected result: -4
	sra $t0, $t0, 1
	nop
nop
	# Test 10: Keep shifting right, expected result: -2
	sra $t0, $t0, 1
	nop
nop
	# Test 11: Keep shifting right, expected result: -1
	sra $t0, $t0 1
	nop
nop
	# End Test
	#Exit Program
	halt
