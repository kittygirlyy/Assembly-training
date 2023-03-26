global multiply
section .text

multiply:
  mov rax, rdi
  mul rsi
  ret