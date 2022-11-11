PUBLIC DISP

CODE SEGMENT para 'code'
	ASSUME CS:CODE
DISP PROC FAR
	PUSH DX
	PUSH AX
	PUSH BP
	MOV BP,SP

	
	MOV AX,DX
    XOR DX,DX
    MOV BX,10
    MOV CX,0
A:
    CMP AX,10
    JB OK
    DIV BX
    ADD DL,30H
    PUSH DX
    XOR DX,DX
    INC CX
    JMP A
OK:
    ADD AL,30H
    PUSH AX
    INC CX
B:
    POP DX
    MOV AH,2
    INT 21H
    LOOP b
	
	POP DX
	POP AX
	POP BP
	RETF
DISP ENDP

CODE ENDS
END