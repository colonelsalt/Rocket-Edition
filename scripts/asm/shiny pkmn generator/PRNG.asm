.text
.align 2
.thumb
.thumb_func

main:
	push {r4, lr}
	ldr r4, =(0x8044EC8 +1)@gen random number
	bl linker
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	ldr r1, =(0x20370B8) @convert to int between 0x0 to [var 0x8000] exclusive
	ldrh r1, [r1]
	ldr r4, =(0x81E4684 +1)
	bl linker
	ldr r1, =(0x20370D0) @store in last result
	strh r0, [r1]
	pop {r4, pc}

linker:
	bx r4

.align 2