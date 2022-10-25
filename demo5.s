.data
initial_prompt: .asciiz "Enter a letter: "
uppercase_message: .asciiz "The letter in uppercase is: "
lowercase_message: .asciiz "The letter in lower case is: "
toggle_message: .asciiz "The letter in toggled case is: "
nl: .asciiz "\n"
.text
main:
	# Print the initial prompt
	li $v0, 4
	la $a0, initial_prompt
	syscall

	# Read the letter
	li $v0, 12
	syscall

	# store the letter in $t0
	move $t0, $v0

	# determine the case of the letter from its binary representation
	# using bitwise AND
	# an uppercase letter will be 0 well a lowercase letter will be 32
	# 32 is 100000 in binary
	andi $t1, $t0, 32

	# print a new line
	li $v0, 4
	la $a0, nl
	syscall
	# branch to the appropriate case
	beq $t1, $0, uppercase

	# print the lowercase message
	li $v0, 4
	la $a0, lowercase_message
	syscall

	# copy the letter into $t2 
	move $t2, $t0
	# make the letter uppercase using bitwise AND
	# 223 is 11011111 in binary
	andi $t2, $t2, 223

	# print the uppercase letter
	li $v0, 11
	move $a0, $t2
	syscall
	j end



uppercase:
	# print uppercase message 
	li $v0, 4
	la $a0, uppercase_message
	syscall

	# copy the letter into $t2
	move $t2, $t0
	# make the letter uppercase using bitwise OR
	# 32 is 100000 in binary
	ori $t2, $t2, 32

	# print the lowercase letter
	li $v0, 11
	move $a0, $t2
	syscall



end:
	# print a newline
	li $v0, 4
	la $a0, nl
	syscall

	# toggle the case of the letter in $t0 
	xori $t0, $t0, 32

	# print the toggle message
	li $v0, 4
	la $a0, toggle_message
	syscall

	# print the toggled letter
	li $v0, 11
	move $a0, $t0
	syscall

	# Exit 
	li $v0, 10
	syscall
