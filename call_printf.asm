global main                        ; Declare the entry point of the program

extern printf                     ; Declare printf as an external function, assumed to be defined 

section .data                     ; Start of the data section

    format_1:  	db "How to call printf using Assembly Language",10,0
    format_2:  	db "Call printf with one parameter: %d",10,0     
    format_3:  	db "Call printf with two params: %d %d",10,0     
    format_4:  	db "Call printf with three params: %d+%d=%d",10,0
    format_5:  	db "Call printf with string : %s",10,0        
    channel:  	db "softwareNuggets",10,0                      

section .text 

main:               		; Entry point of the program

    push rbp             	; Preserve the base pointer
    mov rbp,rsp              	; Set up the base pointer
    sub rsp,16               	; Allocate space for local variables on the stack

;example_1
    xor eax, eax              	; Clear the eax register (set to zero)
    lea rdi, [format_1]         ; Load the address of the message into rdi
    call printf                 ; Call printf with the message
    mov r10,rax

;example_2
    xor eax, eax              	; Clear the eax register (set to zero)
    lea rdi,[format_2]               ; Load the address of format string into rdi
    mov rsi,r10                    ; Load the first parameter (10) into rsi
    call printf                    ; Call printf with one parameter
    mov r10,rax


;example_3
    xor eax, eax              	; Clear the eax register (set to zero)
    lea rdi,[format_3]               ; Load the address of format string into rdi
    mov rsi,r10                    ; Load the first parameter (10) into rsi
    mov rdx,15d                    ; Load the second parameter (25) into rdx
    call printf                    ; Call printf with two parameters
    mov r10,rax


;example_4
    xor eax, eax
    lea rdi,[format_4]
    mov rsi,r10       
    mov rdx,15d  
    mov rcx, rsi
    add rcx, rdx     
    call printf       

;example_5
    xor eax, eax
    lea rdi,[format_5]
    lea rsi,[channel]              ; Load the address of channel string into rsi
    call printf                    ; Call printf with a string parameter


    add rsp,16                     ; Clean up the stack
    leave                          ; Restore the stack frame
    ret                            ; Return from the main function
