# Este arquivo contem procedimentos para efetuar o movimento dos personagens no labirinto

# TEST
.data
	.space 4096

.include "../graph/data.bin"
.include "../display/screen.asm"
.include "../system/point.asm"


.include "pacman.asm"
.include "ghost_blue.asm"
.include "ghost_red.asm"
.include "ghost_orange.asm"
.include "ghost_pink.asm"

# Procedimento para efetuar um delay
# %pause_time		-> inteiro que representa o tempo para pausa em milissegundos
.macro sleep (%pause_time)
	# Push to stack
	addi $sp, $sp, -8
	sw $a0, 0($sp)
	sw $v0, 4($sp)
	# Push to stack
	
	addi $a0, $zero, %pause_time
	addi $v0, $zero, 32 		# Syscall value for sleep
	syscall
	
	# Pop from stack
	addi $sp, $sp, 8
	lw $a0, 0($sp)
	lw $v0, 4($sp)
	# Pop from stack
.end_macro

# TEST
.text

li $s0, 0x10010000
li $s1, 256
la $s2, graph

draw_maze ($s0, $s2, $s1)

addi $s3, $s2, 576
addi $s4, $s2, 480


sleep (1000)
move_blue_left ($s3)
move_red_right ($s4)
sleep (1000)
move_blue_left ($s3)
move_red_right ($s4)
sleep (1000)

move_blue_down ($s3)
move_red_right ($s4)
sleep (1000)
move_blue_down ($s3)
move_red_right ($s4)
sleep (1000)

move_blue_right ($s3)
move_red_down ($s4)
sleep (1000)
move_blue_right ($s3)
move_red_down ($s4)
sleep (1000)

move_blue_up ($s3)
move_blue_up ($s3)

move_blue_left ($s3)
move_blue_left ($s3)

move_blue_down ($s3)
move_blue_down ($s3)

move_blue_right ($s3)
move_blue_right ($s3)

move_blue_up ($s3)
move_blue_up ($s3)
