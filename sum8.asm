ASSUME CS:CODE, DS:DATA

DATA SEGMENT
    n1 DB 0AH,0DH,"ENTER NUMBER 1:$"
    n2 DB 0AH,0DH,"ENTER NUMBER 2:$"
    MSG2 DB 10, 13, "OUTPUT:$"
DATA ENDS

CODE SEGMENT
START:
    MOV AX, DATA
    MOV DS, AX
    LEA DX, n1
    MOV AH, 09H
    INT 21H
    MOV AH,01H
    INT 21H
    mov bl,al
    LEA DX, n2
    MOV AH, 09H
    INT 21H
    MOV AH,01H
	INT 21H
    ADD al,bl
    ADC BH, 30H
    ADD al,30H
    LEA DX, MSG2
    MOV AH, 09H
    INT 21H   
    MOV DL, BH
    MOV AH, 02H
    INT 21H
    MOV DL, AL
    MOV AH, 02H
    INT 21H         
    MOV AH, 4CH
    INT 21H
CODE ENDS

END START
