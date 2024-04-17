	.file	"Factorial.c"
	.text
	.type	factorial, @function
factorial:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	cmpq	$1, -8(%rbp)
	ja	.L2
	movl	$7, %edi
	call	printStackFrames
	movq	-16(%rbp), %rax
	jmp	.L3
.L2:
	movq	-8(%rbp), %rax
	imulq	-16(%rbp), %rax
	movq	-8(%rbp), %rdx
	subq	$1, %rdx
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	factorial
.L3:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	factorial, .-factorial
	.section	.rodata
	.align 8
.LC0:
	.string	"executeFactorial: basePointer = %lx\n"
	.align 8
.LC1:
	.string	"executeFactorial: returnAddress = %lx\n"
	.align 8
.LC2:
	.string	"executeFactorial: about to call factorial which should print the stack\n"
	.align 8
.LC3:
	.string	"executeFactorial: factorial(%lu) = %lu\n"
	.text
	.globl	executeFactorial
	.type	executeFactorial, @function
executeFactorial:
.LFB1:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movl	$0, %eax
	call	getBasePointer
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rsi
	movl	$.LC0, %edi
	movl	$0, %eax
	call	printf
	movl	$0, %eax
	call	getReturnAddress
	movq	%rax, -16(%rbp)
	movq	-16(%rbp), %rax
	movq	%rax, %rsi
	movl	$.LC1, %edi
	movl	$0, %eax
	call	printf
	movl	$.LC2, %edi
	call	puts
	movq	$0, -24(%rbp)
	movq	$6, -32(%rbp)
	movq	$1, -40(%rbp)
	movq	-40(%rbp), %rdx
	movq	-32(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	factorial
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rdx
	movq	-32(%rbp), %rax
	movq	%rax, %rsi
	movl	$.LC3, %edi
	movl	$0, %eax
	call	printf
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	executeFactorial, .-executeFactorial
	.ident	"GCC: (GNU) 11.4.1 20230605 (Red Hat 11.4.1-2)"
	.section	.note.GNU-stack,"",@progbits
