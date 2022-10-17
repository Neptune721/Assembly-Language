;2022/10/17 实现1+2+3...+100的累加，将最后结果输出到屏幕上
STKSEG SEGMENT STACK
	DW 32 DUP(0)
STKSEG ENDS

DATASEG SEGMENT
	MYDATA DD 0
DATASEG ENDS

CODESEG SEGMENT
	ASSUME CS:CODESEG, DS:DATASEG, SS:STKSEG
MAIN PROC FAR
	MOV AX,0
	MOV DX,1
	MOV CX,100
L:
	ADD AX,CX
	LOOP L
	MOV DX,AX
;以下部分为把DX中的16进制数值转10进制输出
	MOV AX,DX
        XOR DX,DX
        MOV BX,10
        MOV CX,0
A:
        CMP AX,10
        JB B
        DIV BX
        ADD DL,30H ;将16进制数字转化为10进制数字的ascii码--0 48 30h
        PUSH DX		;将修改好的数字放到栈中
        XOR DX,DX
        INC CX
        JMP A
B:
        ADD AL,30H
        PUSH AX
        INC CX		;cx=4 输出循环四次，输出四个数字 
C:
        POP DX
        MOV AH,2	;ah=02，输出dl
        INT 21H
        LOOP C
	MOV AX,4C00H
	INT 21H
MAIN ENDP
CODESEG ENDS
	END MAIN
	