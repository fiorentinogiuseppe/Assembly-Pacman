.data

	.space 4096
	.include "graph/data.bin"
	.include "display/screen.asm"
	.include "system/point.asm"
	.include "system/utils.asm"
	.include "motion/motion.asm"
	gameSpeed:	.word 100

.text
ClearRegisters:

	li $v0, 0
	li $a0, 0
	li $a1, 0
	li $a2, 0
	li $a3, 0
	li $t0, 0
	li $t1, 0
	li $t2, 0
	li $t3, 0
	li $t4, 0
	li $t5, 0
	li $t6, 0
	li $t7, 0
	li $t8, 0
	li $t9, 0
	li $s0, 0
	li $s1, 0
	li $s2, 0
	li $s3, 0
	li $s4, 0		
main: 


li $s0, 0x10010000
li $s1, 256
la $s2, graph

draw_maze ($s0, $s2, $s1)

addi $s3, $s2, 480
	
InputCheck:
	lw $a0, gameSpeed
	sleep (500)

	# Get the input from the keyboard
	read_keyboard ($t1)

	# Move
	   bne  $t1, 119, move_down
	   move_up($s3)
move_down: bne  $t1, 115, move_left
	   move_down($s3)
move_left: bne  $t1, 97, move_right
	   move_left($s3)
move_right:bne  $t1, 100, continue
           move_right($s3)
           continue:
           
     
j InputCheck

Pause:
	li $v0, 32 #syscall value for sleep
	syscall
	jr $ra
