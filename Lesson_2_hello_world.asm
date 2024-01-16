; second assembly program ... hello world

; syscall_64.tbl             --64-bit system call numbers and entry vectors
; syscall.h                  --Linux syscall interfaces (non-arch-specific)
; syscall table

%define SYS_WRITE 1
%define SYS_EXIT 60
%define STDOUT   1

section .data
    msg db "Hello --- World!",0xa
    ;msg db 'H','e','l','l','o',' ','W','o','r','l','d','!',10
    ;msg db 72,101,108,108,111,32,87,111,114,108,100,33,10
   msg_len EQU $ - msg
    
section .text
    global _start

_start:
    mov rax, SYS_WRITE      ;long sys_write(unsigned int fd, const char *buf, size_t count);
                            ;   fd = File descriptor stdin=0,stdout=1,stderr=2 
    mov rdi, STDOUT
    mov rsi, msg
    mov rdx, msg_len
    syscall
    
    mov rax, SYS_EXIT
    mov rdi, 0
    syscall
