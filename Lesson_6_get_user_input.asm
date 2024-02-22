;Prompt user to type in there name, then print Hi {username}
;https://chromium.googlesource.com/chromiumos/docs/+/master/constants/syscalls.md
;https://github.com/softwareNuggets/assembly/blob/main/Lesson_6_get_user_input.asm

%define SYS_WRITE 1
%define SYS_READ  0
%define SYS_EXIT 60
%define STDIN    0
%define STDOUT   1

section .data
    prompt db "What's your name: "
    prompt_len EQU $-prompt
    showHi db 10,"Hi ",0
    showHi_len EQU $-showHi
    
section .bss
    username resb 16            ;resb = reserve bytes (16) for username variable

section .text
    global _start

_start:
    call _printPromptToGetUserName
    call _getUserInputFromStdin
    call _printHi
    call _printUserName
    call _exit_app
    

_printPromptToGetUserName:
    mov rax, SYS_WRITE
    mov rdi, STDOUT               ;stdin=0, stdout=1,stderr=2
    mov rsi, prompt
    mov rdx, prompt_len           ;calculated len
    syscall
    ret
    
_getUserInputFromStdin:
    mov rax, SYS_READ
    mov rdi, STDIN               ;stdin=0, stdout=1,stderr=2
    mov rsi,username
    mov rdx,16                   ;reserved bytes in .bss section username
    syscall
    ret
    
_printHi:
    mov rax, SYS_WRITE
    mov rdi, STDOUT                ;stdin=0, stdout=1,stderr=2
    mov rsi, showHi
    mov rdx, showHi_len
    syscall
    ret
    

_printUserName:
    mov rax, SYS_WRITE
    mov rdi, STDOUT              ;stdin=0, stdout=1,stderr=2
    mov rsi, username
    mov rdx, 16
    syscall
    ret 
    

_exit_app:    
    mov rax, SYS_EXIT            ;sys_exit(int error_level)
    mov rdi, 0                   ;error_level = 0
    syscall