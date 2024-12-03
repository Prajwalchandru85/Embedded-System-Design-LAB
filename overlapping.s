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
	ldr r0 ,=src+4*(N-1)
	ldr r1 ,=src+4*(Shift+N-1)
	mov r3,#5
back	ldr r4,[r0],#-4
	ldr r4,[r1],#-4
	sub r3,#1
	cmp r3,#0
	bne back
STOP B STOP
N EQU 5
Shift EQU 2
	AREA mydata,DATA,READWRITE
src dcd 0,0,0,0,0
end
	