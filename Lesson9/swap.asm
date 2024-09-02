global main
extern printf

section .data
    before_swap db "original order of numbers",10,0
    after_swap  db 10,"after [positions 0,1] were swapped",10,0
    fmt db "position=%d, value=%d", 10, 0   ; Format string for printf
    nums dq 13, 3, 14, 8, 19 		    ;0,8,16,24,32
    array_size equ 5

section .text
main:
    ; Allocate stack frame
    push rbp
    mov rbp, rsp
   
    ;print message to screen 
    xor rax, rax
    lea rdi, [before_swap]
    call printf


    ; Call functions
    call show_nums
    call swap_nums
    
    ;print message to screen 
    xor rax, rax
    lea rdi, [after_swap]
    call printf

    call show_nums
    
    ; Exit program
    mov rax, 60           ; Syscall number for exit
    xor rdi, rdi          ; Exit code 0
    syscall


swap_nums:
    push rbp
    mov rbp, rsp
    push rbx
    push rcx
   

    ; Swap nums[0] and nums[1]
    mov rbx, [nums]          ; Load nums[0]
    mov rcx, [nums + 8]      ; Load nums[1]
    mov [nums], rcx          ; Store nums[1] in nums[0]
    mov [nums + 8], rbx      ; Store nums[0] in nums[1]
 
    ; Swap nums[0] and nums[1]
    ;mov rbx, [nums + 0 * 8]      ; Load nums[0]
    ;mov rcx, [nums + 1 * 8]      ; Load nums[1]
    ;mov [nums + 0 * 8], rcx      ; Store nums[1] in nums[0]
    ;mov [nums + 1 * 8], rbx      ; Store nums[0] in nums[1]
    
    pop rcx
    pop rbx
    pop rbp
    ret

show_nums:
    push rbp
    mov rbp, rsp
    push r12
    push r13
    
    mov r12, 0               ; Index i = 0
    mov r13, array_size      ; Number of elements in array

show_nums_loop:
    cmp r12, r13             ; Compare index with array_size
    jge show_nums_exit
    
    mov rsi, r12             ; First parameter: position
    mov rdx, [nums + r12 * 8] ; Second parameter: value from array[i]
    
    ; Print using printf
    mov rdi, fmt             ; Format string
    xor eax, eax             ; Clear AL (no floating point arguments)
    call printf
    
    inc r12
    jmp show_nums_loop

show_nums_exit:
    pop r13
    pop r12
    pop rbp
    ret
