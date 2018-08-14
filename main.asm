.data

	.space 16384

	.include "graph/data.bin"
	.include "display/screen.asm"
	.include "system/point.asm"
	.include "system/utils.asm"
	.include "motion/motion.asm"
	gameSpeed:	.word 100

.text

# set random seed
li $a0, 1	#
li $a1, 7	# set seed
li $v0, 40	#
syscall

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

# Loop

li $s0, 0x10010000	# Endereco inicial
li $s1, 4096		# 64 x 64 = 4096 Pixels		
la $s2, graph		# Endereco do grafo

# <$a0> Fantasma azul
# <$a1> Fantasma vermelho
# <$a2> Fantasma laranja
# <$a3> Fantasma rosa

# <$s3> Pacman
li $s3, 31440
add $s3, $s3, $s2
li $a0, 46800
add $a0, $a0, $s2
li $a1, 62160
add $a1, $a1, $s2
li $a2, 77520
add $a2, $a2, $s2
li $a3, 92880
add $a3, $a3, $s2

# <$s4> Quantidade de vidas
addi $s4, $zero, 3

# <$s5> Quantidade de pontos
add $s5, $zero, $zero

# <$s6> Quantidade de pac dots por estagio
add $s6, $zero, $zero

draw_maze ($s0, $s2, $s1)

li $t1, 4
default_position ($s3, $a0, $a1, $a2, $a3)
	
main_stage_one:
	sleep (500)

	# Pintar na tela pontuacao
	
	
	# Pintar na tela vidas
	li $t0, 14752
	add $t0, $t0, $s0
	draw_life_number ($t0, $s4)
	

	# Get the input from the keyboard
	read_keyboard ($t1)

	# Move Pac man
	bne  $t1, 119, move_down_stage_one
	move_up($s3, $s5, $s6)
move_down_stage_one:
	bne  $t1, 115, move_left_stage_one
	move_down($s3, $s5, $s6)
move_left_stage_one:
	bne  $t1, 97, move_right_stage_one
	move_left($s3, $s5, $s6)
move_right_stage_one:
	bne  $t1, 100, continue_stage_one
        move_right($s3, $s5, $s6)
continue_stage_one:

	# mover fantasmas
	collision_detection ($s3, $a0, $a1, $a2, $a3, $s4)
	move_blue_ghost ($a0)
	collision_detection ($s3, $a0, $a1, $a2, $a3, $s4)
	move_red_ghost ($a1)
	collision_detection ($s3, $a0, $a1, $a2, $a3, $s4)
	move_orange_ghost ($a2)
	collision_detection ($s3, $a0, $a1, $a2, $a3, $s4)
	move_pink_ghost ($a3)
	collision_detection ($s3, $a0, $a1, $a2, $a3, $s4)
	
	# Verificacao fim de jogo ou de estagio
        beq $s4, $zero, main_game_over			# Fim de jogo vidas acabadas
        
        beq $s6, 1, main_stage_one_end		# Fim de estagio comidas 100 pac dots

j main_stage_one
main_stage_one_end:

sleep (2000)	# Time

add $s6, $zero, $zero				# Zerar a quantidade de pac dots por estagio
default_position ($s3, $a0, $a1, $a2, $a3)	# Reposicionar o pacman e os fantasmas nas suas respectivas posicoes default

main_stage_two:
	sleep (500)

	# Pintar na tela pontuacao
	
	
	# Pintar na tela vidas
	li $t0, 14752
	add $t0, $t0, $s0
	draw_life_number ($t0, $s4)
	

	# Get the input from the keyboard
	read_keyboard ($t1)

	# Move Pac man
	bne  $t1, 119, move_down_stage_two
	move_up($s3, $s5, $s6)
move_down_stage_two:
	bne  $t1, 115, move_left_stage_two
	move_down($s3, $s5, $s6)
move_left_stage_two:
	bne  $t1, 97, move_right_stage_two
	move_left($s3, $s5, $s6)
move_right_stage_two:
	bne  $t1, 100, continue_stage_two
        move_right($s3, $s5, $s6)
continue_stage_two:

	# mover fantasmas
	collision_detection ($s3, $a0, $a1, $a2, $a3, $s4)
	move_blue_ghost ($a0)
	collision_detection ($s3, $a0, $a1, $a2, $a3, $s4)
	move_red_ghost ($a1)
	collision_detection ($s3, $a0, $a1, $a2, $a3, $s4)
	move_orange_ghost ($a2)
	collision_detection ($s3, $a0, $a1, $a2, $a3, $s4)
	move_pink_ghost ($a3)
	collision_detection ($s3, $a0, $a1, $a2, $a3, $s4)
	
	# Verificacao fim de jogo ou de estagio
        beq $s4, $zero, main_game_over			# Fim de jogo vidas acabadas
        
        beq $s6, 100, main_stage_one_end		# Fim de estagio comidas 100 pac dots

j main_stage_two
main_stage_two_end:

main_game_over:
