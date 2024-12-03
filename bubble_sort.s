    AREA RESET, DATA, READONLY
    EXPORT __Vectors
    EXPORT Reset_Handler    ; Export the Reset_Handler as an entry point
__Vectors 
    DCD 0x40001000          ; Stack pointer value when stack is empty
    DCD Reset_Handler       ; Reset vector points to the Reset_Handler

    ALIGN

    AREA ascend, CODE, READONLY
    ENTRY                    ; Mark the entry point for the program

Reset_Handler
    ; Initializing the variables
    mov r4, #0               ; Set R4 to 0, used as an offset for array access
    mov r1, #10              ; Set R1 to 10, representing the number of elements in the list
    ldr r0, =list            ; Load the address of the list array into R0
    ldr r2, =result          ; Load the address of the result array into R2

    ; Copying the list into the result array
up  ldr r3, [r0, r4]         ; Load the value from list (R0 + offset R4) into R3
    str r3, [r2, r4]         ; Store the value from R3 into the result (R2 + offset R4)
    add r4, #4               ; Increment R4 by 4 to move to the next element (each element is 4 bytes)
    sub r1, #1               ; Decrement R1 by 1, counting down the elements
    cmp r1, #0               ; Compare R1 with 0 to check if all elements have been copied
    bhi up                   ; If R1 > 0, branch back to 'up' to continue copying

    ; Setting up the bubble sort
    ldr r0, =result          ; Load the base address of the result array into R0
    mov r3, #10              ; Load 10 into R3, representing the number of elements to sort
    sub r3, r3, #1           ; Decrement R3 by 1 because bubble sort needs n-1 comparisons per pass
    mov r9, r3               ; Copy R3 into R9, keeping track of the number of passes required

    ; Outer loop of bubble sort
outer_loop 
    mov r5, r0               ; Copy the base address of result into R5 (pointer to traverse the array)
    mov r4, r3               ; Copy the number of comparisons in a pass into R4

    ; Inner loop of bubble sort
inner_loop 
    ldr r6, [r5], #4         ; Load current element from R5 into R6, then increment R5 by 4
    ldr r7, [r5]             ; Load the next element from R5 into R7
    cmp r7, r6               ; Compare the two elements (R7 and R6)
    
    ; Swap elements if needed
    strls r6, [r5]           ; If R7 is less than or equal to R6, store R6 in current position (swap)
    strls r7, [r5, #-4]      ; Store R7 in the previous position
    subs r4, r4, #1          ; Decrement the inner loop counter (R4)
    bne inner_loop           ; If R4 is not zero, branch to 'inner_loop' to continue

    ; Decrement outer loop counter and check
    sub r3, #1               ; Decrement R3 to reduce the number of comparisons in the next pass
    subs r9, r9, #1          ; Decrement the pass counter (R9)
    bne outer_loop           ; If the pass counter (R9) is not zero, branch to 'outer_loop'

    ; Data section (arrays)
list 
    DCD 0x10, 0x05, 0x33, 0x24, 0x56, 0x77, 0x21, 0x04, 0x87, 0x01  ; Array of 10 hexadecimal numbers to sort

    AREA data1, DATA, READWRITE
result 
    DCD 0,0,0,0,0,0,0,0,0,0  ; Result array initialized with zeros, will hold the sorted numbers

    END
