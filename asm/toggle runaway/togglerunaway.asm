.text
.align 2
.thumb
.thumb_func
.global ToggleRunAawayFR

Main:
	ldr r0, .Variable
	ldrb r0, [r0]
	cmp r0, #0x69
	beq CannotRun
Return:
	ldr r1, =(0x2023BE2)
	ldr r0, =(0x2023BCC)
	ldrb r0, [r0]
	strb r0, [r1]
	ldr r1, =(0x2023E8A)
	ldr r0, = (0x8016888 +1)
	bx r0
CannotRun:
	mov r6, #0x0
	ldr r0, = (0x801688C +1)
	bx r0

.align 2
.Variable:
	.word 0x020270B8 + (0x8006 * 2) @change to var of your choice if you want