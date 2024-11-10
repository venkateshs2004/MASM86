ASSUME CS:CODE, DS:DATA

DATA SEGMENT
    MSG1 DB 0AH,0DH,"ENTER NUMBER OF Rows(1-9):$"
    MSG2 DB 0AH,0DH,"ENTER NUMBER OF Columns(1-9):$"
    MSG3 DB 0AH,0DH,"ENTER ELEMENTS:$"
    MSG4 DB 0AH,0DH,"Column sums are:$"
    ARR  DB 70H DUP(?)
    R    DB ?
    C    DB ?
DATA ENDS

CODE SEGMENT
START:
    MOV AX,DATA
    MOV DS,AX

    ; number of rows
    LEA DX,MSG1
    MOV AH,09H
    INT 21H
    MOV AH,01H
    INT 21H
    SUB AL,30H
    MOV R,AL

    ; number of columns
    LEA DX,MSG2
    MOV AH,09H
    INT 21H
    MOV AH,01H
    INT 21H
    SUB AL,30H
    MOV C,AL

    ; matrix elements
    LEA SI,ARR
    LEA DX,MSG3
    MOV AH,09H
    INT 21H

    MOV BL, R     ; Number of rows
    MOV BH, C     ; Number of columns
READ:
    MOV AH,01H
    INT 21H
    SUB AL,30H
    MOV [SI],AL
    INC SI
    DEC BH
    JNZ READ

    MOV BH, C     ; Reset BH to column count for next row
    DEC BL
    JNZ READ

    ; Display column sums
    LEA DX,MSG4
    MOV AH,09H
    INT 21H

    LEA SI,ARR
    XOR CX, CX    ; Column counter
LOOP1:
    MOV AL, 0     ;col sum
    MOV BL, R     ; Row count 

LOOP2:
    ADD AL, [SI]  ; Add element in column
    ADD SI, C     ; Move to next row in same column
    DEC BL
    JNZ LOOP2

    ; Convert sum to ASCII
    cmp AL, 0AH
    JB DIGIT
    ADD AL, 7H  ; Convert Letters to ASCII
DIGIT:ADD AL, '0'
    MOV DL, AL
    MOV AH, 02H
    INT 21H       ; Display sum

    ; Move to next column
    INC CX
    LEA SI, ARR
    ADD SI, CX
    CMP CX, C     ; Loop for all columns
    JB LOOP1

    MOV AH, 4CH
    INT 21H
CODE ENDS
END START
