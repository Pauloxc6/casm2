section .text
    global _start

soma: ;int main(int x, int y){return x+y;}
    mov eax,[esp+4]
    mov ebx,[esp+8]
    add eax,ebx ; eax = eax + ebx
    ret

_start:

    push ebp
    mov ebp,esp
    sub ebp,4


    ;soma(3,4)
    push 3
    push 4
    call soma
    add esp,8

    add eax,0x30
    mov [ebp-4],eax

    ;write
    mov eax,4
    mov ebx,1
    lea ecx, [ebp-4]
    mov edx,1
    int 0x80

    pop ebp
 
    ;exit
    mov eax,1 ;syscall exit = 1
    mov ebx,0
    int 0x80
