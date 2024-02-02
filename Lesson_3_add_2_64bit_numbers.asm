;The goal of this video is to show you how to add two numbers in Assembly Language 
;The 16 general purpose registers are 64 bit values stored within the CPU
;  we can access the registers as 64 bits   | rax    | rbx   | rcx   | rdx   | rbp  | rsp  | rsi  | rdi
;                                 32 bits   | eax    | ebx   | ecx   | edx   | ebp  | esp  | esi  | edi
;                                 16 bits   | ax     | bx    | cx    | dx    | bp   | sp   | si   | di
;                                 8 bits    | ah al  | bh bl | ch cl | dh dl | bpl  | spl  | sil  | dil

;db: Byte (8 bits)
;dw: Word (16 bits)
;dd: Double Word (32 bits)
;dq  Double quadword (64 bits)

%define SYS_WRITE 1
%define SYS_EXIT  60
%define STDOUT 1
%define NUL    0x00

section .data
    num1   dq 25          ; First integer (32 bits)
    num2   dq 13          ; Second integer (32 bits)
    result dq 0           ; Variable to store the result (32 bits)
    buffer db 20 DUP(NUL) ; declare 20 bytes, initialize with 0x00

section .text
    global _start

_start:
    ; Add the two integers
    mov rax, [num1]    ; Load num1 into rax  ;  let eax = num1
    add rax, [num2]    ; Add num2 to rax     ;  let eax = eax + 13
    mov [result], rax  ; Store the result in the result variable

    ; Convert the result to a string
    mov rax, [result]  ; Load the numerical result into rax
    mov rdi, rax       ; Source address (the numerical result)
    mov rsi, buffer    ; Destination address (buffer for ASCII representation)
    call int_to_str    ; Call the conversion routine

    ; Display the result
    mov rax, SYS_WRITE      ; System call number for sys_write(int fd, char *buff, size_t count);
    mov rdi, STDOUT         ; fd=File descriptor (stdout); stdin=0, stdout=1, stderr=2
    mov rsi, buffer         ; Pointer to the ASCII representation
    mov rdx, 20             ; Number of bytes to write (adjust as needed)
    syscall                 ; Make the system call

    ; Exit the program
    mov rax, SYS_EXIT       ; System call number for sys_exit sys_exit(int error_code);
    xor rdi, rdi            ; Exit code 0
    syscall                 ; Make the system call

int_to_str:
    ; Conversion routine to convert a 32-bit integer to a null-terminated string
    ; Input: rdi - Source address (32-bit integer)
    ;        rsi - Destination address (buffer for ASCII representation)
    ; the step-up
    mov     rax, rdi           ;Load the source address (32-bit integer)
    mov     rcx, 10            ;Set divisor to 10 for decimal conversion
    mov     rbx, rsi           ;Load the destination address (buffer for ASCII representation)
    add     rbx, 19            ;Point ebx to the end of the buffer
    
                               ;        0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9
                               ;buffer=[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]
                               
    mov     byte [rbx], 0      ; Null-terminate the string

reverseLoop:
    dec     rbx          ; Move to the previous position in the buffer
    xor     rdx, rdx     ; Clear any previous remainder
                         
    div     rcx          ; Divide eax by 10, result in eax, remainder in rdx
    add     dl, '0'      ; Convert the remainder to  (48)
    
    mov     [rbx], dl    ; Store the ASCII character in the buffer
    test    rax, rax     ; Check if quotient is non-zero
    jnz     reverseLoop  ; If non-zero, continue the loop

    ret                  ; Return from the subroutine 
