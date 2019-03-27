global _PDCLIB_Exit
_PDCLIB_Exit:
	; arg should already be in rdi
	mov rax, 9 ; Exit syscall
	syscall
