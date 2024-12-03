	AREA RESET, DATA, READONLY
	EXPORT __Vectors
__Vectors
	DCD 0X10001000; STACK POINTER
	DCD Reset_Handler
	ALIGN
	AREA mycode, CODE, READONLY
	ENTRY
	EXPORT Reset_Handler
Reset_Handler
	LDR R0, =ARRAY
	LDR R1, =KEY
	LDR R1, [R1]
	LDR	R10, =DST
	MOV R11, #0
	
	; FOR ALL ELEMENTS CMP KEY AND ELE, IF SAME EXIT AND SAVE POSITION
UP	LDR R2, [R0], #4	
	ADD R11, #1
	CMP R1, R2
	BEQ EXIT
	B UP
EXIT
	CMP R11, #(SIZE+1)
	BEQ NOTFOUND
	STR R11, [R10]
	B STOP
NOTFOUND
	STR R12, [R11]		
STOP B STOP
ARRAY DCD 11, 12, 13, 14, 15, 16, 17, 18, 19, 20
SIZE EQU 10
KEY DCD 21
	
	AREA mydata, DATA, READWRITE
DST DCD 0
	END
	
	