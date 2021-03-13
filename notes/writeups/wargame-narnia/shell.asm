; shell.asm
; true shellcode

[section .text]
[global _start]

_start:
    jmp short ender

starter:
    pop ebx     ; addr of string
    xor eax, eax
    mov [ebx+7], al     ; null
    mov [ebx+8], ebx    ; 

    mov [ebx+12], eax
    mov al, 11  ; execve
    lea ecx, [ebx+8]
    lea edx, [ebx+12]
    int 0x80

; 记住 exec 需要的参数是二维数组
ender:
    call starter
    db '/bin/sh/NAAAABBBB'
