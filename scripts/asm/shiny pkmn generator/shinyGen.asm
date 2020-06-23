.text
.align 2
.thumb
.thumb_func

main:
	ldr r0, =(0x20370BC) @0x8002 is shiny flag
	ldrb r0, [r0]
	cmp r0, #0xFF
	bne noCrash
	push {r4-r7}
	ldr r0, =(0x20370BC) @set back to 0x0 because users tend to be retarded
	mov r1, #0x0
	strb r1, [r0]
	bl generatePID
	mov r4, r0
	@c = A xor B; 0<= C <8; use random to determine C
	ldr r0, =(0x20370B8)
	mov r1, #0x8
	strb r1, [r0]
	ldr r4, =(0x8851530 + 1)
	bl linker
	mov r3, r0
	@(TID xor SID)
	ldr r0, =(0x300500C)
	ldr r0, [r0]
	mov r1, #0xA
	add r1, r1, r0@TID
	ldrh r1,[r1]
	mov r2, #0xC
	add r0, r0, r2 @SID
	ldrh r0, [r0]
	eor r0, r0, r1 @(TID XOR SID) = A
	eor r3, r3, r0 @(C XOR A) = B
	@B = (PID[half-word] xor PID2[half-word])
	lsl r4, r4, #0x10
	lsr r4, r4, #0x10
	eor r3, r3, r4 @(PID[half-word] XOR B) = PID2
	@concatinate r4 + r3
	lsl r3, #0x10
	orr r3,r3, r4 @PID for shiny
	pop {r4-r7}
	str r3, [SP, #0x14]
	b end


noCrash:
	bl generatePID
	mov r4, r0
	b old

generatePID:
	push {r4, lr}
	ldr r4, =(0x8044EC8 +1)
	bl linker
	mov r4, r0
	ldr r3, =(0x8044EC8 +1)
	bl linkerThree
	lsl r4, r4, #0x10
	lsr r4, r4, #0x10
	lsl r0, r0, #0x10
	orr r4, r0
	mov r0, r4
	pop {r4, pc}

old:
	str r4, [SP, #0x14]

end:
	ldr r0, =(0x803DB14 +1)
	bx r0

linker:
	bx r4

linkerThree:
	bx r3

.align 2