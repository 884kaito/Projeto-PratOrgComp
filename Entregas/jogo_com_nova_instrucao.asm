jmp main

; ================/ UTILIZAÇÃO /================
;ETAPA DE ESCRITA
;-WASD para movimentar
;-C para escrever
;-R para começar a escrita
;ETAPA DE SIMULAÇÃO
;-E para voltar na etapa de escrita
;-H para terminar o programa





; ================/ VARIÁVEIS /================
matrix_a: var #1200 ; proporções 40 x 30
matrix_b: var #1200 ; proporções 40 x 30





; ================/ MAIN /================
main:	

	; ====/ INICIALIZANDO AS MATRIZES
	loadn r0, #matrix_a
	call matrix_init
	
	loadn r0, #matrix_b
	call matrix_init
	
	; ====/ INICIALIZANDO VARIÁVEIS
	loadn r0, #matrix_b
	loadn r1, #matrix_a
	loadn r7, #7
	
	; ====/ CONFIGURANDO O ESTÁGIO INICIAL DA MATRIZ
	main_edit_fase:
		call matrix_print
		call matrix_modify
	
	; ====/ LOOP DE EXECUÇÃO
	main_loop: ; tag para o loop principal
		; TROCANDO AS MATRIZES DE LUGAR
		mov r5, r0 ; SALVANDO O R0
		mov r0, r1 ; PASSANDO O R1 PARA O R0
		mov r1, r5 ; PASSANDO O R0 SALVO PARA O R1
		
		; SIMULANDO A FÍSICA
		call matrix_simulate
		
		; IMPRIMINDO MUDANÇAS
		call matrix_print

		; INPUT DO USUÁRIO
		inchar r4	; Input do teclado.

		; BUSCANDO PELA CONDIÇÃO DE EDIÇÃO
		loadn r5, #'e'
		cmp r4, r5
		jeq main_edit_fase
		
		; BUSCANDO PELA CONDIÇÃO DE TERMINO
		loadn r5, #'h'
		cmp r4, r5
		jne main_loop ; voltando para o loop
	; end loop "main_loop"
	
	halt ; finalizando o programa






; ================/ PROCEDIMENTOS /================

; ========// MATRIX :: INIT
; Inicializa todas as células de uma tabela para serem iguais a celulas mortas.
;
; @param {address}	r0	MATRIX	Pointeiro para a matrix que será inicializada.
;
matrix_init:
	; ====/ FAZE INICIAL
	; SALVANDO REGISTRADORES
	push r0	; Salvando temporariamento o valor de r0
	push r1	; Salvando temporariamento o valor de r1
	push r2	; Salvando temporariamento o valor de r2
	
	; INICIALIZANDO CONSTANTES
	; @const {character}	r1	Constante caracter que guarda o valor de uma
	;	célula morta.
	; @const {address}	r2	Constante que guarda o endereço do fim da matriz.
	loadn r1, #1070	; Guardando o caracter '.' azul
	loadn r2, #1200	; Guardando o tamanho da matrix em um registrador
	add r2, r2, r0	; Guardando a posição do fim da matrix em um registrador
		
	; ====/ FASE DE EXECUÇÃO
	; LOOP DE EXECUÇÃO
	matrix_init_loop:
		storei r0, r1 ; Inicializando determinada célula
		inc r0	; Passando para a próxima célula
		cmp r0, r2	; Checando se ainda estamos dentro da matriz
		jle matrix_init_loop	; Repetindo o loop se ainda estivermos dentro
								;	da matrix.
	
	; ====/ FASE DE FINALIZAÇÃO 
	; DEVOLVENDO REGISTRADORES
	pop r2 ; devolvendo o valor antigo de r2
	pop r1 ; devolvendo o valor antigo de r1
	pop r0 ; devolvendo o valor antigo de r0
		
	rts ; retorno


; ========// MATRIX :: PRINT
; Imprime uma matrix na tela.
;
; @param {address}	r0	MATRIX	Pointeiro para a matrix que será impressa.
;
matrix_print:
	; ====/ FAZE INICIAL
	; SALVANDO REGISTRADORES
	push r0	; Salvando temporariamento o valor de r0
	push r1	; Salvando temporariamento o valor de r1
	push r2	; Salvando temporariamento o valor de r2
	push r3	; Salvando temporariamento o valor de r3
	
	; INICIALIZANDO CONSTANTES
	; @const {address}	r2	Constante que guarda o endereço do fim da matriz.
	loadn r2, #1200	; Guardando o tamanho da matrix em um registrador
	add r2, r2, r0	; Guardando a posição do fim da matrix em um registrador
	
	; INICIALIZANDO VARIÁVEIS
	; @var {integer}	r1	Variável que indica a posição para a impressão na tela.
	; @var {character}	r3	Variável que guarda o caracter a ser impresso.
	loadz r1	; Inicializando o valor de r1 para 0.
		
	; ====/ FASE DE EXECUÇÃO
	; LOOP DE EXECUÇÃO
	matrix_print_loop:
		loadi r3, r0	; Carregando o caracter que será impresso. 
		outchar r3, r1 ; Impressão
		
		inc r0	; Passando para a próxima célula
		inc r1	; Avançando o cursor de impressão na tela
		
		cmp r0, r2	; Checando se ainda estamos dentro da matriz
		jle matrix_print_loop	; Repetindo o loop se ainda estivermos dentro
								;	da matrix.
	
	; ====/ FASE DE FINALIZAÇÃO 
	; DEVOLVENDO REGISTRADORES
	pop r3 ; devolvendo o valor antigo de r3
	pop r2 ; devolvendo o valor antigo de r2
	pop r1 ; devolvendo o valor antigo de r1
	pop r0 ; devolvendo o valor antigo de r0
		
	rts ; retorno


; ========// MATRIX :: PRINT
; Modifica uma matriz.
;
; @param {address}	r0	MATRIX	Pointeiro para a matrix que será modificada.
;
matrix_modify:
	; ====/ FAZE INICIAL
	; SALVANDO REGISTRADORES
	push r0	; Salvando temporariamento o valor de r0
	push r1	; Salvando temporariamento o valor de r1
	push r2	; Salvando temporariamento o valor de r2
	push r3	; Salvando temporariamento o valor de r3
	push r4	; Salvando temporariamento o valor de r3
	push r5	; Salvando temporariamento o valor de r5
	push r6	; Salvando temporariamento o valor de r6
	push r7	; Salvando temporariamento o valor de r7
	
	; INICIALIZANDO CONSTANTES
	; @const {address}	r2	Constante que guarda o endereço do fim da matriz.
	; @const {integer}	r4	Constante que guarda uma mascara: 0x00FF
	loadn r2, #1200	; Guardando o tamanho da matrix em um registrador
	add r2, r2, r0	; Guardando a posição do fim da matrix em um registrador
	loadn r4, #255	; Guardando uma mascara na memória.
	loadn r6, #40	; Inicializando r6 para ser o tamanho de uma linha.
	loadn r7, #1200	; Inicializando r7 para ser o tamanho da tela.
	
	; INICIALIZANDO VARIÁVEIS
	; @var {integer}	r1	Variável que indica a posição para a impressão na tela.
	; @var {character}	r3	Variável que guarda o caracter a ser impresso.
	; @var {character}	r5	Variável que guarda o input do usuário.
	loadz r1	; Inicializando o valor de r1 para 0.
	loadz r5	; Inicializando r5 (Não sei se é necessário.)
		
	; ====/ FASE DE EXECUÇÃO
	; LOOP DE EXECUÇÃO
	matrix_modify_loop:
		loadi r3, r0	; Carregando o caracter que será impresso.
		and r3, r3, r4	; Modificando a cor do caracter
		outchar r3, r1 	; Impressão
		
		inchar r5	; Escutando pelo input do usuário
		
		loadn r3, #'w' ; Carregando 'w' temporariamente
		cmp r5, r3	; Comparando o input a 'w'
		jeq matrix_modify_pressed_w ; Caso o usuário tenha apertado 'w'
		
		loadn r3, #'a' ; Carregando 'a' temporariamente
		cmp r5, r3	; Comparando o input a 'a'
		jeq matrix_modify_pressed_a ; Caso o usuário tenha apertado 'a'
		
		loadn r3, #'s' ; Carregando 's' temporariamente
		cmp r5, r3	; Comparando o input a 's'
		jeq matrix_modify_pressed_s ; Caso o usuário tenha apertado 's'
		
		loadn r3, #'d' ; Carregando 'd' temporariamente
		cmp r5, r3	; Comparando o input a 'd'
		jeq matrix_modify_pressed_d ; Caso o usuário tenha apertado 'd'
		
		loadn r3, #'c' ; Carregando 'c' temporariamente
		cmp r5, r3	; Comparando o input a 'c'
		jeq matrix_modify_pressed_c ; Caso o usuário tenha apertado 'c'
		
		loadn r3, #'d' ; Carregando 'd' temporariamente
		cmp r5, r3	; Comparando o input a 'd'
		jeq matrix_modify_pressed_d ; Caso o usuário tenha apertado 'd'
		
		loadn r3, #'r' ; Carregando 'r' temporariamente
		cmp r5, r3	; Comparando o input a 'r'
		jeq matrix_modify_pressed_r ; Caso o usuário tenha apertado 'r'
		
		jmp matrix_modify_loop ; Caso o usuário não tenha fornecido um input relevante
		
		
		matrix_modify_pressed_w: ; INPUT == 'W'
			cmp r1, r6	; Checando se o movimento é válido.
			jle matrix_modify_loop
		
			call matrix_modify_unselect ; Removendo a seleção atual
			
			sub r1, r1, r6	; Pulando para a linha de cima (subtraindo 40).
			sub r0, r0, r6	; Passando para a célula de cima memória.
			
			cmp r1, r7	; Checando se o movimento foi válido.
			
			jle matrix_modify_loop ; Voltando para o loop se tudo deu certo
			
			; Corrigindo essa ação em caso de erro.
			add r1, r1, r6	; Voltando para a linha de baixo (subtraindo 40).
			add r0, r0, r6	; Voltando para a célula de baixo memória.
			
			jmp matrix_modify_loop ; Voltando ao loop
			
		matrix_modify_pressed_a: ; INPUT == 'A'
			call matrix_modify_unselect ; Removendo a seleção atual
			
			dec r1	; Pulando para o caracter da esquerda (subtraindo 1).
			dec r0	; Passando para a célula da esquerda.
			
			loadz r5
			cmp r1, r5	; Checando se o movimento foi válido.
			jle matrix_modify_pressed_a_undo
			
			mod r3, r1, r6	; Calculando posição_na_tela mod 40 para validar a ação.
			loadn r5, #39
			cmp r3, r5	; Checando se o movimento foi válido.
			
			jne matrix_modify_loop ; Voltando para o loop se tudo deu certo
			
			; Corrigindo essa ação em caso de erro.
			matrix_modify_pressed_a_undo:
				inc r1	; Voltando para o caracter da direita (somando 1).
				inc r0	; Voltando para a célula da direita.
			
			jmp matrix_modify_loop ; Voltando ao loop
		
		matrix_modify_pressed_s: ; INPUT == 'S'
			call matrix_modify_unselect ; Removendo a seleção atual
			
			add r1, r1, r6	; Pulando para a linha de baixo (adicionando 40).
			add r0, r0, r6	; Passando para a célula de baixo na memória.
			
			cmp r1, r7	; Checando se o movimento foi válido.
			
			jle matrix_modify_loop ; Voltando para o loop se tudo deu certo
			
			; Corrigindo essa ação em caso de erro.
			sub r1, r1, r6 ; Voltando para a posição da tela anterior.
			sub r0, r0, r6 ; Voltando para a posição na memória anterior
			
			jmp matrix_modify_loop ; Voltando ao loop
			
		matrix_modify_pressed_d: ; INPUT == 'D'
			call matrix_modify_unselect ; Removendo a seleção atual
			
			inc r1	; Indo para o caracter da direita (somando 1).
			inc r0	; Indo para a célula da direita.
			
			mod r3, r1, r6	; Calculando posição_na_tela mod 40 para validar a ação.
			loadz r5
			cmp r3, r5	; Checando se o movimento foi válido.
			
			jne matrix_modify_loop ; Voltando para o loop se tudo deu certo
			
			; Corrigindo essa ação em caso de erro.
			dec r1	; Voltando para o caracter da esquerda (subtraindo 1).
			dec r0	; Voltando para a célula da esquerda.
			
			jmp matrix_modify_loop ; Voltando ao loop
			
		matrix_modify_pressed_r: ; INPUT == 'R'
			call matrix_modify_unselect ; Removendo a seleção atual
			jmp matrix_modify_end
		
		matrix_modify_unselect: ; Removendo a seleção de caracter.
			loadi r3, r0	; Carregando o caracter que será impresso.
			outchar r3, r1 ; Impressão
			rts
			
		matrix_modify_pressed_c:
			loadi r3, r0	; Carregando o caracter.
			loadn r5, #547	; Carregando valor de célula viva.
			cmp r3, r5
			jeq matrix_modify_kill
			
			storei r0, r5
			jmp matrix_modify_loop
			
			matrix_modify_kill:
				loadn r5, #1070	; Carregando valor de célula morta.
				storei r0, r5
				jmp matrix_modify_loop
				
		
		jmp matrix_modify_loop
		
	
	; ====/ FASE DE FINALIZAÇÃO 
	matrix_modify_end:
		; DEVOLVENDO REGISTRADORES
		pop r7 ; devolvendo o valor antigo de r7
		pop r6 ; devolvendo o valor antigo de r6
		pop r5 ; devolvendo o valor antigo de r5
		pop r4 ; devolvendo o valor antigo de r4
		pop r3 ; devolvendo o valor antigo de r3
		pop r2 ; devolvendo o valor antigo de r2
		pop r1 ; devolvendo o valor antigo de r1
		pop r0 ; devolvendo o valor antigo de r0
		
	rts ; retorno
	
	

	

; ========// MATRIX :: SIMULATE
; Simula um frame de do jogo da vida de Conway.
;
; @param {address}	r0	MATRIX	Pointeiro para a matrix que será modificada.
; @param {address}	r1	MATRIX	Pointeiro para a matrix que será usada de
;	referência para realizar as modificações.
;
matrix_simulate:
	; ====/ FAZE INICIAL
	; SALVANDO REGISTRADORES
	push r0	; Salvando temporariamento o valor de r0
	push r1	; Salvando temporariamento o valor de r1
	push r2	; Salvando temporariamento o valor de r2
	push r3	; Salvando temporariamento o valor de r3
	push r4	; Salvando temporariamento o valor de r3
	push r5	; Salvando temporariamento o valor de r5
	push r6	; Salvando temporariamento o valor de r6
	
	; INICIALIZANDO CONSTANTES
	loadn r4, #30	; Guardando o tamanho da matrix em um registrador
	loadn r5, #40	; Guardando o tamanho da matrix em um registrador
	
	; INICIALIZANDO VARIÁVEIS
	loadz r2	; Contador ; r2 := i
	loadz r3	; Contador ; r3 := j
	loadz r7	; Numero de vizinhos vivos
		
	; ====/ FASE DE EXECUÇÃO
	; LOOP DE EXECUÇÃO
	matrix_simulate_loop_i:
		loadz r3	; Contador ; r3 := j
		matrix_simulate_loop_j:
		
		
			; CALCULANDO A ENERGIA VITAL
			call cell_getLifeEnergy ; Coloca número de vivos no r7

			loadn r6, #3 ; Carrega 3 no r6
			cmp r7, r6 ;Compara o r7 com 3
			jgr matrix_simulate_loop_kill ; Célula com mais de 3 matam a célula
			jeq matrix_simulate_loop_rise ; 3 vizinhos trazem a célula à vida
			
			loadn r6, #2 ; Carrega 2 no r6
			cmp r7, r6 ;Compara o r7 com 2
			jle matrix_simulate_loop_kill ; Menos de 2 vizinhos mata a célula
			
			
			call cell_copy ;O resto mantém
			jmp matrix_simulate_loop_continue
			
			matrix_simulate_loop_kill:;Mata célula
				call cell_kill
				jmp matrix_simulate_loop_continue
				
			matrix_simulate_loop_rise:;Dá vida 
				call cell_rise
			
			
			matrix_simulate_loop_continue:
			
			;vai para o proximo loop (r3 vai de 0 ate 39)
			inc r3
			cmp r3, r5
			jle matrix_simulate_loop_j
		
		;vai para o proximo loop (r2 vai de 0 ate 29)
		inc r2
		cmp r2, r4
		jle matrix_simulate_loop_i
		
	
	; ====/ FASE DE FINALIZAÇÃO 
	matrix_simulate_end:
		; DEVOLVENDO REGISTRADORES
		pop r6 ; devolvendo o valor antigo de r6
		pop r5 ; devolvendo o valor antigo de r5
		pop r4 ; devolvendo o valor antigo de r4
		pop r3 ; devolvendo o valor antigo de r3
		pop r2 ; devolvendo o valor antigo de r2
		pop r1 ; devolvendo o valor antigo de r1
		pop r0 ; devolvendo o valor antigo de r0
		
	rts ; retorno


; ========// CELL :: RISE
; Deixa a célula viva
;
; @param {address}	r0	MATRIX	Pointeiro para a matrix que será modificada.
; @param {address}	r2	Endereço na matrix para a célula que será atualizada.
;
cell_rise:
	; ====/ FAZE INICIAL
	; SALVANDO REGISTRADORES
	push r2
	push r5

	; ====/ FASE DE EXECUÇÃO
	loadn r5, #40 	; Salvando o valor 40 temporariamente.
	mul r2, r2, r5  ; Calculado o endereço da célula
	add r2, r2, r3 	; Calculado o endereço da célula
	
	loadn r5, #547 	; carrega # no r5
	add r2, r2, r0 	; seta o r2 na posição
	storei r2, r5 	; Colocando o #
	
	; ====/ FASE DE FINALIZAÇÃO 
	pop r5
	pop r2
	rts



; ========// CELL :: KILL
; Mata a célula
;
; @param {address}	r0	MATRIX	Pointeiro para a matrix que será modificada.
; @param {address}	r2	Endereço na matrix para a célula que será atualizada.
;
cell_kill:
	; ====/ FAZE INICIAL
	; SALVANDO REGISTRADORES
	push r2
	push r5

	; ====/ FASE DE EXECUÇÃO
	loadn r5, #40 	; Salvando o valor 40 temporariamente.
	mul r2, r2, r5  ; Calculado o endereço da célula
	add r2, r2, r3 	; Calculado o endereço da célula
	
	loadn r5, #1070 ; Carregando o . no r5
	add r2, r2, r0	; seta o r2 na posição
	storei r2, r5	; Colocando o .
	
	; ====/ FASE DE FINALIZAÇÃO 
	pop r5
	pop r2
	rts


; ========// CELL :: COPY
; Copia a célula do matriz para a célula do outro matriz de mesma posição
;
; @param {address}	r0	MATRIX	Pointeiro para a matrix que será modificada.
; @param {address}	r1	MATRIX	Pointeiro para a matrix que será usada de
;	referência para realizar as modificações.
; @param {address}	r2	Endereço na matrix para a célula que será atualizada.
;
cell_copy:
	; ====/ FAZE INICIAL
	; SALVANDO REGISTRADORES
	push r1
	push r2
	push r5
	
	; ====/ FASE DE EXECUÇÃO
	loadn r5, #40 	; Salvando o valor 40 temporariamente.
	mul r2, r2, r5  ; Calculado o endereço da célula
	add r2, r2, r3 	; Calculado o endereço da célula
	
	add r1, r2, r1 	; Carregando a célula do r1
	loadi r5, r1
	
	add r2, r2, r0
	storei r2, r5	; Copiando no r0
	
	; ====/ FASE DE FINALIZAÇÃO 
	pop r5
	pop r2
	pop r1
	rts

	
; ========// CELL :: IS ALIVE
; Checa se uma célula está viva
;
; @param {address}	r1	Pointeiro para a matrix que será consultada.
; @param {integer}	r2 	Endereço na matrix para a célula que será
;	analizada.
; @return Incrementa r7 caso a célula esteja viva.
;
cell_isAlive:
	; ====/ FAZE INICIAL
	; SALVANDO REGISTRADORES
	push r2
	push r6
	push r5
	
	; INICIALIZANDO CONSTANTES

	
	; ====/ FASE DE EXECUÇÃO
	; RECUPERANDO O VALOR DA CÉLULA
	add r2, r1, r2	; Calculando o endereço da célula na memória.
	loadi r2, r2	; Recuperando o valor da célula.
	
	; RETORNANDO SE A CÉLULA ESTÁ VIVA OU NÃO
	; Se for # incrementa 1 no r7(contador de vivos)
	loadn r6, #547 ; Carrega #
	cmp r2, r6 ; Compara a célula com #
	jne cell_isAlive_not_as
		inc r7 ; incrementa r7
	cell_isAlive_not_as:
	
	; ====/ FASE DE FINALIZAÇÃO 
	pop r5
	pop r6
	pop r2
	rts
	

; ========// CELL :: FIX COORDS
; Soma a coordenada e o deslocamento, e quando as coordenadas
; levam para fora da matriz, conserta-os.
;
; @param {integer}	r2	Coordenada y da célula.
; @param {integer}	r3	Coordenada x da célula.
; @param {integer}	r4	Deslocamento y da célula + 1.
; @param {integer}	r5	Deslocamento x da célula + 1.
; @return	r2	Coordenada y da célula concertada.
; @return	r3	Coordenada x da célula concertada.
;
cell_fixCoords:
	; ====/ FAZE INICIAL
	; SALVANDO REGISTRADORES
	push r4	; Salvando temporariamento o valor de r3
	push r5	; Salvando temporariamento o valor de r5
	push r6	; Salvando temporariamento o valor de r6
	push r7	; Salvando temporariamento o valor de r7
	
	; INICIALIZANDO CONSTANTES
	
	; ====/ FASE DE EXECUÇÃO
	; CALCULANDO O R2 (i)
	; R2 TEM QUE SER MAIOR OU IGUAL A 0
	loadz r7	;Carrega 0 no r7
	add r6, r4, r2	;Soma r4 com r2
	
	;Se a soma de r4 com r2 for 0, significa que a coordenada
	;em y será o 29(y máximo)
	cmp r6, r7
	jne cell_fixCoords_soFarSoGood_2
		loadn r2, #29 	;r2 = 29
		jmp cell_fixCoords_endR2 	;Não executa a soma normal
	cell_fixCoords_soFarSoGood_2:
	
	;Soma normal (trata caso endereço passar de 30 também)
	loadn r7, #30 	; Carrega 30 no r7
	add r2, r2, r4 	; Cálculo da nova coordenada
	dec r2			; Cálculo da nova coordenada
	mod r2, r2, r7	; r2 % 30 para caso r2 passar de 29 (y máximo)
	
	cell_fixCoords_endR2:
	
	
	
	; CALCULANDO O R3 (j)
	; R3 TEM QUE SER MAIOR OU IGUAL A 0
	loadz r7	;Carrega 0 no r7
	add r6, r5, r3	;Soma r5 com r3
	
	;Se a soma de r5 com r3 for 0, significa que a coordenada
	;em x será o 39(x máximo)
	cmp r6, r7
	jne cell_fixCoords_soFarSoGood_3
		loadn r3, #39	;r = 39
		jmp cell_fixCoords_endR3	;Não executa a soma normal
	cell_fixCoords_soFarSoGood_3:
	
	;Soma normal (trata caso endereço passar de 40 também)
	loadn r7, #40 	; Carrega 40 no r7
	add r3, r3, r5 	; Cálculo da nova coordenada
	dec r3			; Cálculo da nova coordenada
	mod r3, r3, r7	; r3 % 40 para caso r3 passar de 39 (x máximo)
	
	cell_fixCoords_endR3:
	
	; ====/ FASE DE FINALIZAÇÃO 
	pop r7 ; devolvendo o valor antigo de r7
	pop r6 ; devolvendo o valor antigo de r6
	pop r5 ; devolvendo o valor antigo de r5
	pop r4 ; devolvendo o valor antigo de r4
	rts
	
	
	
; ========// CELL :: ANALYSIS
; Checa se uma célula está viva.
;
; @param {address}	r1	Pointeiro para a matrix que será consultada.
; @param {integer}	r2	Coordenada y da célula.
; @param {integer}	r3	Coordenada x da célula.
; @param {integer}	r4	Deslocamento y da célula + 1.
; @param {integer}	r5	Deslocamento x da célula + 1.
; @return Incrementa r7 caso a célula esteja viva.
;
cell_analysis:
	; ====/ FAZE INICIAL
	; SALVANDO REGISTRADORES
	push r2
	push r3
	push r5

	; ====/ FASE DE EXECUÇÃO
	call cell_fixCoords	; Concertando as coordenadas que levam para fora da matriz.
	loadn r5, #40 	; Salvando o valor 40 temporariamente.
	mul r2, r2, r5  ; Calculado o endereço da célula
	add r2, r2, r3 	; Calculado o endereço da célula
	call cell_isAlive	; Checando se a célula está viva.
	
	; ====/ FASE DE FINALIZAÇÃO 
	pop r5
	pop r3
	pop r2
	rts
	

; ========// CELL :: GET LIFE ENERGY
; Conta as células vivas ao redor 
;
; @param {address}	r1	MATRIX	Pointeiro para a matrix que será usada de
;	referência para realizar as modificações.
; @param {integer} r2 Coordenada y da célula a ser analizada.
; @param {integer} r3 Coordenada x da célula a ser analizada.
; @return r7 O número de céluas vivas ao redor da célula em questão. Varia de 0
;	a 9 e inclui a propria célula na contagem.
;
cell_getLifeEnergy:
	; ====/ FAZE INICIAL
	; SALVANDO REGISTRADORES
	push r4	; Salvando temporariamento o valor de r3
	push r5	; Salvando temporariamento o valor de r5
	push r6	; Salvando temporariamento o valor de r6

	; INICIALIZANDO CONSTANTES
	loadz r4 ; Contador ; r4 := i
	loadz r5 ; Contador ; r5 := j
	
	; INICIALIZANDO VARIÁVEIS
	loadz r7 ; Contador de vida nos vizinhos

	; ====/ FASE DE EXECUÇÃO
	;Soma o r7 se o vizinho for vivo
	;r4 e r5 vão de 0 até 2
	cell_getLifeEnergy_i:
		loadz r5
		cell_getLifeEnergy_j:
			
			; Se r6 e r5 for 1(se for a própria célula) não analiza
			loadn r6, #1 ; Carrega 1 no r6
			cmp r6, r5 	; Compara o r5 com 1 e se for diferente vai para análise
			jne cell_getLifeEnergy_execute
			cmp r6, r4 	; Compara o r4 com 1 e se for diferente vai para análise
			jne cell_getLifeEnergy_execute
			jmp cell_getLifeEnergy_plus
			
			; analiza a célula e incrementa r7 se for vivo	
			cell_getLifeEnergy_execute:
			call cell_analysis
			
			; soma 1 no r5 (r5 vai de 0 até 2)
			cell_getLifeEnergy_plus:
			loadn r6, #3 ; Carrega 3 no r6
			inc r5
			cmp r5, r6 ; Compara 3 com r5
			jne cell_getLifeEnergy_j
		
		; soma 1 no r4 (r4 vai de 0 até 2)
		inc r4
		cmp r4, r6 ; Compara 3 com r4
		jne cell_getLifeEnergy_i
	
	
	; ====/ FASE DE FINALIZAÇÃO 
	cell_getLifeEnergy_end:
		; DEVOLVENDO REGISTRADORES
		pop r6 ; devolvendo o valor antigo de r6
		pop r5 ; devolvendo o valor antigo de r5
		pop r4 ; devolvendo o valor antigo de r4
		
	rts ; retorno
	