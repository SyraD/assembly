
section	.data
    STDOUT  equ 1
    SYS_WRITE   equ 4

section .text
global _start

_start:

	
_fin:
	mov	rax,1	;linux command for exit()
    mov rbx, 4  ;status code
    ;int -> call to interrupt procedure
    int	0x80    ;interrupt, transfers program flow to 0x80 handler (e.g. the kernel) that executes rax



