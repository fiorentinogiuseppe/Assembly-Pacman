# Este arquivo contem os procedimentos para mover o fantasma rosa

# Procedimento para mover o fantasma rosa para esquerda
# %pink_ghost_position	-> registrador que contem a posicao do no onde esta o fantasma rosa
# Ao final do procedimento o registrador %pink_ghost_position
# contera o endereco para nova posicao do fantasma rosa no grafo
.macro move_pink_left (%pink_ghost_position)
	# Push to stack
	addi $sp, $sp, -24
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw %pink_ghost_position, 20($sp)
	# Push to stack
	
	add $s0, $zero, %pink_ghost_position	# <$s0> armazenara o endereco do no onde o fantasma rosa esta
	lw $s4, 0($s0)				# <$s4> armazenara o valor do no onde o fantasma rosa se encontra
	
	lw $s1, 16($s0)				# 
	add $s1, $s0, $s1			# <$s1> armazenara o endereco do no da esquerda
	
	lw $s3, 0($s1)				# <$s3> armazenara o valor do no da esquerda
	
	# Verificar se o elemento a esquerda e uma parede
	beq $s3, 0x4, move_pink_left_end		# Se o no da esquerda e parede fazer nada
	
	# Verificar se o elemento a esquerda e um espaco vazio
	bne $s3, 0x0, move_pink_left_not_empty_space	# Se o no da esquerda nao e um espaco pular para proxima verificacao
	sw $s1, 20($sp)					# Fazer com que o registrador responsavel por apontar o fantasma rosa aponte para o no da esquerda
	lw $s2, 20($s1)			#
	li $s3, 0x00dca0aa		# Pintar o pixel do no da esquerda na tela com a cor respectiva do fantasma rosa
	sw $s3, 0($s2)			#
	j move_pink_left_finalization
	
	move_pink_left_not_empty_space:
	
	# Verificar se o elemento a esquerda e um pac dot
	bne $s3, 0x1, move_pink_left_not_pac_dot	# Se o no da esquerda nao e um pac dot pular para proxima verificacao
	sw $s1, 20($sp)					# Fazer com que o registrador responsavel por apontar o fantasma rosa aponte para o no da esquerda
	lw $s2, 20($s1)			#
	li $s3, 0x00dca0aa		# Pintar o pixel do no da esquerda na tela com a cor respectiva do fantasma rosa
	sw $s3, 0($s2)			#
	j move_pink_left_finalization
	
	move_pink_left_not_pac_dot:
	
	# ... Procedimento para toque de fantasma no pac man
		
	move_pink_left_finalization:
	
	# Verificar se o no onde fantasma estava continha espaco vazio
	bne $s4, 0x0, move_pink_left_not_empty_space_before	# O no atual nao e um espaco vazio
	lw $s0, 20($s0)						# Carregar o endereco do pixel
	li $s4, 0x00000000					# Carregar o valor da cor do espaco vazio
	sw $s4, 0($s0)						# "Pintar" o pixel
	j move_pink_left_end
	
	move_pink_left_not_empty_space_before:
	
	# Verificar se o no onde fantasma estava continha pac dot
	bne $s4, 0x1, move_pink_left_not_pac_dot_before		# O no atual nao e um pac dot
	lw $s0, 20($s0)						# Carregar o endereco do pixel
	li $s4, 0x00ffffff					# Carregar o valor da cor do pac dot
	sw $s4, 0($s0)						# "Pintar" o pixel
	j move_pink_left_end
	
	move_pink_left_not_pac_dot_before:
	
	move_pink_left_end:
	# Pop from stack
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw %pink_ghost_position, 20($sp)
	addi $sp, $sp, 24
	# Pop from stack
.end_macro


#############################################################
#############################################################
#############################################################


# Procedimento para mover o fantasma rosa para direita
# %pink_ghost_position	-> registrador que contem a posicao do no onde esta o fantasma rosa
# Ao final do procedimento o registrador %pink_ghost_position
# contera o endereco para nova posicao do fantasma rosa no grafo
.macro move_pink_right (%pink_ghost_position)
	# Push to stack
	addi $sp, $sp, -24
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw %pink_ghost_position, 20($sp)
	# Push to stack
	
	add $s0, $zero, %pink_ghost_position	# <$s0> armazenara o endereco do no onde o fantasma rosa esta
	lw $s4, 0($s0)				# <$s4> armazenara o valor do no onde o fantasma rosa se encontra
	
	lw $s1, 8($s0)				# 
	add $s1, $s0, $s1			# <$s1> armazenara o endereco do no da direita
	
	lw $s3, 0($s1)				# <$s3> armazenara o valor do no da direita
	
	# Verificar se o elemento a direita e uma parede
	beq $s3, 0x4, move_pink_right_end		# Se o no da direita e parede fazer nada
	
	# Verificar se o elemento a direita e um espaco vazio
	bne $s3, 0x0, move_pink_right_not_empty_space	# Se o no da direita nao e um espaco pular para proxima verificacao
	sw $s1, 20($sp)					# Fazer com que o registrador responsavel por apontar o fantasma rosa aponte para o no da direita
	lw $s2, 20($s1)			#
	li $s3, 0x00dca0aa		# Pintar o pixel do no da direita na tela com a cor respectiva do fantasma rosa
	sw $s3, 0($s2)			#
	j move_pink_right_finalization
	
	move_pink_right_not_empty_space:
	
	# Verificar se o elemento a direita e um pac dot
	bne $s3, 0x1, move_pink_right_not_pac_dot	# Se o no da direita nao e um pac dot pular para proxima verificacao
	sw $s1, 20($sp)					# Fazer com que o registrador responsavel por apontar o fantasma rosa aponte para o no da direita
	lw $s2, 20($s1)			#
	li $s3, 0x00dca0aa		# Pintar o pixel do no da direita na tela com a cor respectiva do fantasma rosa
	sw $s3, 0($s2)			#
	j move_pink_right_finalization
	
	move_pink_right_not_pac_dot:
	
	# ... Procedimento para toque de fantasma no pac man
		
	move_pink_right_finalization:
	
	# Verificar se o no onde fantasma estava continha espaco vazio
	bne $s4, 0x0, move_pink_right_not_empty_space_before	# O no atual nao e um espaco vazio
	lw $s0, 20($s0)						# Carregar o endereco do pixel
	li $s4, 0x00000000					# Carregar o valor da cor do espaco vazio
	sw $s4, 0($s0)						# "Pintar" o pixel
	j move_pink_right_end
	
	move_pink_right_not_empty_space_before:
	
	# Verificar se o no onde fantasma estava continha pac dot
	bne $s4, 0x1, move_pink_right_not_pac_dot_before	# O no atual nao e um pac dot
	lw $s0, 20($s0)						# Carregar o endereco do pixel
	li $s4, 0x00ffffff					# Carregar o valor da cor do pac dot
	sw $s4, 0($s0)						# "Pintar" o pixel
	j move_pink_right_end
	
	move_pink_right_not_pac_dot_before:
	
	move_pink_right_end:
	# Pop from stack
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw %pink_ghost_position, 20($sp)
	addi $sp, $sp, 24
	# Pop from stack
.end_macro


#############################################################
#############################################################
#############################################################


# Procedimento para mover o fantasma rosa para cima
# %pink_ghost_position	-> registrador que contem a posicao do no onde esta o fantasma rosa
# Ao final do procedimento o registrador %pink_ghost_position
# contera o endereco para nova posicao do fantasma rosa no grafo
.macro move_pink_up (%pink_ghost_position)
	# Push to stack
	addi $sp, $sp, -24
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw %pink_ghost_position, 20($sp)
	# Push to stack
	
	add $s0, $zero, %pink_ghost_position	# <$s0> armazenara o endereco do no onde o fantasma rosa esta
	lw $s4, 0($s0)				# <$s4> armazenara o valor do no onde o fantasma rosa se encontra
	
	lw $s1, 4($s0)				# 
	add $s1, $s0, $s1			# <$s1> armazenara o endereco do no da cima
	
	lw $s3, 0($s1)				# <$s3> armazenara o valor do no da cima
	
	# Verificar se o elemento a cima e uma parede
	beq $s3, 0x4, move_pink_up_end		# Se o no de cima e parede fazer nada
	
	# Verificar se o elemento a cima e um espaco vazio
	bne $s3, 0x0, move_pink_up_not_empty_space	# Se o no de cima nao e um espaco pular para proxima verificacao
	sw $s1, 20($sp)					# Fazer com que o registrador responsavel por apontar o fantasma rosa aponte para o no de cima
	lw $s2, 20($s1)			#
	li $s3, 0x00dca0aa		# Pintar o pixel do no de cima na tela com a cor respectiva do fantasma rosa
	sw $s3, 0($s2)			#
	j move_pink_up_finalization
	
	move_pink_up_not_empty_space:
	
	# Verificar se o elemento a cima e um pac dot
	bne $s3, 0x1, move_pink_up_not_pac_dot	# Se o no de cima nao e um pac dot pular para proxima verificacao
	sw $s1, 20($sp)				# Fazer com que o registrador responsavel por apontar o fantasma rosa aponte para o no de cima
	lw $s2, 20($s1)			#
	li $s3, 0x00dca0aa		# Pintar o pixel do no de cima na tela com a cor respectiva do fantasma rosa
	sw $s3, 0($s2)			#
	j move_pink_up_finalization
	
	move_pink_up_not_pac_dot:
	
	# ... Procedimento para toque de fantasma no pac man
		
	move_pink_up_finalization:
	
	# Verificar se o no onde fantasma estava continha espaco vazio
	bne $s4, 0x0, move_pink_up_not_empty_space_before	# O no atual nao e um espaco vazio
	lw $s0, 20($s0)						# Carregar o endereco do pixel
	li $s4, 0x00000000					# Carregar o valor da cor do espaco vazio
	sw $s4, 0($s0)						# "Pintar" o pixel
	j move_pink_up_end
	
	move_pink_up_not_empty_space_before:
	
	# Verificar se o no onde fantasma estava continha pac dot
	bne $s4, 0x1, move_pink_up_not_pac_dot_before		# O no atual nao e um pac dot
	lw $s0, 20($s0)						# Carregar o endereco do pixel
	li $s4, 0x00ffffff					# Carregar o valor da cor do pac dot
	sw $s4, 0($s0)						# "Pintar" o pixel
	j move_pink_up_end
	
	move_pink_up_not_pac_dot_before:
	
	move_pink_up_end:
	# Pop from stack
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw %pink_ghost_position, 20($sp)
	addi $sp, $sp, 24
	# Pop from stack
.end_macro


#############################################################
#############################################################
#############################################################


# Procedimento para mover o fantasma rosa para baixo
# %pink_ghost_position	-> registrador que contem a posicao do no onde esta o fantasma rosa
# Ao final do procedimento o registrador %pink_ghost_position
# contera o endereco para nova posicao do fantasma rosa no grafo
.macro move_pink_down (%pink_ghost_position)
	# Push to stack
	addi $sp, $sp, -24
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw %pink_ghost_position, 20($sp)
	# Push to stack
	
	add $s0, $zero, %pink_ghost_position	# <$s0> armazenara o endereco do no onde o fantasma rosa esta
	lw $s4, 0($s0)				# <$s4> armazenara o valor do no onde o fantasma rosa se encontra
	
	lw $s1, 12($s0)				# 
	add $s1, $s0, $s1			# <$s1> armazenara o endereco do no de baixo
	
	lw $s3, 0($s1)				# <$s3> armazenara o valor do no de baixo
	
	# Verificar se o elemento a baixo e uma parede
	beq $s3, 0x4, move_pink_down_end	# Se o no de baixo e parede fazer nada
	
	# Verificar se o elemento a baixo e um espaco vazio
	bne $s3, 0x0, move_pink_down_not_empty_space	# Se o no de baixo nao e um espaco pular para proxima verificacao
	sw $s1, 20($sp)					# Fazer com que o registrador responsavel por apontar o fantasma rosa aponte para o no de baixo
	lw $s2, 20($s1)			#
	li $s3, 0x00dca0aa		# Pintar o pixel do no de baixo na tela com a cor respectiva do fantasma rosa
	sw $s3, 0($s2)			#
	j move_pink_down_finalization
	
	move_pink_down_not_empty_space:
	
	# Verificar se o elemento a baixo e um pac dot
	bne $s3, 0x1, move_pink_down_not_pac_dot	# Se o no de baixo nao e um pac dot pular para proxima verificacao
	sw $s1, 20($sp)					# Fazer com que o registrador responsavel por apontar o fantasma rosa aponte para o no de baixo
	lw $s2, 20($s1)			#
	li $s3, 0x00dca0aa		# Pintar o pixel do no de baixo na tela com a cor respectiva do fantasma rosa
	sw $s3, 0($s2)			#
	j move_pink_down_finalization
	
	move_pink_down_not_pac_dot:
	
	# ... Procedimento para toque de fantasma no pac man
		
	move_pink_down_finalization:
	
	# Verificar se o no onde fantasma estava continha espaco vazio
	bne $s4, 0x0, move_pink_down_not_empty_space_before	# O no atual nao e um espaco vazio
	lw $s0, 20($s0)						# Carregar o endereco do pixel
	li $s4, 0x00000000					# Carregar o valor da cor do espaco vazio
	sw $s4, 0($s0)						# "Pintar" o pixel
	j move_pink_down_end
	
	move_pink_down_not_empty_space_before:
	
	# Verificar se o no onde fantasma estava continha pac dot
	bne $s4, 0x1, move_pink_down_not_pac_dot_before		# O no atual nao e um pac dot
	lw $s0, 20($s0)						# Carregar o endereco do pixel
	li $s4, 0x00ffffff					# Carregar o valor da cor do pac dot
	sw $s4, 0($s0)						# "Pintar" o pixel
	j move_pink_down_end
	
	move_pink_down_not_pac_dot_before:
	
	move_pink_down_end:
	# Pop from stack
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw %pink_ghost_position, 20($sp)
	addi $sp, $sp, 24
	# Pop from stack
.end_macro


#############################################################
#############################################################
#############################################################


# Procedimento para mover um fantasma de maneira aleatoria
# %ghost_position	-> registrador que contem a posicao do no onde esta o fantasma
# Ao final do procedimento o registrador %ghost_position
# contera o endereco para nova posicao do fantasma azul no grafo
.macro move_pink_ghost (%ghost_position)
	# Push to stack
	addi $sp, $sp, -24
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $a0, 8($sp)
	sw $a1, 12($sp)
	sw $v0, 16($sp)
	sw %ghost_position, 20($sp)
	# Push to stack
	
	lw $s0, 20($sp)	# blue_ghost_position
	
	# Loop
	# random direction
	li $a0, 1	#
	li $a1, 40	# set seed
	li $v0, 40	#
	syscall
	
	li $a0, 1	#
	li $a1, 4	# get randon range int number
	li $v0, 42	#
	syscall
	
	# move right
	bne $a0, 0x0, move_pink_ghost_not_right 
	move_pink_right ($s0)
	j move_pink_ghost_was_moved
	move_pink_ghost_not_right:
	
	# move left
	bne $a0, 0x1, move_pink_ghost_not_left 
	move_pink_left ($s0)
	j move_pink_ghost_was_moved
	move_pink_ghost_not_left:
	
	# move up
	bne $a0, 0x2, move_pink_ghost_not_up 
	move_pink_up ($s0)
	j move_pink_ghost_was_moved
	move_pink_ghost_not_up:
	
	# move down
	bne $a0, 0x3, move_pink_ghost_not_down 
	move_pink_down ($s0)
	j move_pink_ghost_was_moved
	move_pink_ghost_not_down:
	
	move_pink_ghost_was_moved:
	
	# TODO
	# verify if the move was achieved
		# if no reexecute loop
	
	# Pop from stack
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $a0, 8($sp)
	lw $a1, 12($sp)
	lw $v0, 16($sp)
	lw %ghost_position, 20($sp)
	addi $sp, $sp, 24
	# Pop from stack
.end_macro