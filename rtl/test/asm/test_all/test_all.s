            li	x1,1 #OK
            li  x2,2 #OK
            #add x3,x1,x2 #OK
            #sub x4,x2,x3 #OK
            #addi x3,x3,20 #OK
            #li x3,0 #OK
            #li x4,3 #OK 
            slt   x5,x3,x4  #TO CHECK
            sltu  x5,x3,x4
            slti  x5,x3,10
            sltiu  x5,x3,10
            #mul   x6,x5,x4
            #mulh   x6,x5,x4
            #mulhu   x6,x5,x4
            #li  x1,10
            #li  x2,5
            #div x3,x2,x1
            #divu x3,x2,x1
            #rem  x4,x3,x2
            #remu  x4,x3,x2
            #li x1,0
            #lw x5,0(x1)
            #sw x5,4(x1)
            #lh x5,8(x1)
            #sh x5,16(x1)
            #lb x5,20(x1)
            #sb x5,24(x1)
            #li x1,21
            #li x2,0xFFFF
            #and x3,x2,x1
            #or x3,x2,x1
            #xor x3,x2,x1
            #andi x3,x2,0x0FF
            #ori  x3,x2,0x0FF
            #xori x3,x2,0x0FF
            #li x1,2
            #li x2,0xFFFF
            #sll x3,x2,x1
            #srl x3,x2,x1
            #sra x3,x2,x1
            #slli x3,x2,8
            #srli x3,x2,8
            #srai x3,x2,8
            #beq  x2,x3,target1
target1:
            #bne  x2,x3,target2
target2:
            #blt  x2,x3,target3
target3:
            #bge  x2,x3,target4
target4:
            #bltu x2,x3,target5
target5:
            #bgeu x2,x3,target6
target6:
            #jal x1,target7
target7:
            #jalr x1,0(x2)
