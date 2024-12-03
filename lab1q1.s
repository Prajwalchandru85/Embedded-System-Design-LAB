	AREA RESET,DATA,READONLY
	EXPORT __Vectors
__Vectors
	dcd 0x10000000
	dcd Reset_Handler
	ALIGN
	AREA mycode,CODE,READONLY
	ENTRY
	EXPORT Reset_Handler
Reset_Handler
	ldr r0 ,=src
	ldr r1 ,=dst
	mov r3,#10
BACK	ldr r4,[r0],#4
	str r4,[r1],#4
	sub r3,#1
	cmp r3,#0
	BNE BACK
STOP B STOP
src dcd 0x30,0x25,0x45,0x89,0x85,0x17,0x36,0x28,0x99,0xA
	AREA mydata,DATA,READWRITE
dst dcd 0,0,0,0,0,0,0,0,0,0
	END
	