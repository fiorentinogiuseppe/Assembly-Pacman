# Este arquivo contem procedimentos utilitarios para o sistema

# Procedimento para ler dado do arquivo
# %input_register	-> registrador que armazenara a entrada do teclado
.macro read_keyboard (%input_register)
	# Push to stack
	addi $sp, $sp, -12
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw %input_register, 8($sp)
	# Push to stack
	
	li $s0, 0xffff0000			#
	lw $s1, 0($s0)				#
	bne $s1, 0x1, read_keyboard_end		# Descobrir se uma nova entrada foi digitada
	
	lw $s1, 4($s0)		# Ler dado do teclado
	sw $s1, 8($sp)		# Escrever no %input_register
	
	read_keyboard_end:
	
	# Pop from stack
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw %input_register, 8($sp)
	addi $sp, $sp, 12
	# Pop from stack
.end_macro


#############################################################
#############################################################
#############################################################


# Procedimento para posicionar o pacman e os fantasmas na sua posicao default
# %pacman		-> registrador com endereco para o no do grafo que contem o pacman
# %blue_ghost		-> registrador com endereco para o no do grafo que contem o fantasma azul
# %red_ghost		-> registrador com endereco para o no do grafo que contem o fantasma vermelho
# %orange_ghost		-> registrador com endereco para o no do grafo que contem o fantasma laranja
# %pink_ghost		-> registrador com endereco para o no do grafo que contem o fantasma rosa
.macro default_position (%pacman, %blue_ghost, %red_ghost, %orange_ghost, %pink_ghost)
	# Push to stack
	addi $sp, $sp, -52
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	sw $s6, 24($sp)
	sw $s7, 28($sp)
	sw %pacman,		32($sp)
	sw %blue_ghost,		36($sp)
	sw %red_ghost, 		40($sp)
	sw %orange_ghost,	44($sp)
	sw %pink_ghost,		48($sp)
	# Push to stack
	
	lw $s0, 32($sp)		# <$s0> armazenara o endereco do no do pacman
	lw $s1, 36($sp)		# <$s1> armazenara o endereco do no do fantasma azul
	lw $s2, 40($sp)		# <$s2> armazenara o endereco do no do fantasma vermelho
	lw $s3, 44($sp)		# <$s3> armazenara o endereco do no do fantasma laranja
	lw $s4, 48($sp)		# <$s4> armazenara o endereco do no do fantasma rosa
	la $s5, graph		# <$s5> armazenara o endereco do no do grafo
	
	# Reposicionamento do pacman
	
	lw $s6, 20($s0)			#
	sw $zero, 0($s6)		# Pintar o pixel onde o pacman estava com espaco vazio
	sw $zero, 0($s0)		# Setar o no do grafo onde o pacman estava com valor de espaco vazio
	addi $s0, $s5, 31440		# <$s0> contera o novo endereco para o pacman ajustar o offset (bytes no grafo) conforme necessidade 
	li $s7, 0x2			#
	sw $s7, 0($s0)			# Setar o no do grafo onde o pacman ficara com valor do pacman
	li $s6, 0x00ffff3c		#
	lw $s7, 20($s0)			# Pintar o pixel onde o pacman estara com a sua respectiva cor
	sw $s6, 0($s7)			#
	sw $s0, 32($sp)			# Modificar o endereco do registrador que aponta para o no do pacman
	
	
	# Reposicionamento do fantasma azul
	
	lw $s6, 0($s1)						# Carregar o valor do no do fantasma azul
	bne $s6, 0x0, default_position_blue_not_empty_space	# Se o valor do no nao for espaco vazio pular para proxima verificacao
	lw $s6, 20($s1)		#
	sw $zero, 0($s6)	# Pintar o pixel onde o fantasma azul estava com espaco vazio
	addi $s1, $s5, 46800	# <$s1> contera o novo endereco para o fantasma azul ajustar o offset (bytes no grafo) conforme necessidade 
	li $s7, 0x0000ffff	#
	lw $s6, 20($s1)		# Pintar o pixel onde o fantasma azul estara com a sua respectiva cor
	sw $s7, 0($s6)		#
	sw $s1, 36($sp)		# Modificar o endereco do registrador que aponta para o no do fantasma azul
	j default_position_blue_finalization
	default_position_blue_not_empty_space:
	
	bne $s6, 0x1, default_position_blue_not_pac_dot		# Se o valor do no nao for espaco vazio pular para proxima verificacao
	lw $s6, 20($s1)		#
	li $s7, 0x00ffffff	# Pintar o pixel onde o fantasma azul estava com espaco vazio
	sw $s7, 0($s6)		#
	addi $s1, $s5, 46800	# <$s1> contera o novo endereco para o fantasma azul ajustar o offset (bytes no grafo) conforme necessidade 
	li $s7, 0x0000ffff	#
	lw $s6, 20($s1)		# Pintar o pixel onde o fantasma azul estara com a sua respectiva cor
	sw $s7, 0($s6)		#
	sw $s1, 36($sp)		# Modificar o endereco do registrador que aponta para o no do fantasma azul
	j default_position_blue_finalization
	default_position_blue_not_pac_dot:
	
	default_position_blue_finalization:
	
	
	# Reposicionamento do fantasma vermelho
	
	lw $s6, 0($s2)						# Carregar o valor do no do fantasma azul
	bne $s6, 0x0, default_position_red_not_empty_space	# Se o valor do no nao for espaco vazio pular para proxima verificacao
	lw $s6, 20($s2)		#
	sw $zero, 0($s6)	# Pintar o pixel onde o fantasma vermelho estava com espaco vazio
	addi $s2, $s5, 62160	# <$s2> contera o novo endereco para o fantasma vermelho ajustar o offset (bytes no grafo) conforme necessidade 
	li $s7, 0x00ff0000	#
	lw $s6, 20($s2)		# Pintar o pixel onde o fantasma vermelho estara com a sua respectiva cor
	sw $s7, 0($s6)		#
	sw $s2, 40($sp)		# Modificar o endereco do registrador que aponta para o no do fantasma vermelho
	j default_position_red_finalization
	default_position_red_not_empty_space:
	
	bne $s6, 0x1, default_position_red_not_pac_dot		# Se o valor do no nao for espaco vazio pular para proxima verificacao
	lw $s6, 20($s2)		#
	li $s7, 0x00ffffff	# Pintar o pixel onde o fantasma vermelho estava com espaco vazio
	sw $s7, 0($s6)		#
	addi $s2, $s5, 62160	# <$s2> contera o novo endereco para o fantasma vermelho ajustar o offset (bytes no grafo) conforme necessidade 
	li $s7, 0x00ff0000	#
	lw $s6, 20($s2)		# Pintar o pixel onde o fantasma vermelho estara com a sua respectiva cor
	sw $s7, 0($s6)		#
	sw $s2, 40($sp)		# Modificar o endereco do registrador que aponta para o no do fantasma vermelho
	j default_position_red_finalization
	default_position_red_not_pac_dot:
	
	default_position_red_finalization:
	
	
	# Reposicionamento do fantasma laranja
	
	lw $s6, 0($s3)						# Carregar o valor do no do fantasma laranja
	bne $s6, 0x0, default_position_orange_not_empty_space	# Se o valor do no nao for espaco vazio pular para proxima verificacao
	lw $s6, 20($s3)		#
	sw $zero, 0($s6)	# Pintar o pixel onde o fantasma laranja estava com espaco vazio
	addi $s3, $s5, 77520	# <$s3> contera o novo endereco para o fantasma laranja ajustar o offset (bytes no grafo) conforme necessidade 
	li $s7, 0x00e68c14	#
	lw $s6, 20($s3)		# Pintar o pixel onde o fantasma laranja estara com a sua respectiva cor
	sw $s7, 0($s6)		#
	sw $s3, 44($sp)		# Modificar o endereco do registrador que aponta para o no do fantasma laranja
	j default_position_orange_finalization
	default_position_orange_not_empty_space:
	
	bne $s6, 0x1, default_position_orange_not_pac_dot	# Se o valor do no nao for espaco vazio pular para proxima verificacao
	lw $s6, 20($s3)		#
	li $s7, 0x00ffffff	# Pintar o pixel onde o fantasma laranja estava com espaco vazio
	sw $s7, 0($s6)		#
	addi $s3, $s5, 77520	# <$s3> contera o novo endereco para o fantasma laranja ajustar o offset (bytes no grafo) conforme necessidade 
	li $s7, 0x00e68c14	#
	lw $s6, 20($s3)		# Pintar o pixel onde o fantasma laranja estara com a sua respectiva cor
	sw $s7, 0($s6)		#
	sw $s3, 44($sp)		# Modificar o endereco do registrador que aponta para o no do fantasma laranja
	j default_position_orange_finalization
	default_position_orange_not_pac_dot:
	
	default_position_orange_finalization:
	
	
	# Reposicionamento do fantasma rosa
	
	lw $s6, 0($s4)						# Carregar o valor do no do fantasma rosa
	bne $s6, 0x0, default_position_pink_not_empty_space	# Se o valor do no nao for espaco vazio pular para proxima verificacao
	lw $s6, 20($s4)		#
	sw $zero, 0($s6)	# Pintar o pixel onde o fantasma rosa estava com espaco vazio
	addi $s4, $s5, 92880	# <$s4> contera o novo endereco para o fantasma rosa ajustar o offset (bytes no grafo) conforme necessidade 
	li $s7, 0x00dca0aa	#
	lw $s6, 20($s4)		# Pintar o pixel onde o fantasma rosa estara com a sua respectiva cor
	sw $s7, 0($s6)		#
	sw $s4, 48($sp)		# Modificar o endereco do registrador que aponta para o no do fantasma rosa
	j default_position_pink_finalization
	default_position_pink_not_empty_space:
	
	bne $s6, 0x1, default_position_pink_not_pac_dot		# Se o valor do no nao for espaco vazio pular para proxima verificacao
	lw $s6, 20($s4)		#
	li $s7, 0x00ffffff	# Pintar o pixel onde o fantasma rosa estava com espaco vazio
	sw $s7, 0($s6)		#
	addi $s4, $s5, 92880	# <$s4> contera o novo endereco para o fantasma rosa ajustar o offset (bytes no grafo) conforme necessidade 
	li $s7, 0x00dca0aa	#
	lw $s6, 20($s4)		# Pintar o pixel onde o fantasma rosa estara com a sua respectiva cor
	sw $s7, 0($s6)		#
	sw $s4, 48($sp)		# Modificar o endereco do registrador que aponta para o no do fantasma rosa
	j default_position_pink_finalization
	default_position_pink_not_pac_dot:
	
	default_position_pink_finalization:
	
	# Pop from stack
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw $s5, 20($sp)
	lw $s6, 24($sp)
	lw $s7, 28($sp)
	lw %pacman,		32($sp)
	lw %blue_ghost,		36($sp)
	lw %red_ghost, 		40($sp)
	lw %orange_ghost,	44($sp)
	lw %pink_ghost,		48($sp)
	addi $sp, $sp, 52
	# Pop from stack
.end_macro


#############################################################
#############################################################
#############################################################


# Procedimento para detectar colisao entre pacman e fantasmas
# %pacman		-> registrador com endereco para o no do grafo que contem o pacman
# %blue_ghost		-> registrador com endereco para o no do grafo que contem o fantasma azul
# %red_ghost		-> registrador com endereco para o no do grafo que contem o fantasma vermelho
# %orange_ghost		-> registrador com endereco para o no do grafo que contem o fantasma laranja
# %pink_ghost		-> registrador com endereco para o no do grafo que contem o fantasma rosa
# %life_number		-> registrador que contem o numero de vidas restantes do jogador
.macro collision_detection (%pacman, %blue_ghost, %red_ghost, %orange_ghost, %pink_ghost, %life_number)
	# Push to stack
	# Push to stack
	
	bne %pacman, %blue_ghost, collision_detection_blue_not_collision	# Se nao houver colisao do pacman com o fantasma azul prosseguir
	addi %life_number, %life_number, -1							# Decrementar a quantidade de vidas
	default_position (%pacman, %blue_ghost, %red_ghost, %orange_ghost, %pink_ghost)		# Reposicionamento para reiniciar o jogo com menos uma vida
	j collision_detection_end
	collision_detection_blue_not_collision:
	
	bne %pacman, %red_ghost, collision_detection_red_not_collision		# Se nao houver colisao do pacman com o fantasma vermelho prosseguir
	addi %life_number, %life_number, -1							# Decrementar a quantidade de vidas
	default_position (%pacman, %blue_ghost, %red_ghost, %orange_ghost, %pink_ghost)		# Reposicionamento para reiniciar o jogo com menos uma vida
	j collision_detection_end
	collision_detection_red_not_collision:
	
	bne %pacman, %orange_ghost, collision_detection_orange_not_collision	# Se nao houver colisao do pacman com o fantasma laranja prosseguir
	addi %life_number, %life_number, -1							# Decrementar a quantidade de vidas
	default_position (%pacman, %blue_ghost, %red_ghost, %orange_ghost, %pink_ghost)		# Reposicionamento para reiniciar o jogo com menos uma vida
	j collision_detection_end
	collision_detection_orange_not_collision:
	
	bne %pacman, %pink_ghost, collision_detection_pink_not_collision	# Se nao houver colisao do pacman com o fantasma rosa prosseguir
	addi %life_number, %life_number, -1							# Decrementar a quantidade de vidas
	default_position (%pacman, %blue_ghost, %red_ghost, %orange_ghost, %pink_ghost)		# Reposicionamento para reiniciar o jogo com menos uma vida
	j collision_detection_end
	collision_detection_pink_not_collision:
	
	collision_detection_end:
	
	# Pop from stack
	# Pop from stack
.end_macro

#############################################################
#############################################################
#############################################################
