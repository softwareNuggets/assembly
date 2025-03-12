section .data
    format_specifier db "File: %s, Size: %ld, Date: %04d-%02d-%02d %02d:%02d:%02d",10,0
    filename db "example.txt",0

section .text
global main
extern printf

main:
    push rbp
    mov rbp, rsp

    ;save space for stack arguments and alignment
    sub rsp, 32


    ;first 6 arguments go into registers
    mov rdi, format_specifier
    mov rsi, filename
    mov rdx, 1024
    mov rcx, 2025
    mov r8, 2
    mov r9, 28

    mov qword [rsp+16],45    ; seconds (9th arg)
    mov qword [rsp+8], 30    ; minutes (8th arg)
    mov qword [rsp+0], 15      ; hours (7th arg)

    ;call printf
    xor eax, eax
    call printf

    ;clean up and exit
    mov rsp, rbp
    pop rbp
    xor eax, eax
    ret
