# Este arquivo contem procedimentos para a partir do grafo pintar o quadro na tela

.data
	.space 4096

.include "../graph/data.bin"


# Procedimento para "pintar" os pixels na tela de acordo com o grafo
# %initial_address	-> registrador que contem endereco da posicao inicial ser "pintada"
# %graph_address	-> registrador que contem endereco da posicao inicial do grafo
# %total_number_pixels	-> registrador que contem numero total de pixels a serem "pintados"
.macro draw_maze (%initial_address, %graph_address, %total_number_pixels)
	# Push to stack
	addi $sp, $sp, -24
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	# Push to stack
	
	add $s5, $zero, %total_number_pixels	# <$s5> sera utilizado para armazenar o numero total de pixels
	add $s1, $zero, %initial_address	# <$s1> sera utilizado para armazenar endereco de onde salvar os pixels
	add $s2, $zero, %graph_address		# <$s2> sera utilizado para armazenar endereco os nos do grafo em questao
	add $s0, $zero, $zero			# <$s0> sera utilizado para contar as iteracoes
	draw_maze_loop:
		bge $s0, $s5, draw_maze_loop_end	# Se foi atingido o numero total de pixels
		
		lw $s3, 0($s2)				# Carregar o valor do no atual do grafo
		
		# Verificar se o no e um muro
		bne $s3, 0x4, draw_maze_loop_not_wall	# O no atual nao e um muro
		li $s4, 0x002d32b8			# Carregar o valor da cor do muro
		sw $s4, 0($s1)				# "Pintar" o pixel
		j draw_maze_loop_finalization
		
		draw_maze_loop_not_wall:
		
		# Verificar se o no e um espaco vazio
		bne $s3, 0x0, draw_maze_loop_not_empty_space	# O no atual nao e um espaco vazio
		li $s4, 0x00000000				# Carregar o valor da cor do espaco vazio
		sw $s4, 0($s1)					# "Pintar" o pixel
		j draw_maze_loop_finalization
		
		draw_maze_loop_not_empty_space:
		
		# Verificar se o no e um pac dot
		bne $s3, 0x1, draw_maze_loop_not_pac_dot	# O no atual nao e um pac dot
		li $s4, 0x00ffffff				# Carregar o valor da cor do pac dot
		sw $s4, 0($s1)					# "Pintar" o pixel
		j draw_maze_loop_finalization
		
		draw_maze_loop_not_pac_dot:
		
		# TODO adicionar demais possiveis valores
		
		draw_maze_loop_finalization:
		addi $s1, $s1, 4	# Preparar <$s1> para salvar no proximo pixel
		addi $s2, $s2, 20	# Preparar <$s2> para carregar proximo no do grafo
		addi $s0, $s0, 1	# Incrementar contador <$s0> de pixels
		j draw_maze_loop
	draw_maze_loop_end:
	
	# Pop from stack
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw $s5, 20($sp)
	addi $sp, $sp, 24
	# Pop from stack

.end_macro


.text
li $s0, 0x10010000
li $s1, 4096
la $s2, graph

draw_maze($s0, $s2, $s1)