main:
	addi  $1,  $0,  1 		# Place â1â? in $1
	addi  $2,  $0,  2		# Place â2â? in $2
	addi  $3,  $0,  3		# Place â3â? in $3
	addi  $4,  $0,  4		# Place â4â? in $4
	sub $5, $4, $1

nop
nop
nop

exit:
	halt

