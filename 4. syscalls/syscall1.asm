
section	.data
    ;define nasm constants with equ
;http://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/
    STDOUT  equ 1  ;file descriptor #1=standard out (cmd line)
    SYS_WRITE   equ 1   ;syscall #4 = sys_write
    SYS_READ    equ 0   ;syscall #3 = sys_read
    SYS_EXIT equ 60 ;syscall #60 = sys_exit

    ;initialize message
    msg: db "Input a value",10 ;10 for new line; file descriptor 1 = stdout
	msg_len	equ	$ - msg

section .text
global _start


_start:

_write_msg:
;syscall API defined in linux kernel
;register mapping defined by x86-64 calling convention
    ;syswrite(rdi=int fd, rsi=const void *buf, rdx=size_t count)

        ;rax is the temp register, stores number for syscall
        mov rax,1  

        mov rdi,STDOUT   ; file descriptor stored in rdi
        mov rsi, msg    ;mov message to rsiov 1 status code
        mov rdx,msg_len      ;mov message length to rdx
        syscall        ;64-bit x86 prefers syscall to interrupt 0x80
	
_fin:
;exit procedure
    ;sys_exit(rdi=int error_code)
	mov	rax,SYS_EXIT    ;syscall value in rax
    mov rdi, 0 ;error code 0 to indicate successful exit
    syscall



