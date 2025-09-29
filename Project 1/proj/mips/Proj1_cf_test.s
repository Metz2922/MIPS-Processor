######Call stack of 5 Program######
li   $t0, 5          # Set recursion depth to 5
addi $sp, $0, 0x7fffeffc # Set stack pointer so mars agrees with processor
jal  func1           # Jump to first layer
j end                # Jump to the end

func1:
# Call 1
addi $sp, $sp, -8    # Adjust stack to store return address and saved register
sw   $ra, 4($sp)     # Save return address
    
# Decrease depth
addi $t0, $t0, -1
beq  $t0, $zero, return_func1 # If depth is 0, return

# Call next function in the call chain
jal  func2           # Jump to func2 (second level)

return_func1:
lw   $ra, 4($sp)     # Restore return address
addi $sp, $sp, 8     # Restore stack
jr   $ra             # Return to the caller

func2:
# Second level
addi $sp, $sp, -8    # Adjust stack
sw   $ra, 4($sp)     # Save return address
sw   $a0, 0($sp)     # Save argument

addi $t0, $t0, -1
beq  $t0, $zero, return_func2

jal  func3           # Jump to third level

return_func2:
lw   $ra, 4($sp)     # Restore return address
lw   $a0, 0($sp)     # Restore argument
addi $sp, $sp, 8     # Restore stack
jr   $ra             # Return to the caller

func3:
# Third level
addi $sp, $sp, -8    # Adjust stack
sw   $ra, 4($sp)     # Save return address
sw   $a0, 0($sp)     # Save argument
    
addi $t0, $t0, -1
beq  $t0, $zero, return_func3

jal  func4           # Jump to func4 (fourth level)

return_func3:
lw   $ra, 4($sp)     # Restore return address
lw   $a0, 0($sp)     # Restore argument
addi $sp, $sp, 8     # Restore stack
jr   $ra             # Return to the caller

func4:
# Fourth level
addi $sp, $sp, -8    # Adjust stack
sw   $ra, 4($sp)     # Save return address
sw   $a0, 0($sp)     # Save argument
    
addi $t0, $t0, -1
beq  $t0, $zero, return_func4

jal  func5           # Jump to func5 (fifth level)

return_func4:
lw   $ra, 4($sp)     # Restore return address
lw   $a0, 0($sp)     # Restore argument
addi $sp, $sp, 8     # Restore stack
jr   $ra             # Return to the caller

func5:
# Fifth and final level of recursion
addi $sp, $sp, -8    # Adjust stack
sw   $ra, 4($sp)     # Save return address
sw   $a0, 0($sp)     # Save argument

# Check if we've reached the end
addi $t0, $t0, -1
beq  $t0, $zero, return_func5  # If depth is 0, return

# We shouldn't reach here, if we do something went wrong
addi $t1, $0, 300

return_func5:
lw   $ra, 4($sp)     # Restore return address
lw   $a0, 0($sp)     # Restore argument
addi $sp, $sp, 8     # Restore stack
jr   $ra             # Return to the caller

end:
halt
