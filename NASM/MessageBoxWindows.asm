global _main
extern _MessageBoxA@16

section .text

_main:
    push 0
    push 0
    push hello
    push 0
    call _MessageBoxA@16

hello:
    db "meow", 0