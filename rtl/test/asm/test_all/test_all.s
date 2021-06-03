##          Test of the RV32M Standard Extension Instructions

            # li  x5,1
            # slli x5,x5,31
            # addi x5,x5,2
            # li  x4,2
            # mul   x6,x5,x4  #OK It uses Booth's Multiplication whose algorithm is quite long.

            # # MULH, MULHU, and MULHSU perform the same multiplication but return the upper XLEN bits of the full 2 × XLEN-bit product
           
            # mulh   x6,x5,x4 #OK    rs1 -> signed   , rs2 -> signed. 
            # mulhu   x6,x5,x4 #OK   rs1 -> unsigned , rs2 -> unsigned. 
            # mulhsu   x6,x4,x5 #OK  rs1 -> signed   , rs2 -> unsigned. 



            # li  x2,-11
            # li  x1,2
 
            # div  x3,x2,x1 #OK  Division Algorithm to be understood. Signed division returns quotient absolute value.
            # divu x3,x2,x1 #OK
            # rem  x4,x2,x1 #OK
            # remu  x4,x2,x1 #OK

##          Test of the RV32I Standard Extension Instructions

            #lui  x5,1         # rd = (imm[31:12] << 12 ) & (others 0) OK
            #auipc x4,0x000F   # rd = pc + sign_ext(imm[31:12] << 12 ) TO CHECK. Immediate in 2's complement instead of sign extension.
            #fence  #TO CHECK 
            #ecall  #TO CHECK 
            #ebreak #TO CHECK 
            #nop     #OK



            #li  x3,6 #OK
            #li  x2,3 #OK
            #add x3,x1,x2 #OK
            #sub x4,x2,x3 #OK
            #addi x3,x3,20 #OK


            #li x3,-1 #OK
            #li x5,0 #OK 
            #li x4,2 #OK
            #slt   x5,x3,x4  #OK
            #sltu  x5,x3,x4  #OK
            #slti  x5,x3,10  #OK
            #sltiu  x5,x3,10 #OK

            li x1,0
            lw x5,1024(x1)   #TO CHECK
            # sw x5,1028(x1) #TO CHECK
            # lh x5,1032(x1) #TO CHECK
            # sh x5,1034(x1)  #TO CHECK
            # lhu x5,1036(x1) #TO CHECK
            # lb x5,1040(x1) #TO CHECK
            # lbu x5,1044(x1) #TO CHECK            
            # sb x5,1048(x1) #TO CHECK


            # li x1,21
            # li x6,0x00FF #OK
            # and x3,x6,x1  #OK
            # or x3,x6,x1 #OK
            # xor x3,x6,x1 #OK
            # andi x3,x6,0x088 #OK
            # ori  x3,x6,0x0FF #OK
            # xori x3,x6,0x0FF #OK
            #li x1,2
            #li x2,0x00FF
            # sll x3,x2,x1 #OK
            # srl x3,x2,x1 #OK
            # sra x3,x2,x1 #OK
            # slli x3,x2,8  #OK
            # srli x3,x2,8 #OK
            # srai x3,x2,8 #OK
#            li x1,3
#             li x2,3
#             beq  x1,x2,target #OK 
#             li x4,1
#             li x5,2
# target1:
#             bne  x1,x2,target2 #OK
#             li x4,3
#             li x5,4
# target2:
#             blt  x1,x2,target3 #OK
#             li x4,5
#             li x5,6
# target3:
#             bge  x1,x2,target4 #OK
#             li x4,7
#             li x5,8
# target4:
#             bltu x1,x2,target5 #OK
#             li x4,9
#             li x5,10
# target5:
#             bgeu x1,x2,target6 #OK
#             li x4,11
#             li x5,12
# target6:
#             jal x1,target7 #OK
#             li x4,13
#             li x5,14
# target7:
#             li x2,4
#             jalr x1,0(x2) #OK
#             li x4,15
#             li x5,16
