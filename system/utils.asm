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