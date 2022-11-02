.text
.global _start

_start:
        push    {r7}
        sub     sp, sp, #20
        add     r7, sp, #0
        str     r0, [r7, #4]
        str     r1, [r7]
        ldr     r3, [r7, #4]
        ldr     r3, [r3]
        str     r3, [r7, #12]
        ldr     r3, [r7]
        ldr     r3, [r3]
        str     r3, [r7, #8]
        ldr     r3, [r7, #4]
        ldr     r2, [r7, #8]
        str     r2, [r3]
        ldr     r3, [r7]
        ldr     r2, [r7, #12]
        str     r2, [r3]
        nop
        adds    r7, r7, #20
        mov     sp, r7
        ldr     r7, [sp], #4
        bx      lr
