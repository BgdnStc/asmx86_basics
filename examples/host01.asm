.model tiny
.code

org 100h
HOST:
	mov AH, 9
	mov DX, offset hi
	int 21h

	mov AX, 4C00h
	int 21h
	
	hi DB 'Program COM 01!$'
	end HOST