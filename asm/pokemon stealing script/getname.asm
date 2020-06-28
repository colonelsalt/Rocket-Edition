.text
.align 2
.thumb
.thumb_func

@loads the name and class of the last battled trainer into the free RAM space at 0x02021D18 and 0x02021D28

main:
	push {r0-r2, r4, lr}
	
	ldr r0, =(0x20386AE) @location of Trainer ID
	ldrh r1, [r0] @r1 now contains the trainer ID of the last battled trainer
	
	mov r0, #0x28
	mul r1, r0

	ldr r0, =(0x0823EAC9) @Trainer table
	add r1, r0 @r1 is now at the last battled trainer's class#
	
	ldrb r4, [r1] @r4 now contains the trainer class# (r4 because it's not affected by strcpy)
	add r1, #0x3 @moves r1 to location of trainer's name string
	
	ldr r0, =(0x02021D18) @freespace location no. 1 (to store name)
	ldr r2, =(0x8008D85) @strcopy
	bl linker
	
	mov r0, #0xD
	mul r4, r0
	
	ldr r1, =(0x0823E558) @Trainer class string table
	add r1, r4 @r1 is now at location of trainer class string of last battled trainer
	
	ldr r0, =(0x02021D28) @freespace location no. 2 (to store class)
	ldr r2, =(0x8008D85) @strcopy
	bl linker
	
	pop {r0-r2, r4, pc}
	
linker:
	bx r2
	
.align 2