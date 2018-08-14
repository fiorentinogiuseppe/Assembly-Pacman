# Procedimento para mover o pac man para direita
# %pacman_position	-> registrador que contem a posicao do no onde esta o pacman
# %pontuation		-> registrador que contem a pontuacao do jogo
# %pac_dot_number	-> registrador que contem a quantidade de pac dots comidas do estagio
# Ao final do procedimento o registrador %pacman_position
# contera o endereco para nova posicao do pacman no grafo
.macro move_right (%pacman_position, %pontuation, %pac_dot_number)
	# Push to stack
	addi $sp, $sp, -32
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw %pacman_position, 20($sp)
	sw %pontuation, 24($sp)
	sw %pac_dot_number, 28($sp)
	# Push to stack
	
	lw $s4, 24($sp)		# <$s4> armazenara o valor da pontuacao
	lw $s0, 20($sp)		# <$s0> armazenara o endereco do no onde o pacman esta
	
	
	lw $s1, 8($s0)				# 
	add $s1, $s0, $s1			# <$s1> armazenara o endereco do no da direita
	
	lw $s3, 0($s1)				# <$s3> armazenara o valor do no da direita
	# Verificar se o elemento a direita e uma parede
	beq $s3, 0x4, move_right_finalization		# Se o no da direita e parede fazer nada
	
	# Verificar se o elemento a direita e um pac dot
	bne $s3, 0x1, move_right_not_pac_dot		# Se o no da direita nao e um pac dot fazer nada
	sw $zero, 0($s0)				# Mudar o conteudo do no anterior para espaco vazio
	addi $s2, $zero, 0x2
	sw $s2, 0($s1)					# Mudar o conteudo do no da direita para pac man
	lw $s3, 20($s0)
	sw $zero, 0($s3)				# Pintar o pixel onde o pacman estava para espaco vazio
	li $s2, 0x00ffff3c				#
	lw $s3, 20($s1)
	sw $s2, 0($s3)					# Pintar o pixel a direita com o pacman
	sw $s1, 16($sp)					# Modificar a posicao do pacman para o no da direita, quando for carregado da stack o valor sera o atualizado
	increment_point($s4, 10)			# Incrementar a pontuacao de 10 unidades
	sw $s4, 24($sp)					# Salvar pontuacao
	lw $s1, 28($sp)					#
	addi $s1, $s1, 1				# Incrementar o valor dos pac dots comidos naquele estagio
	sw $s1, 28($sp)					#
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
	lw $s4, 16($sp)
	lw %pacman_position, 20($sp)
	lw %pontuation, 24($sp)
	lw %pac_dot_number, 28($sp)
	addi $sp, $sp, 32
	# Pop from stack
.end_macro


#############################################################
#############################################################
#############################################################


# Procedimento para mover o pac man para cima
# %pacman_position	-> registrador que contem a posicao do no onde esta o pacman
# %pontuation		-> registrador que contem a pontuacao do jogo
# %pac_dot_number	-> registrador que contem a quantidade de pac dots comidas do estagio
# Ao final do procedimento o registrador %pacman_position
# contera o endereco para nova posicao do pacman no grafo
.macro move_up (%pacman_position, %pontuation, %pac_dot_number)
	# Push to stack
	addi $sp, $sp, -32
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw %pacman_position, 20($sp)
	sw %pontuation, 24($sp)
	sw %pac_dot_number, 28($sp)
	# Push to stack
	
	lw $s4, 24($sp)		# <$s4> armazenara o valor da pontuacao
	lw $s0, 20($sp)		# <$s0> armazenara o endereco do no onde o pacman esta
	
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
	increment_point($s4, 10)			# Incrementar a pontuacao de 10 unidades
	sw $s4, 24($sp)					# Salvar pontuacao
	lw $s1, 28($sp)					#
	addi $s1, $s1, 1				# Incrementar o valor dos pac dots comidos naquele estagio
	sw $s1, 28($sp)					#
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
	lw $s4, 16($sp)
	lw %pacman_position, 20($sp)
	lw %pontuation, 24($sp)
	lw %pac_dot_number, 28($sp)
	addi $sp, $sp, 32
	# Pop from stack
.end_macro


#############################################################
#############################################################
#############################################################


# Procedimento para mover o pac man para baixo
# %pacman_position	-> registrador que contem a posicao do no onde esta o pacman
# %pontuation		-> registrador que contem a pontuacao do jogo
# %pac_dot_number	-> registrador que contem a quantidade de pac dots comidas do estagio
# Ao final do procedimento o registrador %pacman_position
# contera o endereco para nova posicao do pacman no grafo
.macro move_down (%pacman_position, %pontuation, %pac_dot_number)
	# Push to stack
	addi $sp, $sp, -32
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw %pacman_position, 20($sp)
	sw %pontuation, 24($sp)
	sw %pac_dot_number, 28($sp)
	# Push to stack
	
	lw $s4, 24($sp)		# <$s4> armazenara o valor da pontuacao
	lw $s0, 20($sp)		# <$s0> armazenara o endereco do no onde o pacman esta
	
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
	increment_point($s4, 10)			# Incrementar a pontuacao de 10 unidades
	sw $s4, 24($sp)					# Salvar pontuacao
	lw $s1, 28($sp)					#
	addi $s1, $s1, 1				# Incrementar o valor dos pac dots comidos naquele estagio
	sw $s1, 28($sp)					#
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
	lw $s4, 16($sp)
	lw %pacman_position, 20($sp)
	lw %pontuation, 24($sp)
	lw %pac_dot_number, 28($sp)
	addi $sp, $sp, 32
	# Pop from stack
.end_macro


#############################################################
#############################################################
#############################################################


# Procedimento para mover o pac man para esquerda
# %pacman_position	-> registrador que contem a posicao do no onde esta o pacman
# %pontuation		-> registrador que contem a pontuacao do jogo
# %pac_dot_number	-> registrador que contem a quantidade de pac dots comidas do estagio
# Ao final do procedimento o registrador %pacman_position
# contera o endereco para nova posicao do pacman no grafo
.macro move_left (%pacman_position, %pontuation, %pac_dot_number)
	# Push to stack
	addi $sp, $sp, -32
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw %pacman_position, 20($sp)
	sw %pontuation, 24($sp)
	sw %pac_dot_number, 28($sp)
	# Push to stack
	
	lw $s4, 24($sp)		# <$s4> armazenara o valor da pontuacao
	lw $s0, 20($sp)		# <$s0> armazenara o endereco do no onde o pacman esta
	
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
	increment_point($s4, 10)			# Incrementar a pontuacao de 10 unidades
	sw $s4, 24($sp)					# Salvar pontuacao
	lw $s1, 28($sp)					#
	addi $s1, $s1, 1				# Incrementar o valor dos pac dots comidos naquele estagio
	sw $s1, 28($sp)					#
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
	lw $s4, 16($sp)
	lw %pacman_position, 20($sp)
	lw %pontuation, 24($sp)
	lw %pac_dot_number, 28($sp)
	addi $sp, $sp, 32
	# Pop from stack
.end_macro


#############################################################
#############################################################
#############################################################


# Procedimento para efetuar o movimento do pac man
# %pacman_position	-> registrador que contem a posicao do no onde esta o pacman
# Ao final do procedimento o registrador %pacman_position
# contera o endereco para nova posicao do pacman no grafo
#.macro move_pacman (%pacman_position)
#	# Push to stack
#	addi $sp, $sp, -20
#	sw $s0, 0($sp)
#	sw $s1, 4($sp)
#	sw $s2, 8($sp)
#	sw $s3, 12($sp)
#	sw %pacman_position, 16($sp)
	# Push to stack
	
	
	
	# Pop from stack
#	lw $s0, 0($sp)
#	lw $s1, 4($sp)
#	lw $s2, 8($sp)
#	lw $s3, 12($sp)
#	lw %pacman_position, 16($sp)
#	addi $sp, $sp, 20
#	# Pop from stack
#.end_macro
