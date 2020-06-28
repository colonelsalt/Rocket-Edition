.text
.align 2
.thumb
.thumb_func
.global editcoords

main:
	push {r0-r2, lr}
		
	ldr r0, .POINTER
	ldr r1, [r0] 

	ldr r2, .VAR2
	ldrh r2, [r2]
	strh r2, [r1]

	add r1, r1, #0x2

	ldr r2, .VAR3
	ldrh r2, [r2]
	strh r2, [r1]

	pop {r0-r2, pc}


.align 2
.POINTER:
	.word 0x03005008
.VAR2:
	.word 0x020370BC
.VAR3:
	.word 0x020370BE