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
	ldr r1,[r0]
STOP B STOP
src dcd 0x55
	end
	
	