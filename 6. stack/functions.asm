section	.data           ;section defines nasm constants

;http://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/
    STDOUT_FILENO equ 1  ;file descriptor #1=standard out (cmd line)
    STDIN_FILENO equ 0  ; file descriptor #0=standard in (cmd line)
    SYS_WRITE   equ 1   ;syscall #1 = sys_write
    SYS_READ    equ 0   ;syscall #0 = sys_read
    SYS_EXIT equ 60 ;syscall #60 = sys_exit
    NULL_TERMINATOR equ 0; aka /0

_write_msg:
;void write_msg(rsi=msg, msg_len)
;syscall API defined in linux kernel
        ;rax is the temp register, stores number for syscall
        mov rax,SYS_WRITE 
;register mapping defined by x86-64 calling convention
    ;syswrite(rdi=int fd, rsi=const char *buf, rdx=size_t count)
        push rdi        ;nonvolatile register, preserved by callee
        mov rdi,STDOUT_FILENO   ; file descriptor stored in rdi
        mov rdx,[msg_len]      ;mov message length to rdx
        syscall        ;64-bit x86 prefers syscall to interrupt 0x80
        pop rdi         ;revert rdi to original value from stack
        RET  

_strlen:
;int msg_len strlen(rdx=const char *buf)
    ;returns length of rdx as msg_len and in rax
    xor rax, rax
    mov rax, rdx  ;set accumulator to start of message arg in rax

    _strlen_while_loop:
        cmp byte [rax], byte NULL_TERMINATOR ; if (rax == null):
        jz _save_length ; if zero flag set, jump to _save_length

        ;else:
        inc rax ;accumulator +=1
        jmp _strlen_while_loop ;repeat

    _save_length:
        ;final count stored in rcx
        sub rax,rdx     ;rax - rdx = length (saved in rax)
        mov [msg_len], rax ;save length in variable       
        RET 

_strlenSTK:
;int msg_len strlen(rdx=const char *buf)
    ;returns length of rdx as msg_len and in rax
    push rsp
    push rbp
    mov rbp, rsp    ;set base and stack pointer to same value
    push rdx    ;push msg to the stack
    sub rbp, rsp    ;calc diff between base pointer and stack pointer
    mov [msg_len], rbp  
    pop rbp
    pop rsp

_fin:
;exit procedure
    ;void sys_exit(rdi=int error_code)
	mov	rax,SYS_EXIT    ;syscall #60 = sys_exit
    mov rdi, 0 ;error code 0 to indicate successful exit
    SYSCALL
