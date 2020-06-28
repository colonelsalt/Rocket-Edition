.text
.align 2
.thumb
.thumb_func

main:
	ldr r0, =(0x2022B4C)
	ldr r1, [r0]
	ldr r2, .VAR
	ldrb r2, [r2]
	cmp r2, #0x69
	beq uncatchable
	ldr r0, = (0x802D490 +1)
	bx r0

uncatchable:
	ldr r0, = (0x802D460 +1)
	bx r0
	
	

.align 2
.VAR:
	.word 0x020270B8 + (0x8004 * 2) @change to var of your choice if you want
