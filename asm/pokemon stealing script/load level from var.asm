.text
.align 2
.thumb
.thumb_func
	@hooks from givepokemon function; if Pokémon's level is set to 0xFF in XSE, level is
	@loaded instead from var 0x8001, -3, -5, -7, -9 or -B, according to the player's
	@multichoice selection, and stores it in r1. Proceeds as normal otherwise.

main:
	ldrb r1, [r0, #0x0] @loads level of Pokémon to be given into r1
	cmp r1, #0xFF
	BNE end @jumps to end if Pokémon's level is not 255
	
	push {r0, r3}
	ldr r0, =(0x020370B8) @var 0x8000; contains level of Pkm1
	ldr r2, =(0x020370D0) @LASTRESULT; contains Player's multichoice selection (if there is one)
	ldrb r2, [r2]
	mov r3, #0x0 @initializes iterable
	cmp r2, #0x0
	bne loop
	mov r2, #0x1 @if there is no multichoice selection (i.e. Trainer has only 1 Pkmn), load level from 1st slot
	
loop:
	cmp r2, r3
	BEQ loader
	add r0, #0x4 @moves to location of next variable (containing level of Pkm)
	add r3, #0x1
	b loop
	
loader:
	ldrb r0, [r0]
	mov r1, r0 @stores byte loaded from variable into r1
	pop {r0, r3}
	
end: 
	mov r2, r0 @restores r2 to its original value (pointer to script location)
	
	@original instructions from givepokemon removed for hook:
	mov r9, r1
	add r0, #0x1
	str r0, [r4, #0x8]
	add r0, r4, #0x0
	
	ldr r1, =(0x0806BFFA + 1) @original location
	bx r1
.align 2	