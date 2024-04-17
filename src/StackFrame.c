/*
 * StackFrame.c
 *
 * Source file for StackFrame module that provides functionality relating to
 * stack frames and printing out stack frame data.
 *
 */

#include <stdio.h>
#include "StackFrame.h"

/*
 * Non-static (akin to "public") functions that can be called from anywhere.
 * Comments for each function are given in the module interface StackFrame.h
 *
 */

// Retrieves the caller's base pointer (frame pointer) from the stack.
unsigned long getBasePointer() {
    unsigned long basePointer;
    // Inline assembly to move the value at the address (RBP) into basePointer.
    asm("movq (%%rbp), %0" : "=r" (basePointer));
    return basePointer; // Returns the current frame's base pointer value.
}

// Fetches the return address from the caller's stack frame.
unsigned long getReturnAddress() {
    unsigned long returnAddress;
    asm("movq %%rbp, %%rax;"      // Move the value of RBP into RAX
        "movq (%%rax), %%rax;"    // Dereference RAX to get the caller's base pointer
        "movq 8(%%rax), %0;"      // Offset RAX by 8 to get the caller's return address
        : "=r" (returnAddress)     // Output operand, where the result is stored
        :                           // No input operands
        : "%rax"                   // Clobbered register, indicating RAX is modified
    );
    return returnAddress; // Returns the address to which the current frame will return on completion.
}

// Prints the contents of the stack from the base pointer to the previous base pointer.
void printStackFrameData(unsigned long basePointer, unsigned long previousBasePointer) {
    unsigned long *currentPointer = (unsigned long *)basePointer;
    unsigned long *endPointer = (unsigned long *)previousBasePointer;
    // Iterates over stack values from the current base pointer up to (but not including) the previous.
    while (currentPointer < endPointer) {
        printf("%016lx: ", (unsigned long)currentPointer); // Prints the current pointer address.
        unsigned long stackValue = *currentPointer; // Dereferences to get the value at that address.
        printf("%016lx --  ", stackValue); // Prints the stack value at the current address.

        // Prints each byte of the stack value in hexadecimal.
        for (int byte = 0; byte < 8; byte++) {
            printf("%02lx ", (stackValue >> (byte * 8)) & 0xff);
        }
        printf("\n"); // New line for the next stack value.
        currentPointer++; // Moves to the next stack value.
    }
}

// Prints out each stack frame up to the specified number of stack frames.
void printStackFrames(int number) {
    unsigned long basePointer = getBasePointer(); 

    // Loop through the number of stack frames requested.
    for (int i = 0; i < number; ++i) {
        printf("-------------\n"); 

        // Get the base pointer of the previous stack frame by dereferencing the current base pointer.
        unsigned long previousBasePointer = *(unsigned long *)basePointer;

        // Check if we've reached the end of the stack (base pointer is null).
        if (previousBasePointer == 0) {
            break; // Exit the loop if there are no more stack frames.
        }

        // Print the data for the current stack frame.
        printStackFrameData(basePointer, previousBasePointer);

        // Update basePointer to the previous one for the next iteration.
        basePointer = previousBasePointer;
    }
}