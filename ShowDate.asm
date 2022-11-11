;2022-11-11  在实现过程调用练习，接收年月日的信息并按要求进行显示的基础上对代码进行拆分和宏调用

PUBLIC IPP,BUF0,YEAR,MONTH,DAY  ;声明要被其他模块进行调用
EXTRN DISP:FAR     ;说明程序模块需要调用其他程序模块
EXTRN GETDATE:FAR

STKSEG SEGMENT STACK
DW 32 DUP(0)   ;栈空间
STKSEG ENDS

DATASEG SEGMENT para 'mytitle'
	EG DB "WHAT IS THE DATE(MM/DD/YY)?,LIKE: 11112022",'$'
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
	
OUTPUT MACRO REG   ;定义一个OUTPUT的宏，将REG进行输出
	   LEA DX,REG
	   MOV AH,09H
	   INT 21H
ENDM

MAIN PROC FAR
START:
	MOV AX,DATASEG
	MOV DS,AX	;段寄存器和堆栈初始化
	
	OUTPUT EG   ;显示第一条提示信息
	OUTPUT LINE
    OUTPUT EG1  ;显示第二条提示信息
	MOV DL,07H	;响铃
	MOV AH,2
	INT 21H		
	CALL GETNUM	;过程调用GetNum，并依次接受键入的月、日、年值
	OUTPUT LINE
	OUTPUT EG2  ;显示第三条提示信息
	
	CALL GETDATE
	
	MOV DX,YEAR
	CALL DISP		;调用Disp显示年值
	OUTPUT PR
	MOV DX,MONTH	
	CALL DISP		;调用Disp显示月值
	OUTPUT PR
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

CODESEG ENDS
END START