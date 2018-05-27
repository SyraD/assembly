%include    'functions.asm' ;include helper function file

section	.data           ;section defines nasm constants

    NULL_TERMINATOR equ 0; aka /0

    ;initialize message
    msg: db "Program running",10 ;10 for new line
    ;msg_len	equ	$ - msg 
    ;replaced nasm length macro with _strlen

section .bss            ;section defines variables
    msg_len: resw 1  ;REServe # bytes

section .text
    global _start

_start:

_strlen:
    mov rdi, msg ;set pointer to start of message
    xor rcx,rcx ;clear out counter

    _strlen_while_loop:
        cmp [rdi], byte NULL_TERMINATOR ; if (rdi == null):
        jz _save_length ; if zero flag set, jump to _save_length

        ;else:
        inc rcx ;counter +=1
        inc rdi ;pointer +=1
        jmp _strlen_while_loop ;repeat

    _save_length:
        ;final count stored in rcx
        dec rcx ;length of string is one less than count
        mov [msg_len], rcx    ;save counted length to variable
    
call _write_msg
call _fin







