ASSUME CS:CODE, DS:DATA
DATA SEGMENT
    MSG1 DB 0AH,0DH,"Enter a string:$"
    MSG2 DB 0AH,0DH,"Number of vowels: $"
    INPUT DB 50 DUP('$')       ; input string    
CODE SEGMENT
START:
    MOV AX,DATA
    MOV DS,AX

    ;string input
    LEA DX, MSG1
    MOV AH, 09H
    INT 21H

    ; Read string 
    LEA DX, INPUT
    MOV AH, 0AH           
    INT 21H

    MOV CL, [INPUT+1]          ; Length of the string 
    MOV SI, OFFSET INPUT + 2   ; first character 
    XOR BL, BL                  ; Vowel count

CHECK:MOV AL, [SI]
    AND AL, 5FH  ; 'a'=61h, 'A'=41h .the difference is 20h. so tp convert small letter to capital letter, binary of 20H is 00100000. so we use AND operation with 5FH(01011111)              
    CMP AL, 'A'                
    JE IS_VOWEL
    CMP AL, 'E'                
    JE IS_VOWEL
    CMP AL, 'I'               
    JE IS_VOWEL
    CMP AL, 'O'             
    JE IS_VOWEL
    CMP AL, 'U'              
    JE IS_VOWEL
    JMP NEXT      

IS_VOWEL:INC BL                     ; If it is a vowel, increment vowel count

NEXT:INC SI                     ; next character 
    LOOP CHECK           ; Repeat until all characters are checked

    ; Display result message
    LEA DX, MSG2
    MOV AH, 09H
    INT 21H
    cmp bl, 0AH
    JB DIGIT
    ADD bl,7H  ; Convert Letters to ASCII
DIGIT:ADD bl, '0'
    MOV DL, bl
    MOV AH, 02H
    INT 21H                  ; Display vowel count

    ; Exit program
    MOV AH, 4CH
    INT 21H
CODE ENDS
END START