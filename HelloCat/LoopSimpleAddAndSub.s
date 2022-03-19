.text
.global _start

_start:
    add r0, #2
    sub r0, #2
    b _start
