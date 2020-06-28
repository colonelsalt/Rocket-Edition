.text
.align 2
.thumb
.thumb_func

main:
	push {r0-r7, lr}
	
	ldr r0, =(0x20386AE) @Trainer ID of last battled trainer
	ldrh r0, [r0]
	
	mov r1, #0x28
	mul r0, r0, r1
	
	ldr r2, =(0x823EAE8) @Trainer table
	add r2, r2, r0 @r2 now points to where the number of Pokémon trainer has is stored
	ldrb r3, [r2] @r3 now contains the number of Pokémon trainer has

	ldr r5, =(0x020370D2) @Variable 0x800F
	strh r3, [r5] @Stores number of Pokémon trainer has
	
	add r2, #0x4
	ldr r2, [r2] @r2 now contains a pointer to the Pokémon information
	add r2, #0x2 @r2 is now at level of Pkm1 
	
	ldr r0, =(0x0203F4A0) @freespace
	ldr r4, =(0x08245EE0) @Pokémon string table
	sub r5, #0x1A @moves r5 to location of var 0x8000
	
	mov r6, #0x0
	
loop:
@stores level of each of trainer's Pokémon in vars 0x8000, -2, -4, -6, -8 and -A
@stores species of each of trainer's Pokémon in vars 0x8001, -3, -5, -7, -9 and -B 
@stores pointer to each Pokémon's name in the correct multichoice option location

	ldrb r1, [r2]
	strh r1, [r5] @Stores level of Pkm in var
	
	add r2, #0x2 @r2 is now at species of Pkm
	ldrb r1, [r2]
	add r5, #0x2 @moves to next variable
	strh r1, [r5] @Stores species of Pkm in var
	
	mov r7, #0xB
	mul r1, r1, r7
	add r1, r1, r4 @r1 now contains pointer to Pkm's name string
	str r1, [r0] @stores pointer to Pkm's name in choice x
	
	add r6, #0x1 @increments iterative
	
	cmp r6, r3
	BEQ end @goes to end if loop has executed same amount of times as available Pokémon
	
	add r0, #0x8 @moves to location to store string of next choice
	add r2, #0x6 @moves to location of next Pkm's level
	add r5, #0x2 @moves to next variable
	b loop
	
end:
	pop {r0-r7, pc}

.align 2	