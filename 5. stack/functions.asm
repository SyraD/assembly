section	.data           ;section defines nasm constants

;http://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/
    STDOUT_FILENO equ 1  ;file descriptor #1=standard out (cmd line)
    STDIN_FILENO equ 0  ; file descriptor #0=standard in (cmd line)
    SYS_WRITE   equ 1   ;syscall #1 = sys_write
    SYS_READ    equ 0   ;syscall #0 = sys_read
    SYS_EXIT equ 60 ;syscall #60 = sys_exit

_write_msg:
;syscall API defined in linux kernel
;register mapping defined by x86-64 calling convention
    ;syswrite(rdi=int fd, rsi=const char *buf, rdx=size_t count)

        ;rax is the temp register, stores number for syscall
        mov rax,SYS_WRITE 

        mov rdi,STDOUT_FILENO   ; file descriptor stored in rdi
        mov rsi, msg    ;mov message to rsi
        mov rdx,msg_len      ;mov message length to rdx
        syscall        ;64-bit x86 prefers syscall to interrupt 0x80
        ret

_read_input:
        mov rax,SYS_READ 
        ;sys_read(rdi=int fd, rsi=char*buf, rdx=size_t count)
        mov rdi,STDIN_FILENO
        mov rsi, user_input 
        mov rdx,input_len      ;allocated length for user input
        syscall 
        ret

_fin:
;exit procedure
    ;sys_exit(rdi=int error_code)
	mov	rax,SYS_EXIT    ;syscall #60 = sys_exit
    mov rdi, 0 ;error code 0 to indicate successful exit
    syscall
