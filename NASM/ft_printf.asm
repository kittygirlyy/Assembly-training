section .data
    fmt db "Integer: %d, String: %s", 10, 0
    int_value dq 42
    str_value db "Meowww Mawwws", 0
    buffer db "            ", 0

section .text
    global _start

_start:
    ; Affiche le msg
    mov rdi, fmt
    mov rsi, int_value
    mov rdx, str_value
    call ft_printf

    ; Sys_exit
    mov rax, 60
    xor rdi, rdi
    syscall

; Ft_printf
ft_printf:
    ; Format
    mov rax, 1
    mov rdi, 1
    mov rsi, rdi
    mov rdx, 29
    syscall

	; Int
    mov rax, rsi
    call int_to_string

    ; Str
    mov rax, 1
    mov rdi, 1
    lea rsi, [buffer]
    mov rdx, 20
    syscall

    ; Affiche str
    mov rax, 1
    mov rdi, 1
    mov rsi, str_value
    mov rdx, 14
    syscall

    ret

; Int to string
int_to_string:
    mov rcx, 10
    mov rbx, buffer + 19
    mov byte [rbx], 0
    test rax, rax
    jnz .convert

    mov byte [rbx - 1], '0'
    jmp .done

.convert:
    xor rdx, rdx
.next_digit:
    xor rdx, rdx
    div rcx
    add dl, '0'
    dec rbx
    mov [rbx], dl
    test rax, rax
    jnz .next_digit

.done:
    lea rsi, [rbx]
    ret
