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
	ldr r0,=bcd
	ldr r1,=hex
	ldr r2,[r0]
	mov r3,r2
	lsr r2,#4;second num
	and r3,#0xf;first num
	mov r4,#0xa
	mla r5,r4,r2,r3
	str r5,[r1]
stop b stop
bcd dcd 0x91
	AREA mydata,DATA,readwrite
hex dcd 0
end
	
	