###############################################################################
# USER DATA SEGMENT
###############################################################################

			.data

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
	## Get value of the memory mapped receiver control register. 
	##
	
	lw $t0, RECEIVER_CONTROL # Address of the memory mapped receiver control register.
	lw $t1, 0($t0)           # Content of the memory mapped receiver control register. 
	
	##
	## Get value of the memory mapped receiver data register. 
	##

	lw $t2, RECEIVER_DATA # Address of the memory mapped receiver data register. 
	lw $t3, 0($t2)        # Content of the memory mapped receiver data register. 
	
	##
	## Enable receiver interrupts
	##
	
	
	lw $t4, 0($t0)   	# Content of the memory mapped receiver control register. 
	ori $t5, $t4, 2         # Set the interrupt enable bit to 1. 
        sw $t5, 0($t0)		# Update the receiver controll register.
        
        nop	# No Operation (nop) - do nothing.
        nop	# No Operation (nop) - do nothing.
       
	# Use the MARS built-in system call (10) to terminate normally. 
	
	li $v0, 10
	syscall
	
	
###############################################################################
# INTERRUPT HANDLER
#
# For educational purposes we assume there will only be keyboard interrupts
# and no other interrupts or exceptions. 
###############################################################################	

		# The exception vector address for MIPS32.
   		
   		.ktext 0x80000180	
   		
__kbd_interrupt: 

	nop # Entering the interrupt handler.
	nop # Look at the value of EPC ($14 in Coprocessor 0).

	lw $k0, RECEIVER_DATA # Address of the memory mapped receiver data register. 
	lw $k1, 0($k0)        # Content of the memory mapped receiver data register. 
	
	eret # Resume execution at the address of EPC ($14 in Coprocessor 0)
	
