.text
.align 2
.thumb
.thumb_func
.global battlemusichack

main:
	ldr r0, there
	ldr r1, [r0, #0x0]
	mov r0, #0x80
	lsl r0, r0, #0x5
	and r0, r1
	cmp r0, #0x0
	bne later
	mov r0, #0x80
	lsl r0, r0, #0x7
	and r0, r1
	cmp r0, #0x0
	bne later2
	mov r0, #0x2
	and r0, r1
	cmp r0, #0x0
	beq one
later2:	mov r0, #0x85
	lsl r0, r0, #0x1
	b return2
later:	mov r0, #0x95
	lsl r0, r0, #0x1
	b return2
one:	mov r0, #0x8
	and r1, r0
	cmp r1, #0x0
	beq wild
	ldr r2, table
	ldr r2, [r2, #0x0]
	ldr r0, ramoffset
	ldrh r1, [r0, #0x0]
	lsl r0, r1, #0x2
	add r0, r0, r1
	lsl r0, r0, #0x3
	add r0, r0, r2
	ldrb r0, [r0, #0x1]
	cmp r0, #0x54
	beq gym
        cmp r0, #0x57
        beq gym
        cmp r0, #0x5A
        beq champ
normal:	push {r2,r3}
	ldr r3, terminate
	ldr r1, classtable
loop:	ldrh r2, [r1, #0x0]
	cmp r2, r0
	beq loadmusic
	cmp r2, r3
	beq carryon
	add r1, #0x4
	b loop
carryon:	mov r0, #0x2
	pop {r2,r3}
	b return
loadmusic:	ldrh r0, [r1, #0x2]
	pop {r2,r3}
	b return2
wild:	ldr r0, there
	ldr r0, [r0, #0x0]
	mov r1, #0x1
	and r0, r1
	cmp r0, #0x0
	bne alternate
	mov r0, #0x0
	b return
alternate:	mov r0, #0x1
	b return
gym:	mov r0, #0x3
	b return
champ:	mov r0, #0x4
return:	push {r2-r7}
	mov r11, r0
	ldr r0, variable
	bl vardecrypt
	ldrh r0, [r0, #0x0]
	mov r1, #0xA
	mul r0, r1
	ldr r1, normaltable
	add r0, r0, r1
	mov r1, r11
	lsl r1, r1, #0x1
        add r0, r0, r1
	ldrh r0, [r0, #0x0]
	mov r1, #0x0
	mov r11, r1
	pop {r2-r7}
return2:	pop {r1}
	bx r1
vardecrypt:	ldr r1, vardec
	bx r1
.align
table:		.word 0x08044028
there:		.word 0x02022B4C
ramoffset:	.word 0x020386AE
terminate:	.word 0x0000FEFE
classtable:	.word 0x0888A340
normaltable:	.word 0x0888A380
vardec:		.word 0x0806E455
variable:	.word 0x000040F6