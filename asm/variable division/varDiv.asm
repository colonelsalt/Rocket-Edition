.text
.align 2
.thumb
.thumb_func

@divides number stored in var 0x8000 with that in LASTRESULT, and puts quotient in LASTRESULT

main:
	push {r0-r3, lr}
	ldr r0, .VAR_8000
	ldr r1, .VAR_LASTRESULT
	ldrh r0, [r0] @ r0 = n
	ldrh r1, [r1] @ r1 = d
	mov r2, #0x0 @ iterator
	mov r3, #0x0 @ return value

loop:
	add r3, #0x1 @ retval++
	add r2, r1 @ i += d
	cmp r2, r0
	blt loop
	
	ldr r1, .VAR_LASTRESULT
	strh r3, [r1]
	pop {r0-r3, pc}
	
.align 2

.VAR_8000:
	.word 0x20370B8
.VAR_LASTRESULT:
	.word 0x020270B6 + (0x800D * 2)