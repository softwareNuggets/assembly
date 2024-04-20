global main
extern printf


section .data
	msg: 		db "How to call printf using Assembly Language",10,0
	format:		db "Call printf with one parameter: %d",10,0
	format2:	db "Call printf with two params: %d %d",10,0
	format3:	db "Call printf with three params: %d+%d=%d",10,0
	format4:	db "Call printf with string : %s",10,0
	channel:  	db "softwareNuggets",10,0


section .text

main:
	push rbp
	mov rbp,rsp
	sub rsp,16

	xor eax, eax 
	lea rdi, [msg]
	call printf

	mov eax,0
	lea rdi,[format]
	mov rsi,10d
	call printf

	mov eax,0
	lea rdi,[format2]
	mov rsi,10d
	mov rdx,25d
	call printf


	mov eax,0
	lea rdi,[format3]
	mov rsi,10d
	mov rdx,25d
	mov rcx,35d
	call printf

	mov eax,0
	lea rdi,[format4]
	lea rsi,[channel]
	call printf

	add rsp,16
	leave
	ret
