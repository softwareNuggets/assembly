;Prompt user to type in there name, then print Hi {username} 
;64Bit Intel-Syntax Assembly
;https://chromium.googlesource.com/chromiumos/docs/+/master/constants/syscalls.md
;https://github.com/softwareNuggets/assembly/blob/main/Lesson_6_64bit_get_user_input.asm

; read, write, exit - system call table function lookup
%define SYS_WRITE_64 1
%define SYS_READ_64  0
%define SYS_EXIT_64 60

%define STDIN    0
%define STDOUT   1

%macro MACRO_SYS_WRITE_64 2
    mov rax, SYS_WRITE_64
    mov rdi, STDOUT           ;stdin=0, stdout=1,stderr=2
    mov rsi, %1
    mov rdx, %2               ;calculated len
    syscall
%endmacro

%macro MACRO_SYS_READ_64 2
    mov rax, SYS_READ_64
    mov rdi, STDIN               ;stdin=0, stdout=1,stderr=2
    mov rsi,%1
    mov rdx,%2                   ;reserved bytes in .bss section username
    syscall
%endmacro

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
    MACRO_SYS_WRITE_64 prompt,prompt_len
    ;mov rax, SYS_WRITE_64
    ;mov rdi, STDOUT               ;stdin=0, stdout=1,stderr=2
    ;mov rsi, prompt
    ;mov rdx, prompt_len           ;calculated len
    ;syscall
    ret
    
_getUserInputFromStdin:
    MACRO_SYS_READ_64 username, 16
    ;mov rax, SYS_READ_64
    ;mov rdi, STDIN               ;stdin=0, stdout=1,stderr=2
    ;mov rsi,username
    ;mov rdx,16                   ;reserved bytes in .bss section username
    ;syscall
    ret
    
_printHi:
    MACRO_SYS_WRITE_64 showHi,showHi_len
    ;mov rax, SYS_WRITE_64
    ;mov rdi, STDOUT                ;stdin=0, stdout=1,stderr=2
    ;mov rsi, showHi
    ;mov rdx, showHi_len
    ;syscall
    ret
    

_printUserName:
    MACRO_SYS_WRITE_64 username,16
    ;mov rax, SYS_WRITE_64
    ;mov rdi, STDOUT              ;stdin=0, stdout=1,stderr=2
    ;mov rsi, username
    ;mov rdx, 16
    ;syscall
    ret 
    

_exit_app:    
    mov rax, SYS_EXIT_64            ;sys_exit(int error_level)
    mov rdi, 0                   ;error_level = 0
    syscall