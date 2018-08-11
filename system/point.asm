# Este arquivo ira armazenar todos procedimentos para gerenciamento de pontuacao

# Procedimento para incrementar pontuacao
# %incrementation_amount	-> inteiro contem a quantidade de pontuacao que deve ser adicionada
# %puntuation			-> registrador que contem a quantidade de pontuacao atual
.macro increment_point (%puntuation, %incrementation_amount)
	addi %puntuation, %puntuation, %incrementation_amount
.end_macro
