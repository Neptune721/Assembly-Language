;2052844曹晓慈 将数据段的数据载入到对应的表格中
assume cs: codesg, ds: datasg, es: table

datasg segment
        db '1975','1976','1977','1978','1979','1980','1981','1982','1983'
        db '1984','1985','1986','1987','1988','1989','1990','1991','1992'
        db '1993','1994','1995';0-53h 21个年份
       
        dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514
        dd 345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000  ;54h-a7h21年的收入
       
        dw 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226
        dw 11542,14430,15257,17800;a8h-d1h  21年每年的员工人数
datasg ends

table segment
        db 21 dup ('year summ ne ?? ');0-3年份,4空格,5-8收入,9空格,10-11雇员,12空格,13-14人均收入,15空格
table ends

codesg segment
start:
        mov ax, datasg
        mov ds, ax
       
        mov ax, table
        mov es, ax
       
        mov di, 0;
        mov bx, 0;
        mov si, 0;
       
        mov cx, 21             ;最外层循环，21 年

   s:   
        push cx
        mov ax,ds:[bx]    ;年份是四个字符，这里借助16位的优势，一次读入两个字符从而减少代码量
		mov es:[di],ax
		mov ax,ds:[bx+2]
		mov es:[di+2],ax
		
		mov ax,54h[bx]
		mov dx,56h[bx]
		mov es:5[di],ax
		mov es:7[di],dx
		
		mov ax,0a8h[bx]
		mov es:0ah[di],ax
               
        div word ptr ds:0a8h[si]
        mov es:0dh[di],ax
        
		mov ax,0a8h[bx];将人数的载入放到人均收入的后面，这样被除数可以继续用ax和dx的值，避免对ax和dx的重复操作从而提高效率
		mov es:0ah[di],ax 
		
        add bx,4  ;确定年份和收入
        add si,2  ;确定人数
        add di,16	;换行	
		
		loop s
		
        mov ax, 4c00H
        int 21H
codesg ends
end start