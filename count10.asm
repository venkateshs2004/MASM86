;TO COUNT THE NUMBER OF 1'S AND 0'S IN THE GIVEN 16BIT NUMBER
;INORDER TO KEEP THE PROGRAM SIMPLE, WE ARE CONSIDERING NUMBER OF 1'S AND 0'S LESS THAN 16
ASSUME CS:CODE, DS:DATA

DATA SEGMENT
    MSG1 DB 0AH,0DH,"ENTER DIGIT :$"
    MSG2 DB 0AH,0DH,"NUMBER OF 1'S :$"
    MSG3 DB 0AH,0DH,"NUMBER OF 0'S :$"
DATA ENDS

CODE SEGMENT
START:
    MOV AX,DATA
    MOV DS,AX
    MOV CX,0004H
    MOV BX,1010H
    CLC
INPUT:    LEA DX,MSG1 ;1ST DIGIT
    MOV AH,09H
    INT 21H
    MOV AH,01H
    INT 21H
    CMP AL,'A'
    JB DIGIT
    SUB AL,07H
DIGIT:SUB AL,30H
    MOV DL,04H
 ROT:RCR AL,1 ; ROTATE RIGHT4 TIMES TO GET THE BITS
    JNC COUNT
    DEC BX
COUNT:DEC DL
    JNZ ROT
    LOOP INPUT

    LEA DX, MSG2
    MOV AH, 09H
    INT 21H  
    SUB BH,BL
    MOV CX, 3030H
    cmp BH, 0AH
    JB DIGIT1
    ADD BH, 7H  ; Convert Letters to ASCII
DIGIT1:ADD BH, '0'
    CMP BH, 47H
    JNE CONT1  ;Incase of 10H
    INC CH
    MOV BH,'0'
CONT1:MOV DL, CH
    MOV AH, 02H
    INT 21H   ; Convert digit to ASCII
    MOV DL, BH
    MOV AH, 02H
    INT 21H       ; Display 1'S

    LEA DX, MSG3
    MOV AH, 09H
    INT 21H  
    cmp BL, 0AH
    JB DIGIT0
    ADD BL, 7H  ; Convert Letters to ASCII
DIGIT0:ADD BL, '0' ; convert digit to ASCII
    CMP BL, 47H
    JNE CONT0 ; Incase of 10H
    INC CL
    MOV BL,'0'
CONT0:MOV DL, CL
    MOV AH, 02H
    INT 21H 
    MOV DL, BL
    MOV AH, 02H
    INT 21H      ; Display 0'S


    MOV AH, 4CH
    INT 21H
CODE ENDS
END START

