.text
.align 2
.thumb
.thumb_func

main:
	@load Pkmn selection from var 0x8004
	@move to location of selected Pkmn's level (0x020242D8 + 0x64 * SLOT)
	@store level in var 0x8000
	
	push {r0-r1, lr}
	ldr r0, =(0x020370C0) @var 0x8004
	ldrh r0, [r0]
	
	mov r1, #0x64
	mul r0, r1

	ldr r1, =(0x020242D8) @RAM location of 1st Pkmn's level
	add r1, r0 @moves to selected Pkmn's level
	ldrb r1, [r1]
	
	ldr r0, =(0x020370B8) @var 0x8000
	strh r1, [r0]
	
	pop {r0-r1, pc}
	
.align 2	