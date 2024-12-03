#include <LPC17xx.h>  // Include the LPC17xx microcontroller header

int main() {
    // Array containing segment codes for numbers 0-9 and letters A-F for the seven-segment display
	
    int arr[] = {
        0x3F,  // 0
        0x06,  // 1
        0x5B,  // 2
        0x4F,  // 3
        0x66,  // 4
        0x6D,  // 5
        0x7D,  // 6
        0x07,  // 7
        0x7F,  // 8
        0x67,  // 9
        0x77,  // A
        0x7C,  // B
        0x39,  // C
        0x5E,  // D
        0x79,  // E
        0x71   // F
    };

    int i, j, col, key, x; // Declare variables for indexing and storing column/key values

    // Configure pin functions for GPIO
    LPC_PINCON->PINSEL0 = 0; // Set P0 as GPIO (clear any alternate functions)
    LPC_PINCON->PINSEL1 = 0; // Set P1 as GPIO
    LPC_PINCON->PINSEL3 = 0; // Set P3 as GPIO
    LPC_PINCON->PINSEL4 = 0; // Set P4 as GPIO

    // Set direction of the GPIO pins
    LPC_GPIO0->FIODIR = 0xF << 15 | 0xFF << 4; // P0.15-P0.18 as outputs (for seven-segment) and P0.4-P0.11 as outputs
    LPC_GPIO1->FIODIR = 0; // Set all pins of P1 as inputs (for keypad columns)
    LPC_GPIO2->FIODIR = 0xF << 10; // Set P2.10-P2.13 as outputs (for keypad rows)

    LPC_GPIO0->FIOPIN = 0; // Clear all output pins on P0

    // Main loop for scanning the keypad
    while (1) {
        for (i = 0; i < 4; i++) { // Loop through each row of the keypad
            LPC_GPIO2->FIOPIN = 1 << (10 + i); // Set the current row high
            for (j = 0; j < 50; j++); // Small delay to stabilize the row signal
            x = LPC_GPIO1->FIOPIN; // Read the input from the keypad columns
            x = (x >> 23) & 0xF; // Isolate the relevant bits for columns
            
            // Check if any key in the current row is pressed
            if (x != 0) {
                // Determine which column is pressed
                if (x == 1) col = 0;      // If column 1 is pressed
                else if (x == 2) col = 1; // If column 2 is pressed
                else if (x == 4) col = 2; // If column 3 is pressed
                else col = 3;             // If column 4 is pressed

                // Calculate the key pressed based on row and column
                key = 4 * i + col;

                // Mask the output pins to avoid affecting unused bits
                LPC_GPIO0->FIOMASK = 0xFFFFF00F; // Mask to enable bits 4-11 for output only

                // Output the corresponding segment code to the seven-segment display
                LPC_GPIO0->FIOPIN = arr[key] << 4; // Shift the segment code to match the display pins
            }
        }
    }
}
