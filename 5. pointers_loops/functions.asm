section	.data           ;section defines nasm constants

;http://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/
    STDOUT_FILENO equ 1  ;file descriptor #1=standard out (cmd line)
    STDIN_FILENO equ 0  ; file descriptor #0=standard in (cmd line)
    SYS_WRITE   equ 1   ;syscall #1 = sys_write
    SYS_READ    equ 0   ;syscall #0 = sys_read
    SYS_EXIT equ 60 ;syscall #60 = sys_exit

_fin:
;exit procedure
    ;sys_exit(rdi=int error_code)
	mov	rax,SYS_EXIT    ;syscall #60 = sys_exit
    mov rdi, 0 ;error code 0 to indicate successful exit
    syscall
