    .file "Factorial.c"                 # Indicate the source file name
    .text                               # Start of the text (code) section
    .type factorial, @function          # Declare the factorial function as a global symbol with the type @function
factorial:
.LFB0:
    .cfi_startproc  
    pushq %rbp                          # Save the current base pointer
    .cfi_def_cfa_offset 16
	.cfi_offset 6, -16
    movq %rsp, %rbp                     # Set the base pointer to the current stack pointer.
    .cfi_def_cfa_register 6
    subq $16, %rsp                      # Allocate space for local variables
    movq %rdi, -8(%rbp)                 # Store the first argument 'n' in the local variable
    movq %rsi, -16(%rbp)                # Store the second argument 'accumulator' in the local variable
    cmpq $1, -8(%rbp)                   # Compare 'n' with 1 to check for the base case
    ja .L2                              # If 'n' is greater than 1, jump to label .L2 (recursive case)
    movl $7, %edi                       # Load 7 into %edi, preparing to call printStackFrames
    call printStackFrames               # Call printStackFrames function to print stack frame data
    movq -16(%rbp), %rax                # Move 'accumulator' into return register %rax
    jmp .L3                             # Jump to label .L3 to exit function
.L2:
    movq -8(%rbp), %rax                 # Load 'n' into %rax
    imulq -16(%rbp), %rax               # Multiply 'n' by 'accumulator', result in %rax
    movq -8(%rbp), %rdx                 # Load 'n' into %rdx
    subq $1, %rdx                       # Decrement 'n' by 1
    movq %rax, %rsi                     # Set up second argument for recursive call: updated 'accumulator'
    movq %rdx, %rdi                     # Set up first argument for recursive call: decremented 'n'
    call factorial                      # Recursive call to factorial function
.L3:
    leave                               # Restore previous stack frame
    .cfi_def_cfa 7, 8
    ret                                 # Return to caller
    .cfi_endproc
.LFE0:
    .size factorial, .-factorial        # Specify the size of the factorial function
    .section .rodata                    # Begin the read-only data section for string literals
    .align 8                            # Align the following data on an 8-byte boundary
.LC0:
    .string "executeFactorial: basePointer = %lx\n" # String literal for printing the base pointer
    .align 8                            # Align the following data on an 8-byte boundary
.LC1:
    .string "executeFactorial: returnAddress = %lx\n" # String literal for printing the return address
    .align 8                             # Align the following data on an 8-byte boundary
.LC2:
    .string "executeFactorial: about to call factorial which should print the stack\n" # String literal indicating the call to factorial
    .align 8                             # Align the following data on an 8-byte boundary
.LC3:
    .string "executeFactorial: factorial(%lu) = %lu\n" # String literal for printing the result of factorial
    .text                                # Switch back to the text section for code
    .globl executeFactorial              # Declare executeFactorial as a global symbol
    .type executeFactorial, @function    # Specify the type of executeFactorial as a function
executeFactorial:
.LFB1:
    .cfi_startproc
    pushq %rbp                          # Save the current base pointer
    .cfi_def_cfa_offset 16
	.cfi_offset 6, -16
    movq %rsp, %rbp                     # Set the base pointer to the current stack pointer
    .cfi_def_cfa_register 6
    subq $48, %rsp                      # Allocate space for local variables
    movl $0, %eax                       # Zero out %eax (used before calling 'call' for vararg functions)
    call getBasePointer                 # Call getBasePointer to get the base pointer of the current stack frame
    movq %rax, -8(%rbp)                 # Store the base pointer in a local variable
    movq -8(%rbp), %rax                 # Load the base pointer into %rax for printing
    movq %rax, %rsi                     # Set up second argument for printf: base pointer
    movl $.LC0, %edi                    # Load the format string for printing base pointer
    movl $0, %eax                       # Zero out %eax (used before calling 'call' for vararg functions)
    call printf                         # Call printf to print the base pointer
    movl $0, %eax                       # Zero out %eax (used before calling 'call' for vararg functions)
    call getReturnAddress               # Call getReturnAddress to get the return address of the current stack frame
    movq %rax, -16(%rbp)                # Store the return address in a local variable
    movq -16(%rbp), %rax                # Load the return address into %rax for printing
    movq %rax, %rsi                     # Set up second argument for printf: return address
    movl $.LC1, %edi                    # Load the format string for printing return address
    movl $0, %eax                       # Zero out %eax (used before calling 'call' for vararg functions)
    call printf                         # Call printf to print the return address
    movl $.LC2, %edi                    # Load the string to indicate calling factorial
    call puts                           # Call puts to print the string
    movq $0, -24(%rbp)                  # Initialize the result variable to 0
    movq $6, -32(%rbp)                  # Load the default number into a local variable
    movq $1, -40(%rbp)                  # Initialize the accumulator to 1
    movq -40(%rbp), %rdx                # Load the accumulator into %rdx for the factorial call
    movq -32(%rbp), %rax                # Load the default number into %rax for the factorial call
    movq %rdx, %rsi                     # Set up second argument for factorial call: accumulator
    movq %rax, %rdi                     # Set up first argument for factorial call: default number
    call factorial                      # Call factorial function with default number and accumulator
    movq %rax, -24(%rbp)                # Store the result of factorial in the result variable
    movq -24(%rbp), %rdx                # Load the result into %rdx for printing
    movq -32(%rbp), %rax                # Load the default number into %rax for printing
    movq %rax, %rsi                     # Set up second argument for printf: default number
    movl $.LC3, %edi                    # Load the format string for printing the result
    movl $0, %eax                       # Zero out %eax (used before calling 'call' for vararg functions)
    call printf                         # Call printf to print the result of factorial
    nop                                 # No operation (commonly used for alignment)
    leave                               # Restore previous stack frame
    .cfi_def_cfa 7, 8
    ret                                 # Return to caller
    .cfi_endproc
.LFE1:
    .size executeFactorial, .-executeFactorial # Specify the size of the executeFactorial function
    .ident "GCC: (GNU) 11.4.1 20230605 (Red Hat 11.4.1-2)" # Compiler version information
    .section .note.GNU-stack,"",@progbits # Note directive for the GNU stack