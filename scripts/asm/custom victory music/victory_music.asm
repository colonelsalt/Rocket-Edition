.thumb
.align 2

main:
    lsl r0, r1, #2
    add r0, r1
    lsl r0, #3
    add r0, r2
    ldrb r0, [r0, #1]

    mov r1, r0
    push {r1-r3}
    bl search
    pop {r1-r3}
    cmp r0, #0
    bne play_custom

    mov r0, r1
    ldr r1, =(0x0801570E + 1)
    bx r1

play_custom:
    ldr r1, =(0x080722A0 + 1)
    bl linker
    ldr r1, =(0x0801576E + 1)
    bx r1

linker:
    bx r1

search:
    ldr r3, =0xFEFE

    ldr r2, victory_table

search_loop:
    ldrh r1, [r2]
    cmp r1, r3
    beq search_return_none

    cmp r1, r0
    beq search_found

    add r2, #4
    b search_loop

search_return_none:
    mov r0, #0
    b search_return

search_found:
    ldrh r0, [r2, #2]

search_return:
    bx lr

.align 2
victory_table: .word 0x0888A4E0