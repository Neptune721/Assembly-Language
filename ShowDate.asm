;2022-10-30  实现过程调用练习，接收年月日的信息并按要求进行显示
STKSEG SEGMENT STACK
DW 32 DUP(0)   ;栈空间
STKSEG ENDS

DATASEG SEGMENT
	EG DB "WHAT IS THE DATE(MM/DD/YY)?,LIKE: 01222022",'$'
	EG1 DB "PLEASE INPUT THE DATE : ",'$'
	EG2 DB "THE DATE(YY-MM-DD) IS:",'$'
	PR DB "-$" ;结果
	LINE DB 0DH,0AH,'$'   ;换行
	IPP DW 0000H   ;IP
	BUF0 DB 9
	DB ?
	DB 9 DUP (?)
	P DW ?  
	YEAR DW ?
	MONTH DW ?
	DAY DW ?
DATASEG ENDS

CODESEG SEGMENT
	ASSUME CS:CODESEG,DS:DATASEG,SS:STKSEG
START:
	MOV AX,DATASEG
	MOV DS,AX	;段寄存器和堆栈初始化
	
	MOV AH,9	
	MOV DX,OFFSET EG	;显示第一条提示信息
	INT 21H		
	LEA DX,LINE
	MOV AH,09H
	INT 21H
	LEA DX,EG1	;显示第二条提示信息
	MOV AH,09H
	INT 21H		
	MOV DL,07H	;响铃
	MOV AH,2
	INT 21H		
	CALL GETNUM	;过程调用GetNum，并依次接受键入的月、日、年值
	LEA DX,LINE	;换行
	MOV AH,09H
	INT 21H
	LEA DX,EG2 ;显示第三条提示信息
	MOV AH,09H
	INT 21H
	
	
	LEA DI,BUF0+2   ;定位到月份所在位置
	MOV CX,2
	MOV AX,0
L1:	MOV BL,[DI]
	SUB BL,30H
	MOV BH,0
	MOV P,10
	MUL P
	ADD AX,BX
	INC DI
	LOOP L1
	MOV MONTH,AX	;获得月份信息
	
	LEA DI,BUF0+4  ;定位到日期所在位置
	MOV CX,2
	MOV AX,0
L2:	MOV BL,[DI]
	SUB BL,30H
	MOV BH,0
	MOV P,10
	MUL P
	ADD AX,BX
	INC DI
	LOOP L2
	MOV DAY,AX		;获得日期信息
	
	LEA DI,BUF0+6  ;定位到年份所在位置
	MOV CX,4       
	MOV AX,0
L3:	MOV BL,[DI]
	SUB BL,30H
	MOV BH,0
	MOV P,10
	MUL P
	ADD AX,BX
	INC DI
	LOOP L3
	MOV YEAR,AX		;获得年份信息
	

	MOV DX,YEAR
	CALL DISP		;过程调用Disp显示年值
	LEA DX,PR		;输出字符‘-’
	MOV AH,09H
	INT 21H
	MOV DX,MONTH	
	CALL DISP		;调用Disp显示月值
	LEA DX,PR		;输出字符‘-’
	MOV AH,09H
	INT 21H
	MOV DX,DAY		
	CALL DISP		;调用Disp显示日值
	
	
	MOV AX,4C00H	;返回DOS
	INT 21H
	
GETNUM PROC 
	POP IPP
	PUSH AX
	LEA DX,BUF0
	MOV AH,10
	INT 21H		;把输入的日期数据保存到缓存区BUF0中
	POP AX
	PUSH IPP
	RET
GETNUM ENDP

DISP PROC		;将存入dx中的数据以十进制的形式输出
	POP IPP
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
	PUSH IPP
	RET
DISP ENDP


CODESEG ENDS
END START