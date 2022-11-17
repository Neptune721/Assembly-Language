assume cs:code,ds:data,ss:stack

data segment
       db 'Tongji University!'
	   REG db 02h
	   
data ends

stack segment
  
       dw 8 dup(0)
	   
stack ends

code segment

start:
       mov ax,data
	   mov ds,ax
	   
	   jmp cls
next:  mov ax,0b872h
       mov es,ax
	   
	   mov cx,18
	   mov di,0
	   mov bx,0
s1:	   mov al,ds:[bx]
       mov dl,al
       mov dh,REG
	   mov es:[di],dx
	   add bx,1
	   add di,2
	   loop s1
	   
	   mov ax,4c00H
	   int 21H
	   
	   
cls:   mov bx,0b800h
       mov es,bx
	   
	   mov bx,0
	   
	   mov cx,4000
s:     mov dl,0
       mov dh,0
	   mov es:[bx],dx
	   add bx,2
	   loop s
	   
	   jmp next
	   
code ends
end start