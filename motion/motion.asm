# Este arquivo contem procedimentos para efetuar o movimento dos personagens no labirinto

.data
	.space 4096

.include "../graph/data.bin"
.include "../display/screen.asm"
.include "../system/point.asm"

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


.text

li $s0, 0x10010000
li $s1, 256
la $s2, graph

draw_maze ($s0, $s2, $s1)

addi $s3, $s2, 480

move_right ($s3)
move_right ($s3)
move_right ($s3)






