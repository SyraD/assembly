
section	.data           ;section defines nasm constants

;http://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/
    STDOUT_FILENO equ 1  ;file descriptor #1=standard out (cmd line)
    STDIN_FILENO equ 0  ; file descriptor #0=standard in (cmd line)
    SYS_WRITE   equ 1   ;syscall #1 = sys_write
    SYS_READ    equ 0   ;syscall #0 = sys_read
    SYS_EXIT equ 60 ;syscall #60 = sys_exit

    input_len equ 20    ;set constant for length of user input

    ;initialize message
    msg: db "Input a value",10 ;10 for new line; file descriptor 1 = stdout
	msg_len	equ	$ - msg

section .bss            ;section defines variables
    user_input: resb input_len  ;REServe 20 bytes

section .text
global _start


_start:

_write_msg:
;syscall API defined in linux kernel
;register mapping defined by x86-64 calling convention
    ;syswrite(rdi=int fd, rsi=const char *buf, rdx=size_t count)

        ;rax is the temp register, stores number for syscall
        mov rax,SYS_WRITE 

        mov rdi,STDOUT_FILENO   ; file descriptor stored in rdi
        mov rsi, msg    ;mov message to rsiov 1 status code
        mov rdx,msg_len      ;mov message length to rdx
        syscall        ;64-bit x86 prefers syscall to interrupt 0x80

_read_input:
        mov rax,SYS_READ 
        ;sys_read(rdi=int fd, rsi=char*buf, rdx=size_t count)
        mov rdi,STDIN_FILENO
        mov rsi, user_input 
        mov rdx,input_len      ;allocated length for user input
        syscall        

_fin:
;exit procedure
    ;sys_exit(rdi=int error_code)
	mov	rax,SYS_EXIT    ;syscall value in rax
    mov rdi, 0 ;error code 0 to indicate successful exit
    syscall



