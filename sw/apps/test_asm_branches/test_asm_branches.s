
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


    jal   x4,target0
    sw    x2,0(x1)
    j     t0
target0:
    sw    x3,0(x1)
t0:
    sw    x4,4(x1)
    jal   x5,target1
    sw    x2,8(x1)
    j     t1
target1:
    sw    x3,8(x1)
t1:
    sw    x5,12(x1)
    jal   x6,target2
    sw    x2,16(x1)
    j     t2
target2:
    sw    x3,16(x1)
t2:
    sw    x6,20(x1)
    jal   x7,target3
    sw    x2,24(x1)
    j     t3
target3:
    sw    x3,24(x1)
t3:
    sw    x7,28(x1)
    jal   x8,target4
    sw    x2,32(x1)
    j     t4
target4:
    sw    x3,32(x1)
t4:
    sw    x8,36(x1)
    jal   x9,target5
    sw    x2,40(x1)
    j     t5
target5:
    sw    x3,40(x1)
t5:
    sw    x9,44(x1)
    jal   x10,target6
    sw    x2,48(x1)
    j     t6
target6:
    sw    x3,48(x1)
t6:
    sw    x10,52(x1)
    jal   x11,target7
    sw    x2,56(x1)
    j     t7
target7:
    sw    x3,56(x1)
t7:
    sw    x11,60(x1)
    jal   x12,target8
    sw    x2,64(x1)
    j     t8
target8:
    sw    x3,64(x1)
t8:
    sw    x12,68(x1)
    jal   x13,target9
    sw    x2,72(x1)
    j     t9
target9:
    sw    x3,72(x1)
t9:
    sw    x13,76(x1)
    jal   x14,target10
    sw    x2,80(x1)
    j     t10
target10:
    sw    x3,80(x1)
t10:
    sw    x14,84(x1)
    jal   x15,target11
    sw    x2,88(x1)
    j     t11
target11:
    sw    x3,88(x1)
t11:
    sw    x15,92(x1)
    jal   x16,target12
    sw    x2,96(x1)
    j     t12
target12:
    sw    x3,96(x1)
t12:
    sw    x16,100(x1)
    jal   x17,target13
    sw    x2,104(x1)
    j     t13
target13:
    sw    x3,104(x1)
t13:
    sw    x17,108(x1)
    jal   x18,target14
    sw    x2,112(x1)
    j     t14
target14:
    sw    x3,112(x1)
t14:
    sw    x18,116(x1)
    jal   x19,target15
    sw    x2,120(x1)
    j     t15
target15:
    sw    x3,120(x1)
t15:
    sw    x19,124(x1)
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


    li       x4,816
    jalr   x4,0(x4)
    sw    x2,128(x1)
    j     t16
target16:
    sw    x3,128(x1)
t16:
    sw    x4,132(x1)
    li       x4,840
    jalr   x5,0(x4)
    sw    x2,136(x1)
    j     t17
target17:
    sw    x3,136(x1)
t17:
    sw    x5,140(x1)
    li       x4,864
    jalr   x6,0(x4)
    sw    x2,144(x1)
    j     t18
target18:
    sw    x3,144(x1)
t18:
    sw    x6,148(x1)
    li       x4,888
    jalr   x7,0(x4)
    sw    x2,152(x1)
    j     t19
target19:
    sw    x3,152(x1)
t19:
    sw    x7,156(x1)
    li       x4,912
    jalr   x8,0(x4)
    sw    x2,160(x1)
    j     t20
target20:
    sw    x3,160(x1)
t20:
    sw    x8,164(x1)
    li       x4,936
    jalr   x9,0(x4)
    sw    x2,168(x1)
    j     t21
target21:
    sw    x3,168(x1)
t21:
    sw    x9,172(x1)
    li       x4,960
    jalr   x10,0(x4)
    sw    x2,176(x1)
    j     t22
target22:
    sw    x3,176(x1)
t22:
    sw    x10,180(x1)
    li       x4,984
    jalr   x11,0(x4)
    sw    x2,184(x1)
    j     t23
target23:
    sw    x3,184(x1)
t23:
    sw    x11,188(x1)
    li       x4,1008
    jalr   x12,0(x4)
    sw    x2,192(x1)
    j     t24
target24:
    sw    x3,192(x1)
t24:
    sw    x12,196(x1)
    li       x4,1032
    jalr   x13,0(x4)
    sw    x2,200(x1)
    j     t25
target25:
    sw    x3,200(x1)
t25:
    sw    x13,204(x1)
    li       x4,1056
    jalr   x14,0(x4)
    sw    x2,208(x1)
    j     t26
target26:
    sw    x3,208(x1)
t26:
    sw    x14,212(x1)
    li       x4,1080
    jalr   x15,0(x4)
    sw    x2,216(x1)
    j     t27
target27:
    sw    x3,216(x1)
t27:
    sw    x15,220(x1)
    li       x4,1104
    jalr   x16,0(x4)
    sw    x2,224(x1)
    j     t28
target28:
    sw    x3,224(x1)
t28:
    sw    x16,228(x1)
    li       x4,1128
    jalr   x17,0(x4)
    sw    x2,232(x1)
    j     t29
target29:
    sw    x3,232(x1)
t29:
    sw    x17,236(x1)
    li       x4,1152
    jalr   x18,0(x4)
    sw    x2,240(x1)
    j     t30
target30:
    sw    x3,240(x1)
t30:
    sw    x18,244(x1)
    li       x4,1176
    jalr   x19,0(x4)
    sw    x2,248(x1)
    j     t31
target31:
    sw    x3,248(x1)
t31:
    sw    x19,252(x1)
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


    beq   x2,x3,target32
    sw    x3,256(x1)
    j     t32
target32:
    sw    x2,256(x1)
t32:
    beq   x3,x4,target33
    sw    x3,260(x1)
    j     t33
target33:
    sw    x2,260(x1)
t33:
    beq   x4,x5,target34
    sw    x3,264(x1)
    j     t34
target34:
    sw    x2,264(x1)
t34:
    beq   x5,x6,target35
    sw    x3,268(x1)
    j     t35
target35:
    sw    x2,268(x1)
t35:
    beq   x6,x7,target36
    sw    x3,272(x1)
    j     t36
target36:
    sw    x2,272(x1)
t36:
    beq   x7,x8,target37
    sw    x2,276(x1)
    j     t37
target37:
    sw    x3,276(x1)
t37:
    beq   x8,x9,target38
    sw    x3,280(x1)
    j     t38
target38:
    sw    x2,280(x1)
t38:
    beq   x9,x10,target39
    sw    x3,284(x1)
    j     t39
target39:
    sw    x2,284(x1)
t39:
    beq   x10,x11,target40
    sw    x3,288(x1)
    j     t40
target40:
    sw    x2,288(x1)
t40:
    beq   x11,x12,target41
    sw    x3,292(x1)
    j     t41
target41:
    sw    x2,292(x1)
t41:
    beq   x12,x13,target42
    sw    x3,296(x1)
    j     t42
target42:
    sw    x2,296(x1)
t42:
    beq   x13,x14,target43
    sw    x3,300(x1)
    j     t43
target43:
    sw    x2,300(x1)
t43:
    beq   x14,x15,target44
    sw    x3,304(x1)
    j     t44
target44:
    sw    x2,304(x1)
t44:
    beq   x15,x16,target45
    sw    x3,308(x1)
    j     t45
target45:
    sw    x2,308(x1)
t45:
    beq   x16,x17,target46
    sw    x3,312(x1)
    j     t46
target46:
    sw    x2,312(x1)
t46:
    beq   x17,x18,target47
    sw    x3,316(x1)
    j     t47
target47:
    sw    x2,316(x1)
t47:
    beq   x18,x19,target48
    sw    x3,320(x1)
    j     t48
target48:
    sw    x2,320(x1)
t48:
    beq   x19,x20,target49
    sw    x3,324(x1)
    j     t49
target49:
    sw    x2,324(x1)
t49:
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


    blt   x2,x3,target50
    sw    x2,328(x1)
    j     t50
target50:
    sw    x3,328(x1)
t50:
    blt   x3,x4,target51
    sw    x2,332(x1)
    j     t51
target51:
    sw    x3,332(x1)
t51:
    blt   x4,x5,target52
    sw    x3,336(x1)
    j     t52
target52:
    sw    x2,336(x1)
t52:
    blt   x5,x6,target53
    sw    x3,340(x1)
    j     t53
target53:
    sw    x2,340(x1)
t53:
    blt   x6,x7,target54
    sw    x2,344(x1)
    j     t54
target54:
    sw    x3,344(x1)
t54:
    blt   x7,x8,target55
    sw    x3,348(x1)
    j     t55
target55:
    sw    x2,348(x1)
t55:
    blt   x8,x9,target56
    sw    x2,352(x1)
    j     t56
target56:
    sw    x3,352(x1)
t56:
    blt   x9,x10,target57
    sw    x2,356(x1)
    j     t57
target57:
    sw    x3,356(x1)
t57:
    blt   x10,x11,target58
    sw    x3,360(x1)
    j     t58
target58:
    sw    x2,360(x1)
t58:
    blt   x11,x12,target59
    sw    x3,364(x1)
    j     t59
target59:
    sw    x2,364(x1)
t59:
    blt   x12,x13,target60
    sw    x2,368(x1)
    j     t60
target60:
    sw    x3,368(x1)
t60:
    blt   x13,x14,target61
    sw    x3,372(x1)
    j     t61
target61:
    sw    x2,372(x1)
t61:
    blt   x14,x15,target62
    sw    x3,376(x1)
    j     t62
target62:
    sw    x2,376(x1)
t62:
    blt   x15,x16,target63
    sw    x2,380(x1)
    j     t63
target63:
    sw    x3,380(x1)
t63:
    blt   x16,x17,target64
    sw    x3,384(x1)
    j     t64
target64:
    sw    x2,384(x1)
t64:
    blt   x17,x18,target65
    sw    x2,388(x1)
    j     t65
target65:
    sw    x3,388(x1)
t65:
    blt   x18,x19,target66
    sw    x3,392(x1)
    j     t66
target66:
    sw    x2,392(x1)
t66:
    blt   x19,x20,target67
    sw    x3,396(x1)
    j     t67
target67:
    sw    x2,396(x1)
t67:
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


    bge   x2,x3,target68
    sw    x3,400(x1)
    j     t68
target68:
    sw    x2,400(x1)
t68:
    bge   x3,x4,target69
    sw    x3,404(x1)
    j     t69
target69:
    sw    x2,404(x1)
t69:
    bge   x4,x5,target70
    sw    x2,408(x1)
    j     t70
target70:
    sw    x3,408(x1)
t70:
    bge   x5,x6,target71
    sw    x2,412(x1)
    j     t71
target71:
    sw    x3,412(x1)
t71:
    bge   x6,x7,target72
    sw    x3,416(x1)
    j     t72
target72:
    sw    x2,416(x1)
t72:
    bge   x7,x8,target73
    sw    x2,420(x1)
    j     t73
target73:
    sw    x3,420(x1)
t73:
    bge   x8,x9,target74
    sw    x3,424(x1)
    j     t74
target74:
    sw    x2,424(x1)
t74:
    bge   x9,x10,target75
    sw    x3,428(x1)
    j     t75
target75:
    sw    x2,428(x1)
t75:
    bge   x10,x11,target76
    sw    x2,432(x1)
    j     t76
target76:
    sw    x3,432(x1)
t76:
    bge   x11,x12,target77
    sw    x2,436(x1)
    j     t77
target77:
    sw    x3,436(x1)
t77:
    bge   x12,x13,target78
    sw    x3,440(x1)
    j     t78
target78:
    sw    x2,440(x1)
t78:
    bge   x13,x14,target79
    sw    x2,444(x1)
    j     t79
target79:
    sw    x3,444(x1)
t79:
    bge   x14,x15,target80
    sw    x2,448(x1)
    j     t80
target80:
    sw    x3,448(x1)
t80:
    bge   x15,x16,target81
    sw    x3,452(x1)
    j     t81
target81:
    sw    x2,452(x1)
t81:
    bge   x16,x17,target82
    sw    x2,456(x1)
    j     t82
target82:
    sw    x3,456(x1)
t82:
    bge   x17,x18,target83
    sw    x3,460(x1)
    j     t83
target83:
    sw    x2,460(x1)
t83:
    bge   x18,x19,target84
    sw    x2,464(x1)
    j     t84
target84:
    sw    x3,464(x1)
t84:
    bge   x19,x20,target85
    sw    x2,468(x1)
    j     t85
target85:
    sw    x3,468(x1)
t85:
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


    bltu   x2,x3,target86
    sw    x2,472(x1)
    j     t86
target86:
    sw    x3,472(x1)
t86:
    bltu   x3,x4,target87
    sw    x2,476(x1)
    j     t87
target87:
    sw    x3,476(x1)
t87:
    bltu   x4,x5,target88
    sw    x2,480(x1)
    j     t88
target88:
    sw    x3,480(x1)
t88:
    bltu   x5,x6,target89
    sw    x3,484(x1)
    j     t89
target89:
    sw    x2,484(x1)
t89:
    bltu   x6,x7,target90
    sw    x2,488(x1)
    j     t90
target90:
    sw    x3,488(x1)
t90:
    bltu   x7,x8,target91
    sw    x3,492(x1)
    j     t91
target91:
    sw    x2,492(x1)
t91:
    bltu   x8,x9,target92
    sw    x3,496(x1)
    j     t92
target92:
    sw    x2,496(x1)
t92:
    bltu   x9,x10,target93
    sw    x2,500(x1)
    j     t93
target93:
    sw    x3,500(x1)
t93:
    bltu   x10,x11,target94
    sw    x3,504(x1)
    j     t94
target94:
    sw    x2,504(x1)
t94:
    bltu   x11,x12,target95
    sw    x2,508(x1)
    j     t95
target95:
    sw    x3,508(x1)
t95:
    bltu   x12,x13,target96
    sw    x3,512(x1)
    j     t96
target96:
    sw    x2,512(x1)
t96:
    bltu   x13,x14,target97
    sw    x3,516(x1)
    j     t97
target97:
    sw    x2,516(x1)
t97:
    bltu   x14,x15,target98
    sw    x3,520(x1)
    j     t98
target98:
    sw    x2,520(x1)
t98:
    bltu   x15,x16,target99
    sw    x2,524(x1)
    j     t99
target99:
    sw    x3,524(x1)
t99:
    bltu   x16,x17,target100
    sw    x3,528(x1)
    j     t100
target100:
    sw    x2,528(x1)
t100:
    bltu   x17,x18,target101
    sw    x2,532(x1)
    j     t101
target101:
    sw    x3,532(x1)
t101:
    bltu   x18,x19,target102
    sw    x3,536(x1)
    j     t102
target102:
    sw    x2,536(x1)
t102:
    bltu   x19,x20,target103
    sw    x3,540(x1)
    j     t103
target103:
    sw    x2,540(x1)
t103:
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


    bgeu   x2,x3,target104
    sw    x3,544(x1)
    j     t104
target104:
    sw    x2,544(x1)
t104:
    bgeu   x3,x4,target105
    sw    x3,548(x1)
    j     t105
target105:
    sw    x2,548(x1)
t105:
    bgeu   x4,x5,target106
    sw    x3,552(x1)
    j     t106
target106:
    sw    x2,552(x1)
t106:
    bgeu   x5,x6,target107
    sw    x2,556(x1)
    j     t107
target107:
    sw    x3,556(x1)
t107:
    bgeu   x6,x7,target108
    sw    x3,560(x1)
    j     t108
target108:
    sw    x2,560(x1)
t108:
    bgeu   x7,x8,target109
    sw    x2,564(x1)
    j     t109
target109:
    sw    x3,564(x1)
t109:
    bgeu   x8,x9,target110
    sw    x2,568(x1)
    j     t110
target110:
    sw    x3,568(x1)
t110:
    bgeu   x9,x10,target111
    sw    x3,572(x1)
    j     t111
target111:
    sw    x2,572(x1)
t111:
    bgeu   x10,x11,target112
    sw    x2,576(x1)
    j     t112
target112:
    sw    x3,576(x1)
t112:
    bgeu   x11,x12,target113
    sw    x3,580(x1)
    j     t113
target113:
    sw    x2,580(x1)
t113:
    bgeu   x12,x13,target114
    sw    x2,584(x1)
    j     t114
target114:
    sw    x3,584(x1)
t114:
    bgeu   x13,x14,target115
    sw    x2,588(x1)
    j     t115
target115:
    sw    x3,588(x1)
t115:
    bgeu   x14,x15,target116
    sw    x2,592(x1)
    j     t116
target116:
    sw    x3,592(x1)
t116:
    bgeu   x15,x16,target117
    sw    x3,596(x1)
    j     t117
target117:
    sw    x2,596(x1)
t117:
    bgeu   x16,x17,target118
    sw    x2,600(x1)
    j     t118
target118:
    sw    x3,600(x1)
t118:
    bgeu   x17,x18,target119
    sw    x3,604(x1)
    j     t119
target119:
    sw    x2,604(x1)
t119:
    bgeu   x18,x19,target120
    sw    x2,608(x1)
    j     t120
target120:
    sw    x3,608(x1)
t120:
    bgeu   x19,x20,target121
    sw    x2,612(x1)
    j     t121
target121:
    sw    x3,612(x1)
t121:
stop: j stop