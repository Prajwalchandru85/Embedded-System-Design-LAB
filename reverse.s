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
	ldr r1 ,=src+4*(n-1);pointing to last digit in the array
back	ldr r2,[r0]
	ldr r3,[r1]
	str r3,[r0],#4
	str r2,[r1],#-4
	add r5 ,#1
	cmp r5 ,#n/2
	bne back
STOP B STOP
n equ 4
	AREA mydata,DATA,READWRITE	
src dcd 0,0,0,0
end 