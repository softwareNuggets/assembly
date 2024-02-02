; Are you ready to learn how to ADD two numbers in the Assembly Programming Language?
; The 16 general purpose registers are 64 bit values stored within the CPU
;  we can access the registers as 64 bits   | rax    | rbx   | rcx   | rdx   | rbp  | rsp  | rsi  | rdi
;                                 32 bits   | eax    | ebx   | ecx   | edx   | ebp  | esp  | esi  | edi
;                                 16 bits   | ax     | bx    | cx    | dx    | bp   | sp   | si   | di
;                                 8 bits    | ah al  | bh bl | ch cl | dh dl | bpl  | spl  | sil  | dil

;db: Byte (8 bits)
;dw: Word (16 bits)
;dd: Double Word (32 bits)


%define SYS_WRITE 1
%define SYS_EXIT  60
%define STDOUT 1
%define NUL    0x00

section .data
    num1   dd 25          ; First integer (32 bits)
    num2   dd 13          ; Second integer (32 bits)
    result dd 0           ; Variable to store the result (32 bits)
    buffer db 20 DUP(NUL) ; declare 20 bytes, initialize with 0x00

section .text
    global _start

_start:
    ; Add the two integers
    mov eax, [num1]    ; Load num1 into eax  ;  let eax = num1
    add eax, [num2]    ; Add num2 to eax     ;  let eax = eax + 13
    mov [result], eax  ; Store the result in the result variable

    ; Convert the result to a string
    mov eax, [result]  ; Load the numerical result into eax
    mov edi, eax       ; Source address (the numerical result)
    mov esi, buffer    ; Destination address (buffer for ASCII representation)
    call int_to_str    ; Call the conversion routine

    ; Display the result
    mov eax, SYS_WRITE      ; System call number for sys_write(int fd, char *buff, size_t count);
    mov edi, STDOUT         ; fd=File descriptor (stdout); stdin=0, stdout=1, stderr=2
    mov esi, buffer         ; Pointer to the ASCII representation
    mov edx, 20             ; Number of bytes to write (adjust as needed)
    syscall                 ; Make the system call

    ; Exit the program
    mov eax, SYS_EXIT       ; System call number for sys_exit sys_exit(int error_code);
    xor edi, edi            ; Exit code 0
    syscall                 ; Make the system call

int_to_str:
    ; Conversion routine to convert a 32-bit integer to a null-terminated string
    ; Input: edi - Source address (32-bit integer)
    ;        esi - Destination address (buffer for ASCII representation)
    ;
    ;   ASCII chart ('character' = decimal ascii value)
    ;   '0' = 48     '3' = 51      '6' = 54     '9' = 57
    ;   '1' = 49     '4' = 52      '7' = 55
    ;   '2' = 50     '5' = 53      '8' = 56    
    
    mov     eax, edi           ;Load the source address (32-bit integer)
    mov     ecx, 10            ;Set divisor to 10 for decimal conversion
    mov     ebx, esi           ;Load the starting destination address of buffer into ebx
    add     ebx, 19            ;Point ebx to the end of the buffer
    
                               ;        0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9
                               ;buffer=[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]
                               
    mov     byte [ebx], NUL    ; Null-terminate the string

reverseLoop:
    dec     ebx          ; Move to the previous position in the buffer
    xor     edx, edx     ; Clear any previous remainder
                         
    div     ecx          ; Divide eax by 10, result in eax, remainder in edx
    add     dl, '0'      ; Convert the remainder to  (48)
    
    mov     [ebx], dl    ; Store the ASCII character in the buffer
    test    eax, eax     ; Check if quotient is non-zero
    jnz     reverseLoop  ; If non-zero, continue the loop

    ret                  ; Return from the subroutine 
