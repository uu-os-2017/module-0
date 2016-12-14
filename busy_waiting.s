###############################################################################
# USER DATA SEGMENT
###############################################################################

			.data

# Strings used by the jobs to print messages to the Run I/O pane. 

PRESS_ANY_KEY:		.asciiz "Press any key to continue: "
NL:			.asciiz "\n"

# Memory addresses of the memory mapped receiver registers. 

RECEIVER_CONTROL:	.word 0xffff0000
RECEIVER_DATA:		.word 0xffff0004

###############################################################################
# MAIN
#
# MARS start to execute at label main in the .text segment.
###############################################################################

			.globl main
			.text

main:
	# Use MARS built-in system call 4 (print string) to print "Press any key ..."
	
	li $v0, 4              # System call code 4 (print string)
	la $a0, PRESS_ANY_KEY  # Address of string to print
	syscall                
	

poll_receiver: 

	## 
	## Get value of the memory mapped receiver control register. 
	##
	
	lw $t0, RECEIVER_CONTROL # Address of the memory mapped receiver control register.
	lw $t1, 0($t0)           # Content of the memory mapped receiver control register. 
	
	li $t2, 0
	
	##
	## Check if a new character is available, i.e., check if the receiver is ready. 
	## 
	
	# TODO 1: Set $t2 to 1 if bit 0 (receiver ready) of receiver control
	# is set to 1, otherwise set $t2 to 0. 
	
	# TIP: Use the andi (And immediate) instruction.
	
	
	##
	## TODO 2: Keep polling until the receiver is ready. 
	##
	
	# TIP: Use the beqz (Branch Equal Zero) instruction. 
	
	
	# The receiver is now ready. 
	
	li $t4, 63 # ASCII value of '?'.
	
	##
	## TODO 3: Store the  ASCII value of pressed key in $t4.
	##

	# TIP: The ASCII value of the pressed key is now available in the memory
	# mapped receiver data register. 
	
	# TIP: Use the same techinique as when loading the value of the memory mapped receiver control registe.r 
	
	
	##
	## Use the MARS built-in system call 11 (print char) to print the character of the pressed key. 
	##
	
	move $a0, $t4
	li $v0, 11
	syscall

	# Use the MARS built-in system call 4 (print string) to print a new-line. 
	
	li $v0, 4
	la $a0, NL
	syscall
	
	##
	## TODO 4: Jump back to label main until the user presses `q` on the keyboard. 
	##
	
	# TIP 1: ASCII value of `q` = 113.
	
	# TIP 2: Use the bne (Branch Not Equal) instruction. 
	
	
	# Use the MARS built-in system call (10) to terminate normally. 
	
	li $v0, 10
	syscall
	
