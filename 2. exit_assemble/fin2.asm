
section	.data
    STDOUT  equ 1
    SYS_WRITE   equ 4
    EXIT_SYSCALL equ 60

section .text
global _start

_start:

	
_fin:
	mov	rax,EXIT_SYSCALL
    ;rax is the temp register, stores number for syscall
    mov rdi, 0 ;error code 0 to indicate successful exit
    ;rdi passes first argument to fxn
    syscall



