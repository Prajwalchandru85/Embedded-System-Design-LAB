    AREA RESET, DATA, READONLY
    EXPORT __Vectors
__Vectors
    DCD 0x10000000
    DCD Reset_Handler
    ALIGN

    AREA mycode, CODE, READONLY
    ENTRY
    EXPORT Reset_Handler

Reset_Handler
    LDR R0, =src1         ; Load the address of src1 into R0
    LDR R1, =src2         ; Load the address of src2 into R1
    LDR R3, =dst          ; Load the address of dst into R3
    MOV R2, #4            ; Set counter R2 to 4 (number of 32-bit words to add)
    
back
    LDR R4, [R0], #4      ; Load a word from src1 and post-increment R0 by 4
    LDR R5, [R1], #4      ; Load a word from src2 and post-increment R1 by 4
    ADDS R6, R4, R5       ; Add the two words, storing result in R6 (with carry)
    STR R6, [R3], #4      ; Store the result in dst and post-increment R3 by 4

    SUBS R2, R2, #1       ; Decrement counter R2
    TEQ R2, #0            ; Test if R2 is zero by XORing with 0 (sets flags)
    BNE back              ; If R2 is not zero, branch back to add the next words

                ; Infinite loop to stop the program

STOP
    B STOP                ; Infinite loop

    AREA mydata, DATA, READWRITE
src1 DCD 0x0000f23, 0x2, 0xff, 0x1  ; Define src1 array (128 bits)
src2 DCD 0x0000f23, 0x5, 0xae, 0xf  ; Define src2 array (128 bits)
dst  SPACE 16                        ; Reserve space for dst (128 bits)
END
