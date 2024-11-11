.model small
.stack 32
.data
	sum 			DW ?
	filter 			DW 10
	filteredSum 	DW ?
	array 			DW 13,7,6,24
	anotherArray	DW 100 DUP (1)  ;duplicate 1 for 100 time
	message			DB 'Hello$'
	vb			 	DB 'How are you@'
.code
	mov ax,@data
	mov ds,ax
	mov al,message
	mov ax,word ptr vb
	mov ah,09h
	mov dx,offset message
	int 21h
	
	XOR AX,AX
	XOR bX, bX
	mov si,offset array
	mov cx,4
do_iteration:
	add ax,[si]
	mov dx,[si]
	cmp dx,filter
	jl ignore
	add bx, [si]
ignore:
	inc si
	inc si
	loop do_iteration
	
	mov sum,ax
	mov filteredSum, bX
	
	mov ax,4c00h
	int 21h
end