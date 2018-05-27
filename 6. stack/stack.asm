%include    'functions.asm' ;include helper function file

section	.data           ;section defines nasm constants
    ;initialize message strings ending with new line(10) and null byte(0h)
    msg: db "Program running",10,0h
    msg2: db "yup, still going",10,0h
    ;msg_len	equ	$ - msg 
    ;replaced nasm length macro with _strlen

section .bss            ;section defines variables
    msg_len: resb 1  ;REServe # bytes

section .text
    global _start

_start:
    mov rdx, msg    ;set rdx to start of message
    call _strlen    ;calculate length of rdx and stores in msg_len
    mov rsi, msg
    call _write_msg ;prints var msg of length msg_len
    
    mov rdx, msg2
    call _strlen
    mov rsi, msg2
    call _write_msg    
    
    call _fin









