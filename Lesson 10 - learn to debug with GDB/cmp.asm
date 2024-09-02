global main

section .data
section .text
main:

    mov r10,6
    mov r11,7
    
    cmp r10, r11
    jge exit_app   ;6>=7 True  if SF == OF then jump


    mov r10, 6
    mov r11, 7

    cmp r10, r11
    jge exit_app   ;6>=7 True  if SF == OF then jump

    xor rax, rax
    mov rax, 60           ; Syscall number for exit
    xor rdi, rdi          ; Exit code 0
    syscall

exit_app:
    ; Exit program
    mov rax, 60           ; Syscall number for exit
    xor rdi, rdi          ; Exit code 0
    syscall
