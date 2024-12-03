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
	ldr r0 ,=n
	mov r8,#5
up	ldr r1,[r0],#4
	lsl r1,r2
	add r3,r1
	add r2,#4
	subs r8,#1
	bne up
stop b stop
n dcd 0x1,0x2,0x3,0x4,0x5
end
