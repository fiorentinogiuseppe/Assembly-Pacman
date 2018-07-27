Especificações:

    Cores:
        #000000 - representa o espaço vazio
        #2d32b8 - representa a parede
        #ffffff - representa os pac_dots

    Os nós são representados 5 por palavras de 4 bytes:
        | ID | up | right | down | left |

    Onde 'up, right, down, left' se refere a quantidade de bytes necessários para
    a partir da posição atual se encontrar o próximo nó do grafo (offset).

    Necessário ajustar as variáveis do arquivo bot.py:
    file_source = arquivo fonte do xml
    file_destiny = arquivo destino do grafo
    width_of_matrix = largura da matrix na planilha
    height_of_matrix = altura da matrix na planilha
    size_of_structure = tamanho da estrutura (nó) em bytes

    A planilha precisa ser salva no formato FLAT XML ODF SPREADSHEET (.fods) - libreoffice
    cada célula da matrix precisa conter uma fórmula para ficar armazenada no xml.
