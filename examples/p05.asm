.model small

add2 MACRO op1, op2, sum
	mov AX, op1
	add AX, op2
	mov sum, AX
ENDM

exit_dos MACRO
	mov AX, 4C00h
	int 21h
ENDM

.stack 10h

.data
	a DW 9
	b DW -2
	s DW ?
	
.code
	start:
		mov AX, @data
		mov DS, AX
		add2 a, b, s
		
		exit_dos
	END start