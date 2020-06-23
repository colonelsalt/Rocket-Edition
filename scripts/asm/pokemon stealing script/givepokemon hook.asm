.text
.align 2
.thumb
.thumb_func

main:
	ldr r2, =(0x088022B0 + 1) @subject to change
	bx r2

.align 2	