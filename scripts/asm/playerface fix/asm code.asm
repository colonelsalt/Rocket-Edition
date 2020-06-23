.text 
.align 2 
.thumb 
.thumb_func 
.global trainerface 

main: 
push {r0-r3, lr} 
ldr r0, ramlocation 
ldrb r0, [r0, #0x0] 
mov r1, #0x24 
mul r0, r1 
ldr r1, spritebank 
add r0, r0, r1 
ldrh r2, [r0, #0x10] 
ldrh r3, [r1, #0x10] 
cmp r2, r3 
beq checkvertical 
sub r2, r2, r3 
cmp r2, #0x1 
beq right 
mov r0, #0x2 
b store 
right:	mov r0, #0x3 
b store 
checkvertical:	ldrh r2, [r0, #0x12] 
ldrh r3, [r1, #0x12] 
sub r2, r2, r3 
cmp r2, #0x1 
beq alt 
mov r0, #0x1 
b store 
alt:	mov r0, #0x0 
store:	ldr r1, lastresult 
strh r0, [r1, #0x0] 
pop {r0-r3, pc} 
.align 
ramlocation:	.word 0x03005074 
spritebank:	.word 0x02036E38 
lastresult:	.word 0x020370D0