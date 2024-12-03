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
	ldr r0,=n1
	ldr r1,=n2
	ldr r7,=res
	ldr r3,[r0]
	ldr r4,[r1]
	mov r8,#0
	mov r6,#1
up	
	mul r8,r3,r6
u
	cmp r8,r4
	blo exit
	sub r8,r4
	b u
exit
	cmp r8,#0
	beq exitt
	add r6,#1
	b up
exitt
	mul r9,r6,r3
	str r9,[r7]
stop b stop
n1 dcd 0x00000004
n2 dcd 0x00000006
	AREA mydata,data,readwrite
res dcd 0
end
	