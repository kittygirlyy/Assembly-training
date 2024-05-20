section .bss
    size resb 2
    buffer resb 128

section .data
    prompt db "Entrez la taille : ", 0
    newline db 10, 0
    space db " ", 0
    star db "*", 0

section .text
    global _start

_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt
    mov edx, 29
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, buffer
    mov edx, 2
    int 0x80

    sub byte [buffer], '0'
    mov al, [buffer]
    movzx ecx, al

    xor ebx, ebx
pyramid_loop:
    inc ebx
    cmp ebx, ecx
    jg done

    ; Espaces
    mov edx, ecx
    sub edx, ebx
space_loop:
    cmp edx, 0
    je stars
    mov eax, 4
    mov ebx, 1
    mov ecx, space
    mov edx, 1
    int 0x80
    dec edx
    jmp space_loop

stars:
    mov edx, ebx
star_loop:
    cmp edx, 0
    je newline
    mov eax, 4
    mov ebx, 1
    mov ecx, star
    mov edx, 1
    int 0x80
    dec edx
    jmp star_loop

newline:
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80
    jmp pyramid_loop

done:
    mov eax, 1
    xor ebx, ebx
    int 0x80
