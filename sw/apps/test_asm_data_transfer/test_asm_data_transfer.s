
    .text
    .globl	main
    .type	main, @function
main:
     lui x1,0x100
    li x2,0x0
    li x3,0x1
    li x4,0x2
    li x5,-0x1
    li x6,-0x2
    li x7,-0x1
    li x8,-0x1
    lui  x9,0x7f8
    addi x9,x9,0x7f8
    lui  x10,0x7ff
    addi x10,x10,0x7ff
    lui  x11,0x70f
    addi x11,x11,0x70f
    li x12,-0x64
    li x13,0x64
    li x14,0x31
    li x15,0x7
    li x16,0x22
    li x17,0x15
    li x18,0xff
    li x19,0x11
    li x20,0xc
    li x21,0x80
    li x22,0x14
    li x23,0x3ff
    li x24,0x5
    li x25,0x3ff


    sw    x2,0(x1)
    addi  x1,x1,4
    sw    x3,0(x1)
    addi  x1,x1,4
    sw    x4 ,0(x1)
    addi  x1,x1,4
    sw    x5,0(x1)
    addi  x1,x1,4
    sw    x6,0(x1)
    addi  x1,x1,4
    sb    x7,0(x1)
    addi  x1,x1,4
    sh    x8,0(x1)
    addi  x1,x1,4


    li   x24,28
    sub  x1,x1,x24


    lw    x9,0(x1)
    addi  x1,x1,4
    lh    x10,0(x1)
    addi  x1,x1,4
    lhu   x11,0(x1)
    addi  x1,x1,4
    lb    x12,0(x1)
    addi  x1,x1,4
    lbu   x13,0(x1)
    addi  x1,x1,4
    lw   x14,0(x1)
    addi  x1,x1,4
    lw   x15,0(x1)
    addi  x1,x1,4


    sw    x9,0(x1)
    addi  x1,x1,4
    sw    x10,0(x1)
    addi  x1,x1,4
    sw    x11 ,0(x1)
    addi  x1,x1,4
    sw    x12,0(x1)
    addi  x1,x1,4
    sw    x13,0(x1)
    addi  x1,x1,4
    sw    x14,0(x1)
    addi  x1,x1,4
    sw    x15,0(x1)
    addi  x1,x1,4
stop: j stop