# Este arquivo ira armazenar todos procedimentos para gerenciamento de pontuacao

.data
	.space 4096

.include "../graph/data.bin"
.include "../display/screen.asm"

# Procedimento para incrementar pontuacao
# %incrementation_amount	-> inteiro contem a quantidade de pontuacao que deve ser adicionada
# %puntuation			-> registrador que contem a quantidade de pontuacao atual
.macro increment_point (%puntuation, %incrementation_amount)
	addi %puntuation, %puntuation, %incrementation_amount
.end_macro


#############################################################
#############################################################
#############################################################


# Procedimento para desenhar a pontuacao na tela com base no pixel superior esquerdo
# %initial_pixel	-> registrador com endereco para o pixel superior esquerdo onde sera posicionado o pontuador
# %number		-> registrador com valor da pontuacao que sera pintada na tela
.macro draw_points (%initial_pixel, %number)
	# Push to stack
	addi $sp, $sp, -48
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	sw $s6, 24($sp)
	sw $s7, 28($sp)
	sw $t0, 32($sp)
	sw $t1, 36($sp)
	sw %initial_pixel,	40($sp)
	sw %number,		44($sp)
	# Push to stack
	
	add $t0, $zero, %number
	li $t1, 10		# Carregar a base numerica da divisao
	
	# Extrair primeiro digito (menor ordem)
	div $t0, $t1
	mfhi $s0		# <$s0> = <$t0> % 10 -> primeiro digito
	mflo $t0		# <$t0> = <$t0> / 10 
	
	# Extrair segundo digito
	div $t0, $t1
	mfhi $s1		# <$s1> = <$t0> % 10 -> segundo digito
	mflo $t0		# <$t0> = <$t0> / 10 
	
	# Extrair terceiro digito
	div $t0, $t1
	mfhi $s2		# <$s1> = <$t0> % 10 -> terceiro digito
	mflo $t0		# <$t0> = <$t0> / 10 
	
	# Extrair quarto digito
	div $t0, $t1
	mfhi $s3		# <$s1> = <$t0> % 10 -> quarto digito
	mflo $t0		# <$t0> = <$t0> / 10 
	
	# Extrair quinto digito
	div $t0, $t1
	mfhi $s4		# <$s1> = <$t0> % 10 -> quinto digito
	mflo $t0		# <$t0> = <$t0> / 10 
	
	# Extrair sexto digito
	div $t0, $t1
	mfhi $s5		# <$s1> = <$t0> % 10 -> sexto digito
	mflo $t0		# <$t0> = <$t0> / 10 
	
	# Extrair setimo digito
	div $t0, $t1
	mfhi $s6		# <$s1> = <$t0> % 10 -> setimo digito
	mflo $t0		# <$t0> = <$t0> / 10 
	
	# Extrair oitavo digito
	div $t0, $t1
	mfhi $s7		# <$s1> = <$t0> % 10 -> oitavo digito
	mflo $t0		# <$t0> = <$t0> / 10
	
	
	# Pintar a pontuacao na tela
	lw $t0, 40($sp)		# <$t0> initial_pixel
	
	#draw_number ($t0, $s6)	# Pintar setimo digito
	#addi $t0, $t0, 16
	#draw_number ($t0, $s5)	# Pintar sexto digito
	#addi $t0, $t0, 16
	#draw_number ($t0, $s4)	# Pintar quinto digito
	#addi $t0, $t0, 16
	draw_number ($t0, $s3)	# Pintar quarto digito
	addi $t0, $t0, 16
	draw_number ($t0, $s2)	# Pintar terceiro digito
	addi $t0, $t0, 16
	draw_number ($t0, $s1)	# Pintar segundo digito
	addi $t0, $t0, 16
	draw_number ($t0, $s0)	# Pintar primeiro digito
	addi $t0, $t0, 16
	
	
	# Pop from stack
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw $s5, 20($sp)
	lw $s6, 24($sp)
	lw $s7, 28($sp)
	lw $t0, 32($sp)
	lw $t1, 36($sp)
	lw %initial_pixel,	40($sp)
	lw %number,		44($sp)
	addi $sp, $sp, 40
	# Pop from stack
.end_macro


#############################################################
#############################################################
#############################################################


# Procedimento para desenhar um digito
# %initial_pixel	-> registrador com endereco para o pixel superior esquerdo onde sera posicionado o pontuador
# %number		-> registrador com valor do digito
.macro draw_number (%initial_pixel, %number)
	# Push to stack
	addi $sp, $sp, -48
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	sw $s6, 24($sp)
	sw $s7, 28($sp)
	sw $t0, 32($sp)
	sw $t1, 36($sp)
	sw %initial_pixel,	40($sp)
	sw %number,		44($sp)
	# Push to stack
	
	lw $t0, 44($sp)		# <$t0> number
	lw $t1, 40($sp)		# <$t1> initial_pixel
	addi $s0, $zero, 0x00000000
	addi $s1, $zero, 0x00ffffff
	
	bne $t0, 0x0, draw_number_not_zero
	# Primeira linha
	sw $s1, 0($t1)
	sw $s1, 4($t1)
	sw $s1, 8($t1)
	# Segunda linha
	addi $t1, $t1, 64
	sw $s1, 0($t1)
	sw $s0, 4($t1)
	sw $s1, 8($t1)
	# Terceira linha
	addi $t1, $t1, 64
	sw $s1, 0($t1)
	sw $s0, 4($t1)
	sw $s1, 8($t1)
	# Quarta linha
	addi $t1, $t1, 64
	sw $s1, 0($t1)
	sw $s0, 4($t1)
	sw $s1, 8($t1)
	# Quinta linha
	addi $t1, $t1, 64
	sw $s1, 0($t1)
	sw $s1, 4($t1)
	sw $s1, 8($t1)
	j draw_number_end
	draw_number_not_zero:
	
	bne $t0, 0x1, draw_number_not_one
	# Primeira linha
	sw $s0, 0($t1)
	sw $s1, 4($t1)
	sw $s0, 8($t1)
	# Segunda linha
	addi $t1, $t1, 64
	sw $s1, 0($t1)
	sw $s1, 4($t1)
	sw $s0, 8($t1)
	# Terceira linha
	addi $t1, $t1, 64
	sw $s0, 0($t1)
	sw $s1, 4($t1)
	sw $s0, 8($t1)
	# Quarta linha
	addi $t1, $t1, 64
	sw $s0, 0($t1)
	sw $s1, 4($t1)
	sw $s0, 8($t1)
	# Quinta linha
	addi $t1, $t1, 64
	sw $s1, 0($t1)
	sw $s1, 4($t1)
	sw $s1, 8($t1)
	j draw_number_end
	draw_number_not_one:
	
	bne $t0, 0x2, draw_number_not_two
	# Primeira linha
	sw $s1, 0($t1)
	sw $s1, 4($t1)
	sw $s1, 8($t1)
	# Segunda linha
	addi $t1, $t1, 64
	sw $s0, 0($t1)
	sw $s0, 4($t1)
	sw $s1, 8($t1)
	# Terceira linha
	addi $t1, $t1, 64
	sw $s1, 0($t1)
	sw $s1, 4($t1)
	sw $s1, 8($t1)
	# Quarta linha
	addi $t1, $t1, 64
	sw $s1, 0($t1)
	sw $s0, 4($t1)
	sw $s0, 8($t1)
	# Quinta linha
	addi $t1, $t1, 64
	sw $s1, 0($t1)
	sw $s1, 4($t1)
	sw $s1, 8($t1)
	j draw_number_end
	draw_number_not_two:
	
	bne $t0, 0x3, draw_number_not_three
	# Primeira linha
	sw $s1, 0($t1)
	sw $s1, 4($t1)
	sw $s1, 8($t1)
	# Segunda linha
	addi $t1, $t1, 64
	sw $s0, 0($t1)
	sw $s0, 4($t1)
	sw $s1, 8($t1)
	# Terceira linha
	addi $t1, $t1, 64
	sw $s1, 0($t1)
	sw $s1, 4($t1)
	sw $s1, 8($t1)
	# Quarta linha
	addi $t1, $t1, 64
	sw $s0, 0($t1)
	sw $s0, 4($t1)
	sw $s1, 8($t1)
	# Quinta linha
	addi $t1, $t1, 64
	sw $s1, 0($t1)
	sw $s1, 4($t1)
	sw $s1, 8($t1)
	j draw_number_end
	draw_number_not_three:
	
	bne $t0, 0x4, draw_number_not_four
	# Primeira linha
	sw $s1, 0($t1)
	sw $s0, 4($t1)
	sw $s1, 8($t1)
	# Segunda linha
	addi $t1, $t1, 64
	sw $s1, 0($t1)
	sw $s0, 4($t1)
	sw $s1, 8($t1)
	# Terceira linha
	addi $t1, $t1, 64
	sw $s1, 0($t1)
	sw $s1, 4($t1)
	sw $s1, 8($t1)
	# Quarta linha
	addi $t1, $t1, 64
	sw $s0, 0($t1)
	sw $s0, 4($t1)
	sw $s1, 8($t1)
	# Quinta linha
	addi $t1, $t1, 64
	sw $s0, 0($t1)
	sw $s0, 4($t1)
	sw $s1, 8($t1)
	j draw_number_end
	draw_number_not_four:
	
	bne $t0, 0x5, draw_number_not_five
	# Primeira linha
	sw $s1, 0($t1)
	sw $s1, 4($t1)
	sw $s1, 8($t1)
	# Segunda linha
	addi $t1, $t1, 64
	sw $s1, 0($t1)
	sw $s0, 4($t1)
	sw $s0, 8($t1)
	# Terceira linha
	addi $t1, $t1, 64
	sw $s1, 0($t1)
	sw $s1, 4($t1)
	sw $s1, 8($t1)
	# Quarta linha
	addi $t1, $t1, 64
	sw $s0, 0($t1)
	sw $s0, 4($t1)
	sw $s1, 8($t1)
	# Quinta linha
	addi $t1, $t1, 64
	sw $s1, 0($t1)
	sw $s1, 4($t1)
	sw $s1, 8($t1)
	j draw_number_end
	draw_number_not_five:
	
	bne $t0, 0x6, draw_number_not_six
	# Primeira linha
	sw $s1, 0($t1)
	sw $s1, 4($t1)
	sw $s1, 8($t1)
	# Segunda linha
	addi $t1, $t1, 64
	sw $s1, 0($t1)
	sw $s0, 4($t1)
	sw $s0, 8($t1)
	# Terceira linha
	addi $t1, $t1, 64
	sw $s1, 0($t1)
	sw $s1, 4($t1)
	sw $s1, 8($t1)
	# Quarta linha
	addi $t1, $t1, 64
	sw $s1, 0($t1)
	sw $s0, 4($t1)
	sw $s1, 8($t1)
	# Quinta linha
	addi $t1, $t1, 64
	sw $s1, 0($t1)
	sw $s1, 4($t1)
	sw $s1, 8($t1)
	j draw_number_end
	draw_number_not_six:
	
	bne $t0, 0x7, draw_number_not_seven
	# Primeira linha
	sw $s1, 0($t1)
	sw $s1, 4($t1)
	sw $s1, 8($t1)
	# Segunda linha
	addi $t1, $t1, 64
	sw $s0, 0($t1)
	sw $s0, 4($t1)
	sw $s1, 8($t1)
	# Terceira linha
	addi $t1, $t1, 64
	sw $s0, 0($t1)
	sw $s0, 4($t1)
	sw $s1, 8($t1)
	# Quarta linha
	addi $t1, $t1, 64
	sw $s0, 0($t1)
	sw $s0, 4($t1)
	sw $s1, 8($t1)
	# Quinta linha
	addi $t1, $t1, 64
	sw $s0, 0($t1)
	sw $s0, 4($t1)
	sw $s1, 8($t1)
	j draw_number_end
	draw_number_not_seven:
	
	
	bne $t0, 0x8, draw_number_not_eight
	# Primeira linha
	sw $s1, 0($t1)
	sw $s1, 4($t1)
	sw $s1, 8($t1)
	# Segunda linha
	addi $t1, $t1, 64
	sw $s1, 0($t1)
	sw $s0, 4($t1)
	sw $s1, 8($t1)
	# Terceira linha
	addi $t1, $t1, 64
	sw $s1, 0($t1)
	sw $s1, 4($t1)
	sw $s1, 8($t1)
	# Quarta linha
	addi $t1, $t1, 64
	sw $s1, 0($t1)
	sw $s0, 4($t1)
	sw $s1, 8($t1)
	# Quinta linha
	addi $t1, $t1, 64
	sw $s1, 0($t1)
	sw $s1, 4($t1)
	sw $s1, 8($t1)
	j draw_number_end
	draw_number_not_eight:
	
	bne $t0, 0x9, draw_number_not_nine
	# Primeira linha
	sw $s1, 0($t1)
	sw $s1, 4($t1)
	sw $s1, 8($t1)
	# Segunda linha
	addi $t1, $t1, 64
	sw $s1, 0($t1)
	sw $s0, 4($t1)
	sw $s1, 8($t1)
	# Terceira linha
	addi $t1, $t1, 64
	sw $s1, 0($t1)
	sw $s1, 4($t1)
	sw $s1, 8($t1)
	# Quarta linha
	addi $t1, $t1, 64
	sw $s0, 0($t1)
	sw $s0, 4($t1)
	sw $s1, 8($t1)
	# Quinta linha
	addi $t1, $t1, 64
	sw $s0, 0($t1)
	sw $s0, 4($t1)
	sw $s1, 8($t1)
	j draw_number_end
	draw_number_not_nine:
	
	draw_number_end:
	# Pop from stack
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw $s5, 20($sp)
	lw $s6, 24($sp)
	lw $s7, 28($sp)
	lw $t0, 32($sp)
	lw $t1, 36($sp)
	lw %initial_pixel,	40($sp)
	lw %number,		44($sp)
	addi $sp, $sp, 40
	# Pop from stack
.end_macro

.text

li $s0, 0x10010000	# endereco inicial da tela
li $s1, 256		# quantidade de pixels total
la $s2, graph		# endereco do primeiro no do grafo


draw_maze($s0, $s2, $s1)	# Funcao que pinta os pixels baseado no grafo

addi $s4, $zero, 908

draw_points ($s0, $s4)
