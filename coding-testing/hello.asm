section .data
	msg db "Hello World",0x0a
	tam equ $-msg

section .text
	global _start

_start:

	;write
	mov eax,4
	mov ebx,1
	mov ecx,msg
	mov edx,tam
	int 0x80

	;exit
	mov eax,1
	mov ebx,0
	int 0x80
