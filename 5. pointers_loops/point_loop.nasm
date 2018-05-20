%include    'functions.asm' ;include helper function file

section	.data           ;section defines nasm constants

    NULL_TERMINATOR equ 0; aka /0

    ;initialize message
    msg: db "Program running",10 ;10 for new line
	;msg_len	equ	$ - msg ;removed nasm len calc

section .bss            ;section defines variables
    ;variable: resb 20  ;REServe 20 bytes

section .text
    global _start

_start:
    mov rdi, msg
    mov rax, rbx

_strlen:
    xor rcx,rcx

_strlen_next:
    cmp [rdi], byte NULL_TERMINATOR
    je _calc_length
    
    inc rcx
    inc rdi
    jmp _strlen_next

_calc_length:
    mov rax, rcx
   
_write_msg:
;syscall API defined in linux kernel
;register mapping defined by x86-64 calling convention
    ;syswrite(rdi=int fd, rsi=const char *buf, rdx=size_t count)

        mov rdx,rax      ;mov message length to rdx

        ;rax is the temp register, stores number for syscall
        mov rax,SYS_WRITE 

        mov rdi,STDOUT_FILENO   ; file descriptor stored in rdi
        mov rsi, msg    ;mov message to rsi

        syscall        ;64-bit x86 prefers syscall to interrupt 0x80
        
    call _fin







