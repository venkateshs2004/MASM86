;input an array of elements. shift it n times to left

ASSUME CS:CODE,DS:DATA
DATA SEGMENT 
  MSG1 DB 0AH,0DH,"ENTER NUMBER OF ELEMENTS:$"
  MSG2 DB 0AH,0DH,"ENTER ELEMENTS:$"
  MSG3 DB 0AH,0DH,"ENTER NUMBER OF left shifts:$"
  MSG4 DB 0AH,0DH,"NEW ARRAY IS:$"
  ARR DB 09H DUP(?)
  N DB ?
  L DB ?
 
DATA ENDS
CODE SEGMENT
START:
          MOV AX,DATA
          MOV DS,AX
   	      LEA DX,MSG1
	      MOV AH,09H
	      INT 21H
	      MOV AH,01H
	      INT 21H
	      SUB AL,30H
          MOV L,AL
	      MOV CL,AL
	      LEA SI,ARR
	      LEA DX,MSG2
	      MOV AH,09H
	      INT 21H
READ:     MOV AH,01H
	      INT 21H
	      MOV [SI],AL
	      INC SI
          LOOP READ

          LEA DX,MSG3
	      MOV AH,09H
	      INT 21H
	      MOV AH,01H
	      INT 21H
	      SUB AL,30H
          MOV N,AL
	      MOV CH,N ; shift N times
 SHIFTOUTER:LEA SI,ARR
          LEA DI,ARR
          INC DI
          MOV BL,[SI]
          MOV CL,L
          DEC CL ; loop executed length-1 times
SHIFTINNER:MOV AL,[DI] ;all elements are moved left by 1 place in an shiftinner loop.
          MOV [SI],AL
          INC SI
          INC DI
          DEC CL
          JNZ SHIFTINNER

          MOV [SI],BL ; first element is moved to last place
          DEC CH
          JNZ SHIFTOUTER 

          LEA SI,ARR
          LEA DX,MSG4;display loop
          MOV AH,09H
          INT 21H
          MOV CL,L
  DISPLAY:MOV DL,[SI]
          MOV AH,02H
          INT 21H
          INC SI
          LOOP DISPLAY

          MOV AH,4CH
          INT 21H
CODE ENDS
END START