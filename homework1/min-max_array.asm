.model large

Data SEGMENT
	min1 DW ?
	min2 DW ?
	min3 DW ?
	max1 DW ?
	max2 DW ?
	max3 DW ?
	vect1 DW 1, 2, 3
	len1 DW 3
	vect2 DW 10, -5, 30, 100
	len2 DW 4
	vect3 DW 9, 3, 0, 21, -69
	len3 DW 5
Data ENDS

StackSeg SEGMENT
	DW 45 DUP(3)
	endstack LABEL WORD
StackSeg ENDS

Main SEGMENT
	ASSUME CS:Main, DS:Data, SS:StackSeg
start:
	mov AX, seg Data
	mov DS, AX
	mov AX, seg StackSeg
	mov SS, AX
	mov SP, offset endstack
	
	mov AX, seg vect1
	push AX
	mov AX, offset vect1
	push AX
	mov AX, len1
	push AX
	mov AX, seg min1
	push AX
	mov AX, offset min1
	push AX
	mov AX, seg max1
	push AX
	mov AX, offset max1
	push AX
	call FAR ptr findmax
	
	mov AX, seg vect2
	push AX
	mov AX, offset vect2
	push AX
	mov AX, len2
	push AX
	mov AX, seg min2
	push AX
	mov AX, offset min2
	push AX
	mov AX, seg max2
	push AX
	mov AX, offset max2
	push AX
	call FAR ptr findmax
	
	mov AX, seg vect3
	push AX
	mov AX, offset vect3
	push AX
	mov AX, len3
	push AX
	mov AX, seg min3
	push AX
	mov AX, offset min3
	push AX
	mov AX, seg max3
	push AX
	mov AX, offset max3
	push AX
	call FAR ptr findmax
	
	mov AX, 4c00h
	int 21h	
Main ENDS

Procedures SEGMENT
	ASSUME CS:Procedures
	findmax PROC FAR
		push BP
		mov BP, SP
		push AX
		push BX
		push CX
		push SI
		push DX
		push DS
		
		mov CX, SS:[BP+14]
		mov SI, SS:[BP+16]
		mov AX, SS:[BP+18]
		mov DS, AX
		xor AX, AX	
		mov AX, DS:[SI]
		push DS
		push SI
		mov SI, SS:[BP+10]
		mov BX, SS:[BP+12]
		mov DS, BX
		mov DS:[SI], AX
		mov SI, SS:[BP+6]
		mov SI, SS:[BP+8]
		mov DS:[SI], AX
		pop SI
		pop DS
		
		iteration:
			dec CX
			cmp CX, 0
			jle endloop
			add SI, 2
			mov AX, DS:[SI]			
			push DS
			push SI
			mov SI, SS:[BP+10]
			mov BX, SS:[BP+12]
			mov DS, BX
			cmp DS:[SI], AX
			jle endmin
			mov DS:[SI], AX
		endmin:
			mov SI, SS:[BP+6]
			mov BX, SS:[BP+8]
			mov DS, BX
			cmp DS:[SI], AX
			jge endmax
			mov DS:[SI], AX
		endmax:
			pop SI
			pop DS
			jmp iteration
			
		endloop:
			pop DS
			pop DX
			pop SI
			pop CX
			pop BX
			pop AX
			pop BP
			retf 10
	findmax ENDP
Procedures ENDS

END start