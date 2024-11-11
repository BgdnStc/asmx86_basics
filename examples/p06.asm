.model large

.stack 10h

exit_dos MACRO
	mov AX, 4C00h
	int 21h
	ENDM
	
srcseg SEGMENT
	src DB 'ASM x86 on bits$'
	dimsrc DW $-src
srcseg ENDS

dstseg SEGMENT
	dst DB '111111111111111$'
	dimdst DW $-dst
dstseg ENDS

mainprogseg SEGMENT
	ASSUME CS: mainprogseg, DS:srcseg, ES:dstseg
	start:
		mov AX, seg src
		mov DS, AX
		
		mov AX, seg dst
		mov ES, AX
		
		cld
		mov SI, offset src
		mov DI, offset dst
		mov CX, dimsrc
		
		rep movsb
		
		exit_dos
	mainprogseg ENDS
	END start