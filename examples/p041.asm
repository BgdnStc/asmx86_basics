.model large

MyDataSeg SEGMENT
	sum DW ?
	vect DW 7, -2, 9, 11
	n DW 4
MyDataSeg ENDS

MyStack SEGMENT
	DW 16 DUP(3)
	ENDSTACK label word
MyStack ENDS

MyMain SEGMENT
	ASSUME CS:MyMain, DS:MyDataSeg, SS:MyStack
start:
	; init segments registers
	mov AX, seg MyDataSeg
	mov DS, AX
   
	mov AX, seg MyStack
	mov SS, AX
	mov SP, offset endstack
	
	
	; prepare procedure call by pushing params on the stack
	; void addv(short int* sum, short int n, short int* vect)
	mov AX, seg vect
	push AX
	mov AX, offset vect
	push AX
   
	mov AX, n
	push AX
   
	mov AX, seg sum
	push AX
	mov AX, offset sum
	push AX
	call FAR ptr addv
	
	mov AX, 4C00h
	int 21h
MyMain ENDS

MyProcs SEGMENT
	ASSUME CS:MyProcs
	addv PROC FAR
		push BP
		mov BP, SP
		
		push AX
		push CX
		push SI
		push BX
		push DX
		; [val DX], [val BX], [val SI], [val CX], [valAX], **[val BP], ret@[offset after call, seg MyMain], [offset sum, seg sum], [val n], [off vect, seg vect]
		xor AX, AX
		mov CX, SS:[BP+10]
		mov SI, 0
		; prepare pointer vect = @vect from stack = seg:off = DS:[BX]
		mov BX, SS:[BP+12]
		mov AX, SS:[BP+14]
		mov DS, AX
     
		xor AX, AX
		label_while:
			add AX, DS:[BX][SI]
			add SI, 2
		loop label_while
		
		mov BX, SS:[BP+6]
		mov DX, SS:[BP+8]
		mov DS, DX
		mov DS:[BX], AX
		
		pop DX
		pop BX
		pop SI
		pop CX
		pop AX
		
		pop BP
		retf 10
	addv ENDP
MyProcs ENDS

END start