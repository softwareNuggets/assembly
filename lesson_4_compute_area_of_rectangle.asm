;software nuggets - Lesson 4.
;the registers  64 bits   | rax    | rbx   | rcx   | rdx   | rbp  | rsp  | rsi  | rdi
;               32 bits   | eax    | ebx   | ecx   | edx   | ebp  | esp  | esi  | edi
;               16 bits   | ax     | bx    | cx    | dx    | bp   | sp   | si   | di
;                8 bits   | ah al  | bh bl | ch cl | dh dl | bpl  | spl  | sil  | dil

;dd: Double Word (32 bits)



section .data
    length dd 7        ; Length of the rectangle
    width  dd 12       ; Width of the rectangle

section .text
    global _start

_start:
; Load values from memory into registers
    mov rdi, [length]  ; Retrieve the value stored at the memory location of length into rdi
    mov rsi, [width]   ; Retrieve the value stored at the memory location of width into rsi

    
    ; Call the subroutine to compute the area
    call compute_area
    
    ; Exit the program with the result in rax
    mov rax, 60        ; syscall: exit
    mov rdi, rbx       ; Set the exit code to the result
    syscall


; Subroutine to compute the area
compute_area:
    ; Input: rdi = length, rsi = width
    ; Output: rbx = area
    xor rbx, rbx       ; initializing rbx to zero
    mov rbx, rdi       ; rbx = length
    imul rbx, rsi      ; rbx = rbx * width
    ret