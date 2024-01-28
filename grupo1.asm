;**************************************
;******Membros do grupo 1 ***********
;1 - Constantino Manuel D. Gola
;2 - Honorato Lourenço
;3 - João Miguel Francisco
;4 - Manuel Samuel Fuxi
;**************************************

; *********************Teclado*******************************************
BUFFER	EQU	200H	
LINHA	EQU	8		
PIN     EQU 0E000H 
POUT    EQU 0C000H
; **********************************************************************

;-------------------------------------------------------
stackSize EQU 100H
pixelsMatriz  EQU 8000H
PLACE 2000H
pilha: TABLE stackSize
stackBase:
PLACE 2200H
ptable:STRING 01H,02H,04H,08H,10H,20H,40H,80H
;-------------------------------------------------------
PLACE 3200H
linhaBoneco equ 3200H
colunaBoneco equ 3202H

PLACE 3204H
linhaFimJogo equ 3204H
colunaFimJogo equ 3206H
linhaLetraO1 equ 3208H
colunaLetraO1 equ 3210H
linhaLetraO2 equ 3212H
colunaLetraO2 equ 3214H

;-------------------------------------------------------


PLACE 0
main: MOV SP,stackBase


CALL inicializacaoP



inicicioPrincipal:
    CALL inicioCbJg
    CALL teclado
    MOV R5,BUFFER
    MOVB R4,[R5]
    MOV R5,4H
    CMP R4,R5
    JZ andaEsquerda
	
	;Mover para Cima o Boneco
	MOV R5,BUFFER
    MOVB R4,[R5]
    MOV R5,1H
    CMP R4,R5
    JZ andaCima
	
	;Mover para Baixo o Boneco
	MOV R5,BUFFER
    MOVB R4,[R5]
    MOV R5,9H
    CMP R4,R5
    JZ andaBaixo
	
	;Mover para direita se Apertar no Botão 6H
    MOV R5,BUFFER
    MOVB R4,[R5]
    MOV R5,6H
    CMP R4,R5
    JZ andaDireita
	
	;Mover para Diagonal o Boneco
    MOV R5,BUFFER
    MOVB R4,[R5]
    MOV R5,0H
    CMP R4,R5
    JZ andaDiagonal1
	
	
	;Mover para Diagona4 o Boneco
    MOV R5,BUFFER
    MOVB R4,[R5]
    MOV R5,0AH
    CMP R4,R5
    JZ andaDiagonal4
	
	;Mover para Diagona2 o Boneco
    MOV R5,BUFFER
    MOVB R4,[R5]
    MOV R5,8H
    CMP R4,R5
    JZ andaDiagonal3
	
	
	;Terminar o jogo
	MOV R5,BUFFER
    MOVB R4,[R5]
    MOV R5,3H
    CMP R4,R5
    JZ terminar
	
	JMP inicicioPrincipal




andaEsquerda:
    call limpatela
    MOV R3,linhaBoneco
    MOV R4,colunaBoneco
    MOV R1,[R3]
    MOV R2,[R4]
    SUB R2,1H
    MOV [R4],R2
    JMP inicicioPrincipal

andaCima:
	call limpatela
    MOV R3,linhaBoneco
    MOV R4,colunaBoneco
    MOV R1,[R3]
    MOV R2,[R4]
    SUB R1,1H
    MOV [R3],R1
    JMP inicicioPrincipal
    
andaBaixo:
	call limpatela
    MOV R3,linhaBoneco
    MOV R4,colunaBoneco
    MOV R1,[R3]
    MOV R2,[R4]
    ADD R1,1H
    MOV [R3],R1
    JMP inicicioPrincipal
	
	

andaDireita:
    call limpatela
    MOV R3,linhaBoneco
    MOV R4,colunaBoneco
    MOV R1,[R3]
    MOV R2,[R4]
    ADD R2,1H
    MOV [R4],R2
    JMP inicicioPrincipal
	
andaDiagonal1:
	call limpatela
    MOV R3,linhaBoneco
    MOV R4,colunaBoneco
    MOV R1,[R3]
    MOV R2,[R4]
    SUB R2,1H
	SUB R1,1H
    MOV [R4],R2
	MOV [R3],R1
    JMP inicicioPrincipal

andaDiagonal2:
	call limpatela
    MOV R3,linhaBoneco
    MOV R4,colunaBoneco
    MOV R1,[R3]
    MOV R2,[R4]
    ADD R2,1H
	SUB R1,1H
    MOV [R4],R2
	MOV [R3],R1
    JMP inicicioPrincipal
	
andaDiagonal3:
	call limpatela
    MOV R3,linhaBoneco
    MOV R4,colunaBoneco
    MOV R1,[R3]
    MOV R2,[R4]
    SUB R2,1H
	ADD R1,1H
    MOV [R4],R2
	MOV [R3],R1
    JMP inicicioPrincipal

andaDiagonal4:
	call limpatela
    MOV R3,linhaBoneco
    MOV R4,colunaBoneco
    MOV R1,[R3]
    MOV R2,[R4]
	ADD R1,1H
    ADD R2,1H
    MOV [R4],R2
	MOV [R3],R1
    JMP inicicioPrincipal
	

terminar:
	call limpatela
	call desenhaFimJogo
    JMP acabou




limpatela:
        MOV R1, 8000H
        MOV R2, 807FH
        MOV R0,0H
    limpatudo:
        MOVB [R1],R0
        ADD R1,1H
        CMP R2,R1
        JN RETOR1
        JMP limpatudo



RETOR1:
    RET








pixel_xy: 
          PUSH R4
          PUSH R6
          PUSH R7
          PUSH R2
          PUSH R5
          PUSH R3

          MOV R4,4
		  MOV R6,8
		  MOV R7,R2
          MUL R4,R1
          DIV R7,R6
          ADD R4,R7
	      MOV R7, pixelsMatriz
		  ADD R4,R7
		  MOV R6,7H
		  CMP R2,R6
		  JLE bitpixel
		  MOV R6,0FH
		  CMP R2,R6
		  JLE bitpixel
		  MOV R6,17H
		  CMP R2,R6
		  JLE bitpixel
		  MOV R6 , 1FH
bitpixel:
		SUB R6,R2
		MOV R5,ptable
		ADD R5,R6
		MOVB R3,[R5]
		MOVB R6,[R4]
		OR R6,R3
		MOVB [R4],R6

         POP R3
          POP R5
          POP R2
          POP R7
          POP R6
          POP R4
		RET



inicioCbJg:
    PUSH R3
    PUSH R4
    PUSH R1
    PUSH R2
    PUSH R10
    PUSH R9
    MOV R3,linhaBoneco
    MOV R4,colunaBoneco
    MOV R1,[R3]
    MOV R2,[R4]
    MOV R10,3H
    MOV R9,1H 
    desenhaCabeJg:
        call pixel_xy
        CMP R10,R9
        JZ inicioPesq
        ADD R1,1H
        ADD R9,1H
        JMP desenhaCabeJg

inicioPesq:
    MOV R10,2H
    MOV R9,1H 
    ADD R1,1H
    SUB R2,1H
    desenhaPesq:
        call pixel_xy
        CMP R10,R9
        JZ inicioMao
        ADD R1,1H
        SUB R2,1H
        ADD R9,1H
        JMP desenhaPesq


inicioMao:
    MOV R10,5H
    MOV R9,1H
    SUB R1,3H
    desenhoMao:
        call pixel_xy
        CMP R10,R9
        JZ inicioPeD
        ADD R2,1H
        ADD R9,1H
        JMP desenhoMao

inicioPeD:
    MOV R10,2H ;
    MOV R9,1H
    SUB R2,1H
    ADD R1,2H
    desenhaPeD:
        call pixel_xy
        CMP R10,R9
        JZ RETORNO
        ADD R1,1H ;Adiciona na linha
		ADD R2,1H ; Adiciona
        ADD R9,1H
        JMP desenhaPeD

RETORNO:
    POP R9
    POP R10
    POP R2
    POP R1
    POP R4
    POP R3
    RET

inicializacaoP:
    PUSH R1
    PUSH R2
    PUSH R3
    PUSH R4



    MOV R1,linhaBoneco
    MOV R2,colunaBoneco
    MOV R3,0EH
    MOV R4,0FH
    MOV [R1],R3
    MOV [R2],R4
	
	MOV R1, linhaFimJogo
    MOV R2, colunaFimJogo
    MOV R3,5H
    MOV R4,5H
    MOV [R1],R3
    MOV [R2],R4
	
	MOV R1, linhaLetraO1
    MOV R2, colunaLetraO1
    MOV R3,14H
    MOV R4,6H
    MOV [R1],R3
    MOV [R2],R4
	
	MOV R1, linhaLetraO2
    MOV R2, colunaLetraO2
    MOV R3,14H
    MOV R4,10H
    MOV [R1],R3
    MOV [R2],R4


    POP R4
    POP R3
    POP R2
    POP R1
    RET




desenhaFimJogo:
	PUSH R3
    PUSH R4
    PUSH R1
    PUSH R2
	
	MOV R3,linhaFimJogo
    MOV R4,colunaFimJogo
    MOV R1,[R3]
    MOV R2,[R4]
	call inicioFimJogo
	
	MOV R3,linhaLetraO1
    MOV R4,colunaLetraO1
    MOV R1,[R3]
    MOV R2,[R4]
	call inicioObjO
	
	MOV R3,linhaLetraO2
    MOV R4,colunaLetraO2
    MOV R1,[R3]
    MOV R2,[R4]
	call inicioObjO
	
	POP R2
    POP R1
    POP R4
    POP R3




;******************Teclado******************
teclado:
    PUSH R1
    PUSH R6
    PUSH R2
    PUSH R3
    PUSH R8
    PUSH R10
    PUSH R4

    inicio:
    MOV R5, BUFFER	; R5 com endere�o de mem�ria BUFFER
        MOV	R1, 1	; testar a linha 1
        MOV R6,PIN
        MOV	R2, POUT	; R2 com o endere�o do perif�rico
    ; corpo principal do programa
    ciclo:MOVB 	[R2], R1	; escrever no porto de sa�da
        MOVB 	R3, [R6]	; ler do porto de entrada
        AND 	R3, R3		; afectar as flags (MOVs n�o afectam as flags)
        JZ 	inicializarLinha		; nenhuma tecla premida
        MOV R8,1
        CMP R8,R1
        JZ linha1
        MOV R8,2
        CMP R8,R1
        JZ linha2
        MOV R8,4
        CMP R8,R1
        JZ linha3
        MOV R8,8
        CMP R8,R1
        JZ linha4

    linha4:
        linha4C1:MOV R8,1
        CMP R8,R3
        JZ EC
        JNZ linha4C2
        linha4C2:MOV R8,2
        CMP R8,R3
        JZ ED
        JNZ linha4C3
        linha4C3:MOV R8,4
        CMP R8,R3
        JZ EE
        JNZ linha4C4
        linha4C4:MOV R8,8
        CMP R8,R3
        JZ EF

    linha3:
        linha3C1:MOV R8,1
        CMP R8,R3
        JZ Eoito
        JNZ linha3C2
        linha3C2:MOV R8,2
        CMP R8,R3
        JZ Enove
        JNZ linha3C3
        linha3C3:MOV R8,4
        CMP R8,R3
        JZ EA
        JNZ linha3C4
        linha3C4:MOV R8,8
        CMP R8,R3
        JZ EB

    linha2:
        linha2C1:MOV R8,1
        CMP R8,R3
        JZ Equatro
        JNZ linha2C2
        linha2C2:MOV R8,2
        CMP R8,R3
        JZ Ecinco
        JNZ linha2C3
        linha2C3:MOV R8,4
        CMP R8,R3
        JZ Eseis
        JNZ linha2C4
        linha2C4:MOV R8,8
        CMP R8,R3
        JZ Esete


    linha1:
        linha1C1:MOV R8,1
        CMP R8,R3
        JZ Ezero
        JNZ linha1C2
        linha1C2:MOV R8,2
        CMP R8,R3
        JZ Eum
        JNZ linha1C3
        linha1C3:MOV R8,4
        CMP R8,R3
        JZ Edois
        JNZ linha1C4
        linha1C4:MOV R8,8
        CMP R8,R3
        JZ Etres

        Ezero:MOV R10,0H
        JMP armazena
        Eum:MOV R10,1H
        JMP armazena
        Edois:MOV R10,2H
        JMP armazena
        Etres:MOV R10,3H
        JMP armazena
        Equatro:MOV R10,4H
        JMP armazena
        Ecinco:MOV R10,5H
        JMP armazena
        Eseis:MOV R10,6H
        JMP armazena
        Esete:MOV R10,7H
        JMP armazena
        Eoito:MOV R10,8H
        JMP armazena
        Enove:MOV R10,9H
        JMP armazena
        EA:MOV R10,9H
        ADD R10,1H
        JMP armazena
        EB:MOV R10,9H
        ADD R10,2H
        JMP armazena
        EC:MOV R10,9H
        ADD R10,3H
        JMP armazena
        ED:MOV R10,9H
        ADD R10,4H
        JMP armazena
        EE:MOV R10,9H
        ADD R10,5H
        JMP armazena
        EF:MOV R10,9H
        ADD R10,6H
    armazena:
        MOV	R4, R10		; guardar tecla premida em registo
        MOVB 	[R5], R4	; guarda tecla premida em mem�ria
        JMP RETOR



    inicializarLinha:
        MOV R8,2
        MUL R1,R8
        MOV R8,8
        CMP R8,R1
        JN inicio
        JNN ciclo




RETOR:
    POP R4
    POP R10
    POP R8
    POP R3
    POP R2
    POP R6
    POP R1
    RET

;*****************Fim do Jogo************************************

inicioFimJogo:
    PUSH R3
    PUSH R4
    PUSH R1
    PUSH R2
    PUSH R10
    PUSH R9
    MOV R10, 4H
    MOV R9,1H 
    desenhaLetraF1: ;traço de cima da letra F
        call pixel_xy
        CMP R10,R9
        JZ inicioLetraF2
        SUB R2,1H
        ADD R9,1H
        JMP desenhaLetraF1

inicioLetraF2: ;Barra Esquerda da Letra F
    MOV R10,3H
    MOV R9,1H 
    ADD R1,1H
    desenhaLetraF2:
        call pixel_xy
        CMP R10,R9
        JZ inicioLetraF3
        ADD R1,1H
        ADD R9,1H
        JMP desenhaLetraF2


inicioLetraF3:
    MOV R10,3H
    MOV R9,1H
    ADD R2,1H
    desenhaLetraF3:
        call pixel_xy
        CMP R10,R9
        JZ inicioLetraF4
        ADD R2,1H
        ADD R9,1H
        JMP desenhaLetraF3

inicioLetraF4:
    MOV R10,3H
    MOV R9,1H
    ADD R1,1H
	SUB R2,3H
    desenhaLetraF4:
        call pixel_xy
        CMP R10,R9
        JZ inicioLetraI
        ADD R1,1H
        ADD R9,1H
        JMP desenhaLetraF4
		
inicioLetraI:
	MOV R10,7H
    MOV R9,1H
	ADD R2,5H
    desenhaLetraI:
        call pixel_xy
        CMP R10,R9
        JZ inicioLetraM
        SUB R1,1H
        ADD R9,1H
        JMP desenhaLetraI
		
inicioLetraM:
	MOV R10,7H
    MOV R9,1H
	ADD R2,2H
	ADD R1,6H
    desenhaLetraM1:
        call pixel_xy
        CMP R10,R9
        JZ inicioLetraM2
        SUB R1,1H
        ADD R9,1H
        JMP desenhaLetraM1
		
inicioLetraM2:
	MOV R10,2H
    MOV R9,1H
	ADD R2,1H
    desenhaLetraM2:
        call pixel_xy
        CMP R10,R9
        JZ inicioLetraM3
        ADD R1,1H
		ADD R2,1H
        ADD R9,1H
        JMP desenhaLetraM2

inicioLetraM3:
	MOV R10,2H
    MOV R9,1H
    desenhaLetraM3:
        call pixel_xy
        CMP R10,R9
        JZ inicioLetraM4
        SUB R1,1H
		ADD R2,1H
        ADD R9,1H
        JMP desenhaLetraM3
		
inicioLetraM4:
	MOV R10,7H
    MOV R9,1H
	ADD R2,1H
    desenhaLetraM4:
        call pixel_xy
        CMP R10,R9
        JZ inicioLetraJ
        ADD R1,1H
        ADD R9,1H
        JMP desenhaLetraM4
		
inicioLetraJ:
	MOV R10,3H
    MOV R9,1H
	ADD R1,3H
	SUB R2,7H
	SUB R2,4H
    desenhaLetraJ1:
        call pixel_xy
        CMP R10,R9
        JZ inicioLetraJ2
        ADD R2,1H
        ADD R9,1H
        JMP desenhaLetraJ1
		
inicioLetraJ2:
	MOV R10,6H
    MOV R9,1H
	ADD R1,1H
    desenhaLetraJ2:
        call pixel_xy
        CMP R10,R9
        JZ inicioLetraJ3
        ADD R1,1H
        ADD R9,1H
        JMP desenhaLetraJ2
		
inicioLetraJ3:
	MOV R10,2H
    MOV R9,1H
    desenhaLetraJ3:
        call pixel_xy
        CMP R10,R9
        JZ inicioLetraJ4
        SUB R2,1H
        ADD R9,1H
        JMP desenhaLetraJ3
		
inicioLetraJ4:
	MOV R10,2H
    MOV R9,1H
	SUB R2,1H
    desenhaLetraJ4:
        call pixel_xy
        CMP R10,R9
        JZ inicioLetraG
        SUB R1,1H
        ADD R9,1H
        JMP desenhaLetraJ4

inicioLetraG:
	MOV R10,7H
    MOV R9,1H
	ADD R1,1H
	ADD R2,7H
	ADD R2,2H
    desenhaLetraG1:
        call pixel_xy
        CMP R10,R9
        JZ inicioLetraG2
        SUB R1,1H
        ADD R9,1H
        JMP desenhaLetraG1
		
inicioLetraG2:
	MOV R10,4H
    MOV R9,1H
    desenhaLetraG2:
        call pixel_xy
        CMP R10,R9
        JZ inicioLetraG3
        ADD R2,1H
        ADD R9,1H
        JMP desenhaLetraG2
		
inicioLetraG3:
	MOV R10,2H
    MOV R9,1H
	SUB R2,1H
	ADD R1,4H
    desenhaLetraG3:
        call pixel_xy
        CMP R10,R9
        JZ inicioLetraG4
        ADD R2,1H
        ADD R9,1H
        JMP desenhaLetraG3
		
inicioLetraG4:
	MOV R10,2H
    MOV R9,1H
	ADD R1,1H
    desenhaLetraG4:
        call pixel_xy
        CMP R10,R9
        JZ inicioLetraG5
        ADD R1,1H
        ADD R9,1H
        JMP desenhaLetraG4
		
inicioLetraG5:
	MOV R10,2H
    MOV R9,1H
	SUB R2,1H
    desenhaLetraG5:
        call pixel_xy
        CMP R10,R9
        JZ RETORNO1
        SUB R2,1H
        ADD R9,1H
        JMP desenhaLetraG5

RETORNO1:
    POP R9
    POP R10
    POP R2
    POP R1
    POP R4
    POP R3
    RET

inicioObjO:
	PUSH R3
    PUSH R4
    PUSH R1
    PUSH R2
    PUSH R10
    PUSH R9
	MOV R10,7H
    MOV R9,1H
	desenhaLetraO1:
		call pixel_xy
		CMP R10,R9
		JZ inicioLetraO2
		SUB R1,1H
		ADD R9,1H
		JMP desenhaLetraO1
	
inicioLetraO2:
	MOV R10,4H
	MOV R9,1H
desenhaLetraO2:
	call pixel_xy
	CMP R10,R9
	JZ inicioLetraO3
	ADD R2,1H
	ADD R9,1H
	JMP desenhaLetraO2

inicioLetraO3:
	MOV R10,6H
	MOV R9,1H
	ADD R1,1H
desenhaLetraO3:
	call pixel_xy
	CMP R10,R9
	JZ inicioLetraO4
	ADD R1,1H
	ADD R9,1H
	JMP desenhaLetraO3
		
inicioLetraO4:
	MOV R10,3H
	MOV R9,1H
desenhaLetraO4:
	call pixel_xy
	CMP R10,R9
	JZ RETORNO2
	SUB R2,1H
	ADD R9,1H
	JMP desenhaLetraO4

RETORNO2:
    POP R9
    POP R10
    POP R2
    POP R1
    POP R4
    POP R3
    RET


acabou:
JMP acabou


