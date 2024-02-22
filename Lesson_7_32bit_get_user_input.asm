;Prompt user to type in there name, then print Hi {username} 32bit intel-syntax
;https://chromium.googlesource.com/chromiumos/docs/+/master/constants/syscalls.md
;https://github.com/softwareNuggets/assembly/blob/main/Lesson_7_32bit_get_user_input.asm

;online web site to compile and run this program:     https://ideone.com/   

%define SYS_WRITE_32 4
%define SYS_READ_32  3
%define SYS_EXIT_32  1

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
    mov eax, SYS_WRITE_32
    mov ebx, STDOUT               ;stdin=0, stdout=1,stderr=2
    mov ecx, prompt
    mov edx, prompt_len           ;calculated len
    int 0x80
    ret
    
_getUserInputFromStdin:
    mov eax, SYS_READ_32
    mov ebx, STDIN               ;stdin=0, stdout=1,stderr=2
    mov ecx,username
    mov edx,16                   ;reserved bytes in .bss section username
    int 0x80
    ret
    
_printHi:
    mov eax, SYS_WRITE_32
    mov ebx, STDOUT                ;stdin=0, stdout=1,stderr=2
    mov ecx, showHi
    mov edx, showHi_len
    int 0x80
    ret
    

_printUserName:
    mov eax, SYS_WRITE_32
    mov ebx, STDOUT              ;stdin=0, stdout=1,stderr=2
    mov ecx, username
    mov edx, 16
    int 0x80
    ret 
    

_exit_app:    
    mov eax, SYS_EXIT_32         ;sys_exit(int error_level)
    mov ebx, 0                   ;error_level = 0
    int 0x80