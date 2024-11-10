ASSUME CS:CODE, DS:DATA

DATA SEGMENT
    MSG1 DB 0AH,0DH,"ENTER NUMBER OF Rows(1-9):$"
    MSG2 DB 0AH,0DH,"ENTER NUMBER OF Columns(1-9):$"
    MSG3 DB 0AH,0DH,"ENTER ELEMENTS:$"
    MSG4 DB 0AH,0DH,"Row sums are:$"
    ARR  DB 70H DUP(?)
    R    DB ?
    C    DB ?
DATA ENDS

CODE SEGMENT
START:
    MOV AX,DATA
    MOV DS,AX

    ;number of rows
    LEA DX,MSG1
    MOV AH,09H
    INT 21H
    MOV AH,01H
    INT 21H
    SUB AL,30H
    MOV R,AL

    ;number of columns
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

    ; Read matrix elements
    MOV CL, R    
    MOV CH, C     
READ:
    MOV AH,01H
    INT 21H
    SUB AL,30H
    MOV [SI],AL
    INC SI
    DEC CH
    JNZ READ
    MOV CH, C     ; Reset column count for next row
    DEC CL
    JNZ READ

    ; Display row sums
    LEA DX,MSG4
    MOV AH,09H
    INT 21H

    LEA SI,ARR
    MOV CL, R     ; Row counter
LOOP1:
    XOR AL, AL   
    MOV BL, C     ; Column count in BL

LOOP2:
    ADD AL, [SI]  
    INC SI        
    DEC BL
    JNZ LOOP2
    
    ; Display sum
    cmp AL, 0AH
    JB DIGIT
    ADD AL, 7H  ; Convert Letters to ASCII
DIGIT:ADD AL, '0'   
    MOV DL, AL    ; Store sum in DL
    MOV AH, 02H
    INT 21H       ; Display sum
    DEC CL      ; lo0p all rows
    JNZ LOOP1

    ; Exit program
    MOV AH,4CH
    INT 21H
CODE ENDS
END START
