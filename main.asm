.data

	.space 16384

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


li $s0, 0x10010000	# Endereco inicial
li $s1, 16384		# 64 x 64 x 4 = 4096 Pixels x 4 bytes		
la $s2, graph		# Endereco do grafo

# <$a0> Fantasma azul
# <$a1> Fantasma vermelho
# <$a2> Fantasma laranja
# <$a3> Fantasma rosa

# <$s3> Pacman
addi $s3, $s2, 480	# TODO adicionar o endereco do pacman no grafo

addi $a0, $s3, 24
addi $a1, $a0, 24
addi $a2, $a1, 24
addi $a3, $a2, 24

# <$s4> Quantidade de vidas
addi $s4, $zero, 3

# <$s5> Quantidade de pontos
add $s5, $zero, $zero

# <$s6> Quantidade de pac dots por estagio
add $s6, $zero, $zero

draw_maze ($s0, $s2, $s1)


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
	move_blue_ghost ($a0)
	move_red_ghost ($a1)
	move_orange_ghost ($a2)
	move_pink_ghost ($a3)
	
	collision_detection ($s3, $a0, $a1, $a2, $a3, $s4)
	
	# Verificacao fim de jogo ou de estagio
        beq $s4, $zero, main_game_over			# Fim de jogo vidas acabadas
        
        beq $s6, 100, main_stage_one_end		# Fim de estagio comidas 100 pac dots

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
	move_blue_ghost ($a0)
	move_red_ghost ($a1)
	move_orange_ghost ($a2)
	move_pink_ghost ($a3)
	
	collision_detection ($s3, $a0, $a1, $a2, $a3, $s4)
	
	# Verificacao fim de jogo ou de estagio
        beq $s4, $zero, main_game_over			# Fim de jogo vidas acabadas
        
        beq $s6, 100, main_stage_one_end		# Fim de estagio comidas 100 pac dots

j main_stage_two
main_stage_two_end:

main_game_over:
