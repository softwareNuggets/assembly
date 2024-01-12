; first assembly program ... yes before hello world

; syscall_64.tbl             --64-bit system call numbers and entry vectors
; syscall.h                  --Linux syscall interfaces (non-arch-specific)

segment .text
    global _start

_start:
    mov rax, 60           ;use syscall_64   look for 60  sys_exit
                          ;sets the system call number for sys_exit in the rax register.
                          ;the system call number for exit is 60
                          
    mov rdi, 7            ;use syscall.h   error_code 
                          ;long sys_exit(int error_code);
                          ;sets the error code (first parameter) to 4 in the rdi register.

                          ;rdi: first parameter
                          ;rsi: second parameter
                          ;rdx: third parameter
                          ;rcx: fourth parameter
                          ;r8: fifth parameter
                          ;r9: 6th parameter
    syscall 