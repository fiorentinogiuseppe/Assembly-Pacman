# Macros para usar no projeto

# For loop
# %reg_iterator -> registrador para iterar
# %from		-> registrador que contem o inicio	- pode ser inteiro
# %to		-> registrador que contem o fim 	- pode ser inteiro
# %body		-> nome do macro que contem o procedimento que sera executado
.macro for (%reg_iterator, %from, %to, %body)
	add %reg_iterator, $zero, %from
	FOR_LOOP:
		%body
		addi %reg_iterator, %reg_iterator, 1
		ble  %reg_iterator, %to, FOR_LOOP
.end_macro


#########################################################
#########################################################
#########################################################


# Print string
.macro print_str (%str)
.data
	print_string_label:	.asciiz %str
.text
	# Push to stack
	addi $sp, $sp, -8
	sw $v0, 0($sp)
	sw $a0, 4($sp)
	# Push to stack
	addi $v0, $zero, 4
	la $a0, print_string_label
	syscall
	# Pop from stack
	lw $v0, 0($sp)
	lw $a0, 4($sp)
	addi $sp, $sp, 8
	# Pop from stack
.end_macro

