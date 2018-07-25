.data				     # |4b|4bits|4bit|4bits|4bit
	estrutura: 	.space 1024  # |id|north|east|south|west
	gameSpeed:	.word 200
	cor: 		.word 0x000000FF
	bitmap_adress: 	.word 0x10010000
	bitmap_size:  	.word 4096 #64x64 pixels
	fileInput: 	.asciiz "maps.txt"
	buffer: 	.space 1024
	array: 		.space 20

.text

	main:
		jal loadmap
		jal bitmap
		jal exit
		
	loadmap:
		addiu   $sp,$sp,-4     # aloca 1 posições na pilha -> 1*4
	        sw      $ra, 0($sp)	# empilha o endereço de retorno par ao SO
		jal file_open
		jal file_read
		jal file_close
		
		la $t0, buffer
		move $a0, $t0
		jal load_map #carregar o mapa em uma estrutura
														
		lw      $ra,0($sp)      # ao voltar, recupera endereço de retorno da pilha
       		addiu   $sp,$sp,4
       		jr $ra
       	
       	load_map:
     		li $t0, 0 # initialize the count to zero
		la $t2, estrutura	
		li $t6,0x0A              # ASCII value for newline
		li $t7, 0x20 		 # ASCII value for space	
		loop_load:
			lb $t1, 0($a0) # load the next character into t1
			beqz $t1, sair_load # check for the null character
			
			lb $t1, 0($a0) # load the next character into t1
			beq $t1,$t6,pula_load # check for the \n
			
			lb $t1, 0($a0) # load the next character into t1
			beq $t1,$t7 ,pula_load # check for the space
		
			addi $t0, $t0, 1 # increment the count
			sw $t1, 0($t2)
			addi $t2, $t2, 4
			pula_load: addi $t0, $t0, 1 # increment the count
			addi $a0, $a0, 1 # increment the string pointer	

		j loop_load
		sair_load:
			jr $ra       		
       	strlen: #contador de nos
		li $t0, 0 # initialize the count to zero
		la $t2, estrutura
		li $t6,0x0A              # ASCII value for newline
		li $t7, 0x20 		 # ASCII value for space
		loop_strlen:
			lb $t1, 0($a0) # load the next character into t1
			beqz $t1, sair_strlen # check for the null character
			 
			lb $t1, 0($a0) # load the next character into t1
			bne $t1,$t6 ,pula # check for the \n

			addi $t0, $t0, 1 # increment the count
			pula:addi $a0, $a0, 1 # increment the string pointer
		j loop_strlen # return to the top of the loop
		sair_strlen:
			move $v0, $t0
			jr $ra
		
	node: #nao precisa mais, mas vou deixar aqui por enquanto
		la $t0, ($s7)	#id
		la $t1, 0	#N
		la $t2, 0	#E
		la $t3, 0	#S
		la $t4, 0	#W
		
		sw $t0, 0($s6)	 #id 
		sw $t1, 4($s6)	 #N
		sw $t2, 8($s6)   #E
		sw $t3, 12($s6)	 #S
		sw $t4, 16($s6)  #W
		
		add $s6, $s6 ,20
		jr $ra
	
	bitmap:		
		lw $t0, bitmap_adress
		lw $t1, cor
		lw $t2, bitmap_size
		li $t6, 1
		move $t3, $zero #contador
		
		bitmap_loop:
			beq	$t3,$t2, bitmap_exit
			sll	$t4, $t3, 2 #contagem de bit em contagem de bytes. Display eh uma palavra. Cada palavra do display pinta um pixel
			add	$t4, $t4, $t0 #coloca na area de display
			sw	$t1,0($t4) #escrever no pixel
			addi	$t3,$t3, 1 #ir pro proximo prixel
		
		cont: j bitmap_loop
	
	
		bitmap_exit: jr $ra
		
	InputCheck:
		lw $a0, gameSpeed
		jal Pause

		#get the input from the keyboard
		li $t0, 0xffff0004
		lw $t1, ($t0)
		andi $t1, $t1, 0x0001
		lw $a1, 4($t0) #store direction based on input
		
	Pause:
		li $v0, 32 #syscall value for sleep
		syscall
		jr $ra
	
	file_open:
			li $v0, 13 #system call for open file
			la $a0, fileInput #board file name
			li $a1,0 #open for reading
			li $a2, 0
			syscall #open a file
			move $s6, $v0 #save the file descriptor
			jr $ra
	file_read:
		li   $v0, 14       # system call for read from file
		move $a0, $s6      # file descriptor 
		la   $a1, buffer   # address of buffer to which to read
		li   $a2, 1024     # hardcoded buffer length
		syscall            # read from file
		jr $ra
	file_close:
		li   $v0, 16       # system call for close file
		move $a0, $s6      # file descriptor to close
		syscall
		jr $ra
	exit:		
		li $v0, 10		# system call code for exit = 10
		syscall
