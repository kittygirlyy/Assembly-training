.text
.global _start

_start:
	Loop:
		add r0, #2
		sub r0, #2
		b Loop