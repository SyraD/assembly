
section	.data
    ;define nasm constants with equ
    STDOUT  equ 1
    SYS_WRITE   equ 4
    num1: equ 1
    num2: equ 1

    ;initialize message
    msg: db "Numbers are equal",10 ;10 for new line
	msg_len	equ	$ - msg

    msg2: db "Numbers are NOT equal",10 ;10 for new line
	msg2_len	equ	$ - msg2

section .text
    global _start

;;entry point
_start:
    ;mov puts src in dest. Intel sytax: mov dest,src
    mov rax, num1
    mov rbx,num1

    jmp _compare

    ;mov puts src in dest. Intel sytax: mov dest,src
    mov rax, num1
    ;set num2 in rbx
    mov rbx,num2
    
    jmp _compare
    
    jmp _fin



_compare:
    cmp rbx,rax
    je _write_equal
    jne _write_not_equal
    ret

_write_equal:
        mov rax,1   ;move 1 to rax
        mov rdi,1   ;mov 1 to rdi
        mov rsi, msg    ;mov message to rsi
        mov rdx,msg_len      ;mov message length to rdx
        syscall

_write_not_equal:
        mov rax,1   ;move 1 to rax
        mov rdi,1   ;mov 1 to rdi
        mov rsi, msg2    ;mov message to rsi
        mov rdx,msg2_len      ;mov message length to rdx
        syscall


;exit procedure
_fin:
	mov	rax,1	;linux command for exit()
    mov rbx, 4  ;status code
    ;int -> call to interrupt procedure
    int	0x80    ;interrupt, transfers program flow to 0x80 handler (e.g. the kernel) that executes rax



