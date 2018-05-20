
%include    'functions.asm' ;include helper function file

section	.data           ;section defines nasm constants
    input_len equ 20    ;set constant for length of user input

    ;initialize message
    msg: db "Program running",10 ;10 for new line; 
	msg_len	equ	$ - msg

section .bss            ;section defines variables
    user_input: resb input_len  ;REServe 20 bytes

section .text
    global _start

_start:
    call _write_msg
    call _read_input
    call _fin







