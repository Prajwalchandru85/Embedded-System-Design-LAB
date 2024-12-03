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
	ldr r0,=num
	ldr r1,[r0]
	mov r2,#1
	bl fact
	ldr r3,=facto
	str r2,[r3]
stop b stop
fact	cmp r1,#1	
	beq exit
	push {r1,lr}
	sub r1,#1
	bl fact
exit	pop{r1,lr}
	mul r2,r1
	bx lr
num dcd 0x3
	AREA mydata,DATA,READWRITE
facto dcd 0
end