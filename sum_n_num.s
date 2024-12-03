   AREA RESET, DATA, READONLY
    EXPORT __Vectors
__Vectors
    DCD 0x40001000
    DCD Reset_Handler 
    ALIGN

    AREA mycode, CODE, READONLY
    ENTRY
    EXPORT Reset_Handler
Reset_Handler
	mov r0,#4
	mov r1,r0
	mov r2,r0
	mla r4,r0,r1,r2
up
	cmp r4,#2
	blo exit
	sub r4,#2
	add r5,#1
	b up
exit
stop b stop
end
	
	