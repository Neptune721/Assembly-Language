assume cs:code,ds:data,ss:stack

data segment
       db 'Tongji University!'
       db 02h,24h,71h
data ends

stack segment
  
       dw 8 dup(0)
	   
stack ends

code segment

start:
       mov ax,data
	   mov ds,ax
	   mov ax,stack
	   mov ss,ax
	   mov sp,10h
	   
	   xor bx,bx
	   jmp cls
next:  mov ax,0b872h
       mov cx,3
	   mov bx,18
s1:    push cx
       push ax
	   
       mov es,ax
	   
	   mov si,0
	   mov di,0
	   
	   mov cx,18
s2:	   mov al,ds:[si]
       mov dl,al
       mov al,ds:[bx]
	   mov dh,al
	   mov es:[di],dx
	   add di,2
	   add si,1
	   loop s2
	   
	   add bx,1
	   pop ax
	   add ax,0ah
	   pop cx
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