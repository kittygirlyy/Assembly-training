SECTION .text
global opposite

opposite:
  neg edi
  mov eax, edi
  ret