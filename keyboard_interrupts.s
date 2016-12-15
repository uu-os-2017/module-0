###############################################################################
# USER DATA SEGMENT
###############################################################################

			.data

# Strings used to print messages to the MARS Run I/O console. 

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
	##
	## Enable keyboard interrupts. 
	##
	
	# Address of the memory mapped receiver controll register.
  	
  	lw $t0, RECEIVER_CONTROL	
  	
  	# Get value of the receiver controll register.
  	
  	lw $t1, 0($t0)			
  	
	# TODO 1: Set bit 1 (interrupt enable) in receiver control to 1.
	
	# TIP: Use the ori (Or Immediate) instruction. 
	
	# TIP: What bitmask do you need to use?
	
	# TIP: Translate the bitmask to a decimal or hexadecimal number. 

        	
        # TODO 2: Update the receiver controll register.

	# TIP: Use sw (Store Word) instruction.
	
        sw $t2, 0($t0)
       
        # In MARS the status register is set to 0x0000ff11 on start-up, i.e., 
        # the interrupt enable bit (bit 0) is alredy set and all interrupt 
        # mask (bits 8-15) bits are set. 
        
        # If you use SPIM, the status register is set to 0x3000ff10 start-up, 
        # i.e., the interrupt enable (bit 0) is not set but all interrupt mask
        # bits (bits 8-15) are set. 
        
        # If you use SPIM you must enable interrupts by setting the interrupt
        # enable bit in the Status register to 1. 
	
	##
	## Use MARS built-in system call 4 (print string) to print "Press any key ..". 
	##

	li $v0, 4
	la $a0, PRESS_ANY_KEY
	syscall

	##
	## Enter infinite loop.
	##
	
infinite_loop: 

	addi $s0, $s0, 1
	
	j infinite_loop


###############################################################################
# KERNEL
# 
# The kernel handles all exceptions and interrupts.
#
# For educational purposes we asume the only reason for entering the kernel 
# is a keyboard interrupt. 
# 
# For simplicity, the user level program only uses $s0, hence the kernel may
# use any registers but $s0. 
###############################################################################
   
   		# The exception vector address for MIPS32.
   		
   		.ktext 0x80000180	
   
__kernel:
	
	# Asume the kernel is entered due to a keyboard interrupt. 
	
	# When an exception or interrupt occurs, the value of the program counter 
	# ($pc) of the user level program is automatically stored in the exception 
	# program counter (ECP), the $14 in Coprocessor 0. 
		
	##
	## Get ASCII value of pressed key from the memory mapped receiver data register. 
	##

	# TODO 3: Store content of the memory mapped receiver data register in $k1.
	
	
	# Use the MARS built-in system call 11 (print char) to print the character
	# from receiver data.

	move $a0, $k1
	li $v0, 11
	syscall
	
	# Use the MARS built-in system call 4 (print string) to print a new-line. 
	
	li $v0, 4
	la $a0, NL
	syscall
	
	# Use the MARS built-in system call 4 (print string) to print "Press any key ..". 
	
	li $v0, 4
	la $a0, PRESS_ANY_KEY
	syscall

	# Resume execution at the address stored in EPC.
	
	eret # Look at the value of $14 in Coprocessor 0 before single stepping.
