# Este arquivo contem procedimentos para efetuar o movimento dos personagens no labirinto

# TEST
#.data
#	.space 4096
#
#.include "../graph/data.bin"
#.include "../display/screen.asm"
#.include "../system/point.asm"

# Procedimento para mover o pac man para direita
# %pacman_position	-> registrador que contem a posicao do no onde esta o pacman
# Ao final do procedimento o registrador %pacman_position
# contera o endereco para nova posicao do pacman no grafo
.macro move_right (%pacman_position)
	# Push to stack
	addi $sp, $sp, -20
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw %pacman_position, 16($sp)
	# Push to stack
	
	add $s0, $zero, %pacman_position	# <$s0> armazenara o endereco do no onde o pacman esta
	
	lw $s1, 8($s0)				# 
	add $s1, $s0, $s1			# <$s1> armazenara o endereco do no da direita
	
	lw $s3, 0($s1)				# <$s3> armazenara o valor do no da direita
	# Verificar se o elemento a direita e uma parede
	beq $s3, 0x4, move_right_finalization		# Se o no da direita e parede fazer nada
	
	# Verificar se o elemento a direita e um pac dot
	bne $s3, 0x1, move_right_not_pac_dot		# Se o no da direita nao e um pac dot fazer nada
	# ... move right pac dot procedure
	sw $zero, 0($s0)				# Mudar o conteudo do no anterior para espaco vazio
	addi $s2, $zero, 0x2
	sw $s2, 0($s1)					# Mudar o conteudo do no da direita para pac man
	lw $s3, 20($s0)
	sw $zero, 0($s3)				# Pintar o pixel onde o pacman estava para espaco vazio
	li $s2, 0x00ffff3c				#
	lw $s3, 20($s1)
	sw $s2, 0($s3)					# Pintar o pixel a direita com o pacman
	sw $s1, 16($sp)					# Modificar a posicao do pacman para o no da direita, quando for carregado da stack o valor sera o atualizado
	increment_point($k0, 10)			# Incrementar a pontuacao de 10 unidades
	j move_right_finalization
	move_right_not_pac_dot:
	
	# Verificar se o elemento a direita e um espaco vazio
	bne $s3, 0x0, move_right_not_empty_space	# Se o no da direita nao e um espaco fazer nada
	sw $zero, 0($s0)				# Mudar o conteudo do no anterior para espaco vazio
	addi $s2, $zero, 0x2
	sw $s2, 0($s1)					# Mudar o conteudo do no da direita para pac man
	lw $s3, 20($s0)
	sw $zero, 0($s3)				# Pintar o pixel onde o pacman estava para espaco vazio
	li $s2, 0x00ffff3c				#
	lw $s3, 20($s1)
	sw $s2, 0($s3)					# Pintar o pixel a direita com o pacman
	sw $s1, 16($sp)					# Modificar a posicao do pacman para o no da direita, quando for carregado da stack o valor sera o atualizado
	j move_right_finalization
	move_right_not_empty_space:
	
	
	# ... procedimento para toque em fantasma
	
	
	move_right_finalization:
	
	
	# Pop from stack
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw %pacman_position, 16($sp)
	addi $sp, $sp, 20
	# Pop from stack
.end_macro


#############################################################
#############################################################
#############################################################


# Procedimento para mover o pac man para cima
# %pacman_position	-> registrador que contem a posicao do no onde esta o pacman
# Ao final do procedimento o registrador %pacman_position
# contera o endereco para nova posicao do pacman no grafo
.macro move_up (%pacman_position)
	# Push to stack
	addi $sp, $sp, -20
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw %pacman_position, 16($sp)
	# Push to stack
	
	add $s0, $zero, %pacman_position	# <$s0> armazenara o endereco do no onde o pacman esta
	
	lw $s1, 4($s0)				# 
	add $s1, $s0, $s1			# <$s1> armazenara o endereco do no de cima
	
	lw $s3, 0($s1)				# <$s3> armazenara o valor do no de cima
	# Verificar se o elemento de cima e uma parede
	beq $s3, 0x4, move_up_finalization		# Se o no de cima e parede fazer nada
	
	# Verificar se o elemento de cima e um pac dot
	bne $s3, 0x1, move_up_not_pac_dot		# Se o no de cima nao e um pac dot fazer nada
	sw $zero, 0($s0)				# Mudar o conteudo do no anterior para espaco vazio
	addi $s2, $zero, 0x2
	sw $s2, 0($s1)					# Mudar o conteudo do no de cima para pac man
	lw $s3, 20($s0)
	sw $zero, 0($s3)				# Pintar o pixel onde o pacman estava para espaco vazio
	li $s2, 0x00ffff3c				#
	lw $s3, 20($s1)
	sw $s2, 0($s3)					# Pintar o pixel de cima com o pacman
	sw $s1, 16($sp)					# Modificar a posicao do pacman para o no de cima, quando for carregado da stack o valor sera o atualizado
	increment_point($k0, 10)			# Incrementar a pontuacao de 10 unidades
	j move_up_finalization
	move_up_not_pac_dot:
	
	# Verificar se o elemento de cima e um espaco vazio
	bne $s3, 0x0, move_up_not_empty_space		# Se o no de cima nao e um espaco fazer nada
	sw $zero, 0($s0)				# Mudar o conteudo do no anterior para espaco vazio
	addi $s2, $zero, 0x2
	sw $s2, 0($s1)					# Mudar o conteudo do no de cima para pac man
	lw $s3, 20($s0)
	sw $zero, 0($s3)				# Pintar o pixel onde o pacman estava para espaco vazio
	li $s2, 0x00ffff3c				#
	lw $s3, 20($s1)
	sw $s2, 0($s3)					# Pintar o pixel de cima com o pacman
	sw $s1, 16($sp)					# Modificar a posicao do pacman para o no de cima, quando for carregado da stack o valor sera o atualizado
	j move_up_finalization
	move_up_not_empty_space:
	
	
	# ... procedimento para toque em fantasma
	
	
	move_up_finalization:
	
	
	# Pop from stack
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw %pacman_position, 16($sp)
	addi $sp, $sp, 20
	# Pop from stack
.end_macro


#############################################################
#############################################################
#############################################################


# Procedimento para mover o pac man para baixo
# %pacman_position	-> registrador que contem a posicao do no onde esta o pacman
# Ao final do procedimento o registrador %pacman_position
# contera o endereco para nova posicao do pacman no grafo
.macro move_down (%pacman_position)
	# Push to stack
	addi $sp, $sp, -20
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw %pacman_position, 16($sp)
	# Push to stack
	
	add $s0, $zero, %pacman_position	# <$s0> armazenara o endereco do no onde o pacman esta
	
	lw $s1, 12($s0)				# 
	add $s1, $s0, $s1			# <$s1> armazenara o endereco do no de baixo
	
	lw $s3, 0($s1)				# <$s3> armazenara o valor do no de baixo
	# Verificar se o elemento de baixo e uma parede
	beq $s3, 0x4, move_down_finalization		# Se o no de baixo e parede fazer nada
	
	# Verificar se o elemento de baixo e um pac dot
	bne $s3, 0x1, move_down_not_pac_dot		# Se o no de baixo nao e um pac dot fazer nada
	sw $zero, 0($s0)				# Mudar o conteudo do no anterior para espaco vazio
	addi $s2, $zero, 0x2
	sw $s2, 0($s1)					# Mudar o conteudo do no de baixo para pac man
	lw $s3, 20($s0)
	sw $zero, 0($s3)				# Pintar o pixel onde o pacman estava para espaco vazio
	li $s2, 0x00ffff3c				#
	lw $s3, 20($s1)
	sw $s2, 0($s3)					# Pintar o pixel de baixo com o pacman
	sw $s1, 16($sp)					# Modificar a posicao do pacman para o no de baixo, quando for carregado da stack o valor sera o atualizado
	increment_point($k0, 10)			# Incrementar a pontuacao de 10 unidades
	j move_down_finalization
	move_down_not_pac_dot:
	
	# Verificar se o elemento de baixo e um espaco vazio
	bne $s3, 0x0, move_down_not_empty_space		# Se o no de baixo nao e um espaco fazer nada
	sw $zero, 0($s0)				# Mudar o conteudo do no anterior para espaco vazio
	addi $s2, $zero, 0x2
	sw $s2, 0($s1)					# Mudar o conteudo do no de baixo para pac man
	lw $s3, 20($s0)
	sw $zero, 0($s3)				# Pintar o pixel onde o pacman estava para espaco vazio
	li $s2, 0x00ffff3c				#
	lw $s3, 20($s1)
	sw $s2, 0($s3)					# Pintar o pixel de baixo com o pacman
	sw $s1, 16($sp)					# Modificar a posicao do pacman para o no de baixo, quando for carregado da stack o valor sera o atualizado
	j move_down_finalization
	move_down_not_empty_space:
	
	
	# ... procedimento para toque em fantasma
	
	
	move_down_finalization:
	
	
	# Pop from stack
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw %pacman_position, 16($sp)
	addi $sp, $sp, 20
	# Pop from stack
.end_macro


#############################################################
#############################################################
#############################################################


# Procedimento para mover o pac man para esquerda
# %pacman_position	-> registrador que contem a posicao do no onde esta o pacman
# Ao final do procedimento o registrador %pacman_position
# contera o endereco para nova posicao do pacman no grafo
.macro move_left (%pacman_position)
	# Push to stack
	addi $sp, $sp, -20
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw %pacman_position, 16($sp)
	# Push to stack
	
	add $s0, $zero, %pacman_position	# <$s0> armazenara o endereco do no onde o pacman esta
	
	lw $s1, 16($s0)				# 
	add $s1, $s0, $s1			# <$s1> armazenara o endereco do no da esquerda
	
	lw $s3, 0($s1)				# <$s3> armazenara o valor do no da esquerda
	# Verificar se o elemento a esquerda e uma parede
	beq $s3, 0x4, move_left_finalization		# Se o no da esquerda e parede fazer nada
	
	# Verificar se o elemento a esquerda e um pac dot
	bne $s3, 0x1, move_left_not_pac_dot		# Se o no da esquerda nao e um pac dot fazer nada
	sw $zero, 0($s0)				# Mudar o conteudo do no anterior para espaco vazio
	addi $s2, $zero, 0x2
	sw $s2, 0($s1)					# Mudar o conteudo do no da esquerda para pac man
	lw $s3, 20($s0)
	sw $zero, 0($s3)				# Pintar o pixel onde o pacman estava para espaco vazio
	li $s2, 0x00ffff3c				#
	lw $s3, 20($s1)
	sw $s2, 0($s3)					# Pintar o pixel a esquerda com o pacman
	sw $s1, 16($sp)					# Modificar a posicao do pacman para o no da esquerda, quando for carregado da stack o valor sera o atualizado
	increment_point($k0, 10)			# Incrementar a pontuacao de 10 unidades
	j move_left_finalization
	move_left_not_pac_dot:
	
	# Verificar se o elemento a esquerda e um espaco vazio
	bne $s3, 0x0, move_left_not_empty_space		# Se o no da esquerda nao e um espaco fazer nada
	sw $zero, 0($s0)				# Mudar o conteudo do no anterior para espaco vazio
	addi $s2, $zero, 0x2
	sw $s2, 0($s1)					# Mudar o conteudo do no da esquerda para pac man
	lw $s3, 20($s0)
	sw $zero, 0($s3)				# Pintar o pixel onde o pacman estava para espaco vazio
	li $s2, 0x00ffff3c				#
	lw $s3, 20($s1)
	sw $s2, 0($s3)					# Pintar o pixel a esquerda com o pacman
	sw $s1, 16($sp)					# Modificar a posicao do pacman para o no da esquerda, quando for carregado da stack o valor sera o atualizado
	j move_left_finalization
	move_left_not_empty_space:
	
	
	# ... procedimento para toque em fantasma
	
	
	move_left_finalization:
	
	
	# Pop from stack
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw %pacman_position, 16($sp)
	addi $sp, $sp, 20
	# Pop from stack
.end_macro


#############################################################
#############################################################
#############################################################


# Procedimento para mover o fantasma azul para esquerda
# %blue_ghost_position	-> registrador que contem a posicao do no onde esta o fantasma azul
# Ao final do procedimento o registrador %blue_ghost_position
# contera o endereco para nova posicao do fantasma azul no grafo
.macro move_blue_left (%blue_ghost_position)
	# Push to stack
	addi $sp, $sp, -24
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw %blue_ghost_position, 16($sp)
	sw $s4, 20($sp)
	# Push to stack
	
	add $s0, $zero, %blue_ghost_position	# <$s0> armazenara o endereco do no onde o fantasma azul esta
	lw $s4, 0($s0)				# <$s4> armazenara o valor do no do fantasma azul
	
	lw $s1, 16($s0)				# 
	add $s1, $s0, $s1			# <$s1> armazenara o endereco do no da esquerda
	
	lw $s3, 0($s1)				# <$s3> armazenara o valor do no da esquerda
	# Verificar se o elemento a esquerda e uma parede
	beq $s3, 0x4, move_blue_left_finalization	# Se o no da esquerda e parede fazer nada
	
	# Verificar se o elemento a esquerda e um pac dot
	bne $s3, 0x1, move_blue_left_not_pac_dot	# Se o no da esquerda nao e um pac dot fazer nada
	bne $s4, 0x51, move_blue_left_pac_dot_before	# Se o no ao qual o fantasma azul pertencia estava com pac dot adicionar valor de pac dot ao no
	li $s3, 0x1
	sw $s3, 0($s0)
	li $s4, 0x00ffffff				#
	lw $s3, 20($s0)					#
	sw $s4, 0($s3)					# Pintar o pixel onde o fantasma azul estava para pac dot
	j move_blue_left_pac_dot_not_before
	move_blue_left_pac_dot_before:
	sw $zero, 0($s0)				# Se o no ao qual o fantasma azul pertencia estava com pac dot adicionar valor de espaco vazio ao no
	lw $s3, 20($s0)					#
	sw $zero, 0($s3)				# Pintar o pixel onde o fantasma azul estava para pac dot
	move_blue_left_pac_dot_not_before:
	addi $s2, $zero, 0x51				#
	sw $s2, 0($s1)					# Mudar o conteudo do no da esquerda para fantasma azul e pac dot
	li $s2, 0x0000ffff
	lw $s3, 20($s1)					#
	sw $s2, 0($s3)					# Pintar o pixel a esquerda com o fantasma azul
	sw $s1, 16($sp)					# Modificar a posicao do fantasma azul para o no da esquerda, quando for carregado da stack o valor sera o atualizado
	j move_blue_left_finalization
	move_blue_left_not_pac_dot:
	
	# Verificar se o elemento a esquerda e um espaco vazio
	bne $s3, 0x0, move_blue_left_not_empty_space	# Se o no da esquerda nao e um espaco fazer nada
	sw $zero, 0($s0)				# Mudar o conteudo do no anterior para espaco vazio
	addi $s2, $zero, 0x5
	sw $s2, 0($s1)					# Mudar o conteudo do no da esquerda para fantasma azul
	lw $s3, 20($s0)
	sw $zero, 0($s3)				# Pintar o pixel onde o fantasma azul estava para espaco vazio
	li $s2, 0x0000ffff
	lw $s3, 20($s1)					#
	sw $s2, 0($s3)					# Pintar o pixel a esquerda com o fantasma azul
	sw $s1, 16($sp)					# Modificar a posicao do fantasma azul para o no da esquerda, quando for carregado da stack o valor sera o atualizado
	j move_blue_left_finalization
	move_blue_left_not_empty_space:
	
		
	move_blue_left_finalization:
	
	
	# Pop from stack
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw %blue_ghost_position, 16($sp)
	lw $s4, 20($sp)
	addi $sp, $sp, 24
	# Pop from stack
.end_macro



# TEST
#.text
#
#li $s0, 0x10010000
#li $s1, 256
#la $s2, graph
#
#draw_maze ($s0, $s2, $s1)
#
#addi $s3, $s2, 480
#
#move_right ($s3)
#move_right ($s3)
#move_down ($s3)
#move_down ($s3)
#move_left ($s3)
#move_left ($s3)
#move_up ($s3)
#move_up ($s3)






