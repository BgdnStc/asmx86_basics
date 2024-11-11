.model small
.stack 10h ;ask for a 16 byte stack
.data
	;define global variables
	a DB 14  ;14 in decimal
	b DB 14h ;20 in decimal
	result DB ?
	x DW 1234h
	y DD 33445566h
	z DQ 1122112211221122h
	w DT 0
.code
	MOV AX,@data
	MOV DS,AX
the_main:
	XOR AX,AX
	MOV AL, a
	ADD AL, b
	MOV result, AL
	MOV AX, 4C00h
	INT 21h
the_end:
	MOV AX, offset the_end
end the_main