# **************************************************************************************
#  Filename: crt0.boot_MU_test_csr.S  #
#  Project:  CNL_RISC-V
#  Version:  1.0
#  Date:     25 March, 2022  #
#
# Copyright (C) 2022 CINI Cybersecurity National Laboratory and University of Teheran
#
# This source file may be used and distributed without
# restriction provided that this copyright statement is not
# removed from the file and that any derivative work contains
# the original copyright notice and the associated disclaimer.
#
# This source file is free software; you can redistribute it
# and/or modify it under the terms of the GNU Lesser General
# Public License as published by the Free Software Foundation;
# either version 3.0 of the License, or (at your option) any
# later version.
#
# This source is distributed in the hope that it will be
# useful, but WITHOUT ANY WARRANTY; without even the implied
# warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
# PURPOSE. See the GNU Lesser General Public License for more
# details.
#
# You should have received a copy of the GNU Lesser General
# Public License along with this source; if not, download it
# from https://www.gnu.org/licenses/lgpl-3.0.txt
#
# **************************************************************************************
#
#  File content description:
#  Machine-User bootloader customized for Control and Status Registers test.  #
#
# **************************************************************************************


#define EXCEPTION_STACK_SIZE 72

/* ========================================================= [ entry ] === */
  .section .text
reset_handler:

  /* set all registers to zero */
  mv  x1, x0
  mv  x2, x1
  mv  x3, x1
  mv  x4, x1
  mv  x5, x1
  mv  x6, x1
  mv  x7, x1
  mv  x8, x1
  mv  x9, x1
  mv x10, x1
  mv x11, x1
  mv x12, x1
  mv x13, x1
  mv x14, x1
  mv x15, x1
  mv x16, x1
  mv x17, x1
  mv x18, x1
  mv x19, x1
  mv x20, x1
  mv x21, x1
  mv x22, x1
  mv x23, x1
  mv x24, x1
  mv x25, x1
  mv x26, x1
  mv x27, x1
  mv x28, x1
  mv x29, x1
  mv x30, x1
  mv x31, x1

  /* stack initilization */
  la   x2, _stack_start

_start:
  .global _start

  /* clear BSS */
  la x26, _bss_start
  la x27, _bss_end

  bge x26, x27, zero_loop_end

zero_loop:
  sw x0, 0(x26)
  addi x26, x26, 4
  ble x26, x27, zero_loop
zero_loop_end:

main_entry:
  /* jump to main program entry point (argc = argv = 0) */
  addi x10, x0, 0
  addi x11, x0, 0
    ## Testing CSRs
  li  x8,1                            # To confirm environment call has been taken 
  jal x1, test_csr
  ##
  la x6, main
  la x1, _end
  addi x7, x0, 3
  slli x7, x7, 11
  csrrw x0, mepc, x6
  csrrc x7, mstatus, x7
  addi x6, x0, 0
  addi x7, x0, 0
  mret

_end:
  /* when returning from main, infinite loop here */
  jal x0, _end


#### TEST
test_csr:
   mv x23,x1
   lui x18,0x100
    li x20, -1
    li x21, 100
    li x22, 0xFF
    csrrci  x19,mstatus,0
    jal     x1, set_regs
    csrrw   x4,mstatus,x5
    csrrw   x5,mstatus,x6
    sw      x5,0(x18)
    csrrw   x6,mstatus,x7
    sw      x6,4(x18)
    jal     x1, set_regs
    csrrw   x0,mstatus,x5
    csrrw   x4,mstatus,x5
    csrrw   x0,mstatus,x6
    csrrw   x5,mstatus,x6
    sw      x6,8(x18)
    csrrw   x0,mstatus,x7
    csrrw   x6,mstatus,x7
    sw      x7,12(x18)
    csrrw   x0,mstatus,x19
    jal     x1, set_regs
    csrrw   x4,mtvec,x5
    csrrw   x5,mtvec,x6
    li      x5,0x401
    sw      x5,16(x18)
    csrrw   x6,mtvec,x7
    li      x6,0x401
    sw      x6,20(x18)
    jal     x1, set_regs
    csrrw   x0,mtvec,x5
    csrrw   x4,mtvec,x5
    csrrw   x0,mtvec,x6
    csrrw   x5,mtvec,x6
    li      x6,0x401
    sw      x6,24(x18)
    csrrw   x0,mtvec,x7
    csrrw   x6,mtvec,x7
    li      x7,0x401
    sw      x7,28(x18)
    jal     x1, set_regs
    csrrw   x4,mcause,x5
    csrrw   x5,mcause,x6
    sw      x5,32(x18)
    csrrw   x6,mcause,x7
    sw      x6,36(x18)
    jal     x1, set_regs
    csrrw   x0,mcause,x5
    csrrw   x4,mcause,x5
    csrrw   x0,mcause,x6
    csrrw   x5,mcause,x6
    sw      x6,40(x18)
    csrrw   x0,mcause,x7
    csrrw   x6,mcause,x7
    sw      x7,44(x18)
    jal     x1, set_regs
    csrrw   x4,mepc,x5
    csrrw   x5,mepc,x6
    sw      x5,48(x18)
    csrrw   x6,mepc,x7
    sw      x6,52(x18)
    jal     x1, set_regs
    csrrw   x0,mepc,x5
    csrrw   x4,mepc,x5
    csrrw   x0,mepc,x6
    csrrw   x5,mepc,x6
    sw      x6,56(x18)
    csrrw   x0,mepc,x7
    csrrw   x6,mepc,x7
    sw      x7,60(x18)
    jal     x1, set_regs
    csrrw   x4,0xC10,x5
    sw      x9,64(x18)
    li      x9,0
    csrrw   x5,0xC10,x6
    sw      x9,68(x18)
    li      x9,0
    csrrw   x6,0xC10,x7
    sw      x9,72(x18)
    li      x9,0
    jal     x1, set_regs
    csrrw   x4,0xC10,x5
    sw      x9,76(x18)
    li      x9,0
    csrrw   x5,0xC10,x6
    sw      x9,80(x18)
    li      x9,0
    csrrw   x6,0xC10,x7
    sw      x9,84(x18)
    li      x9,0
    csrrci  x19,mstatus,0
    jal     x1, set_regs
    csrrc   x4,mstatus,x5
    csrrc   x5,mstatus,x6
    sw      x5,88(x18)
    csrrc   x6,mstatus,x7
    sw      x6,92(x18)
    jal     x1, set_regs
    csrrw   x0,mstatus,x21
    csrrc   x4,mstatus,x0
    csrrc   x5,mstatus,x0
    sw      x5,96(x18)
    csrrc   x6,mstatus,x0
    sw      x6,100(x18)
    csrrw   x0,mstatus,x19
    jal     x1, set_regs
    csrrc   x4,mtvec,x5
    csrrc   x5,mtvec,x6
    li      x5,0x401
    sw      x5,104(x18)
    csrrc   x6,mtvec,x7
    li      x6,0x401
    sw      x6,108(x18)
    jal     x1, set_regs
    csrrw   x0,mtvec,x21
    csrrc   x4,mtvec,x0
    csrrc   x5,mtvec,x0
    li      x5,0x401
    sw      x5,112(x18)
    csrrc   x6,mtvec,x0
    li      x6,0x401
    sw      x6,116(x18)
    jal     x1, set_regs
    csrrc   x4,mcause,x5
    csrrc   x5,mcause,x6
    sw      x5,120(x18)
    csrrc   x6,mcause,x7
    sw      x6,124(x18)
    jal     x1, set_regs
    csrrw   x0,mcause,x21
    csrrc   x4,mcause,x0
    csrrc   x5,mcause,x0
    sw      x5,128(x18)
    csrrc   x6,mcause,x0
    sw      x6,132(x18)
    jal     x1, set_regs
    csrrc   x4,mepc,x5
    csrrc   x5,mepc,x6
    sw      x5,136(x18)
    csrrc   x6,mepc,x7
    sw      x6,140(x18)
    jal     x1, set_regs
    csrrw   x0,mepc,x21
    csrrc   x4,mepc,x0
    csrrc   x5,mepc,x0
    sw      x5,144(x18)
    csrrc   x6,mepc,x0
    sw      x6,148(x18)
    jal     x1, set_regs
    csrrc   x4,0xC10,x5
    sw      x9,152(x18)
    li      x9,0
    csrrc   x5,0xC10,x6
    sw      x9,156(x18)
    li      x9,0
    csrrc   x6,0xC10,x7
    sw      x9,160(x18)
    li      x9,0
    jal     x1, set_regs
    csrrc   x4,0xC10,x0
    csrrc   x5,0xC10,x0
    sw      x5,164(x18)
    csrrc   x6,0xC10,x0
    sw      x6,168(x18)
    csrrci  x19,mstatus,0
    jal     x1, set_regs
    csrrs   x4,mstatus,x5
    csrrs   x5,mstatus,x6
    sw      x5,172(x18)
    csrrc   x0,mstatus,x20
    csrrs   x5,mstatus,x6
    csrrs   x6,mstatus,x7
    sw      x6,176(x18)
    csrrc   x0,mstatus,x20
    csrrs   x6,mstatus,x7
    jal     x1, set_regs
    csrrw   x0,mstatus,x21
    csrrs   x4,mstatus,x0
    csrrs   x5,mstatus,x0
    sw      x5,180(x18)
    csrrs   x6,mstatus,x0
    sw      x6,184(x18)
    csrrw   x0,mstatus,x19
    jal     x1, set_regs
    csrrs   x4,mtvec,x5
    csrrs   x5,mtvec,x6
    li      x5,0x401
    sw      x5,188(x18)
    csrrc   x0,mtvec,x20
    csrrs   x5,mtvec,x6
    csrrs   x6,mtvec,x7
    li      x6,0x401
    sw      x6,192(x18)
    csrrc   x0,mtvec,x20
    csrrs   x6,mtvec,x7
    jal     x1, set_regs
    csrrw   x0,mtvec,x21
    csrrs   x4,mtvec,x0
    csrrs   x5,mtvec,x0
    li      x5,0x401
    sw      x5,196(x18)
    csrrs   x6,mtvec,x0
    li      x6,0x401
    sw      x6,200(x18)
    jal     x1, set_regs
    csrrs   x4,mcause,x5
    csrrs   x5,mcause,x6
    sw      x5,204(x18)
    csrrc   x0,mcause,x20
    csrrs   x5,mcause,x6
    csrrs   x6,mcause,x7
    sw      x6,208(x18)
    csrrc   x0,mcause,x20
    csrrs   x6,mcause,x7
    jal     x1, set_regs
    csrrw   x0,mcause,x21
    csrrs   x4,mcause,x0
    csrrs   x5,mcause,x0
    sw      x5,212(x18)
    csrrs   x6,mcause,x0
    sw      x6,216(x18)
    jal     x1, set_regs
    csrrs   x4,mepc,x5
    csrrs   x5,mepc,x6
    sw      x5,220(x18)
    csrrc   x0,mepc,x20
    csrrs   x5,mepc,x6
    csrrs   x6,mepc,x7
    sw      x6,224(x18)
    csrrc   x0,mepc,x20
    csrrs   x6,mepc,x7
    jal     x1, set_regs
    csrrw   x0,mepc,x21
    csrrs   x4,mepc,x0
    csrrs   x5,mepc,x0
    sw      x5,228(x18)
    csrrs   x6,mepc,x0
    sw      x6,232(x18)
    jal     x1, set_regs
    csrrs   x4,0xC10,x5
    sw      x9,236(x18)
    li      x9,0
    csrrs   x5,0xC10,x6
    sw      x9,240(x18)
    li      x9,0
    csrrs   x6,0xC10,x7
    sw      x9,244(x18)
    li      x9,0
    jal     x1, set_regs
    csrrs   x4,0xC10,x0
    csrrs   x5,0xC10,x0
    sw      x5,248(x18)
    csrrs   x6,0xC10,x0
    sw      x6,252(x18)
    csrrci  x19,mstatus,0
    jal     x1, set_regs
    csrrwi   x4,mstatus,2
    csrrwi   x5,mstatus,1
    sw      x5,256(x18)
    csrrwi   x6,mstatus,2
    sw      x6,260(x18)
    jal     x1, set_regs
    csrrwi   x0,mstatus,2
    csrrwi   x4,mstatus,2
    csrrwi   x5,mstatus,1
    sw      x5,264(x18)
    csrrwi   x6,mstatus,2
    sw      x6,268(x18)
    csrrw   x0,mstatus,x19
    jal     x1, set_regs
    csrrwi   x4,mtvec,2
    csrrwi   x5,mtvec,1
    li      x5,0x401
    sw      x5,272(x18)
    csrrwi   x6,mtvec,2
    li      x6,0x401
    sw      x6,276(x18)
    jal     x1, set_regs
    csrrwi   x0,mtvec,2
    csrrwi   x4,mtvec,2
    csrrwi   x5,mtvec,1
    li      x5,0x401
    sw      x5,280(x18)
    csrrwi   x6,mtvec,2
    li      x6,0x401
    sw      x6,284(x18)
    jal     x1, set_regs
    csrrwi   x4,mcause,2
    csrrwi   x5,mcause,1
    sw      x5,288(x18)
    csrrwi   x6,mcause,2
    sw      x6,292(x18)
    jal     x1, set_regs
    csrrwi   x0,mcause,2
    csrrwi   x4,mcause,2
    csrrwi   x5,mcause,1
    sw      x5,296(x18)
    csrrwi   x6,mcause,2
    sw      x6,300(x18)
    jal     x1, set_regs
    csrrwi   x4,mepc,2
    csrrwi   x5,mepc,1
    sw      x5,304(x18)
    csrrwi   x6,mepc,2
    sw      x6,308(x18)
    jal     x1, set_regs
    csrrwi   x0,mepc,2
    csrrwi   x4,mepc,2
    csrrwi   x5,mepc,1
    sw      x5,312(x18)
    csrrwi   x6,mepc,2
    sw      x6,316(x18)
    jal     x1, set_regs
    csrrwi   x4,0xC10,2
    sw      x9,320(x18)
    li      x9,0
    csrrwi   x5,0xC10,1
    sw      x9,324(x18)
    li      x9,0
    csrrwi   x6,0xC10,2
    sw      x9,328(x18)
    li      x9,0
    jal     x1, set_regs
    csrrwi   x4,0xC10,2
    sw      x9,332(x18)
    li      x9,0
    csrrwi   x5,0xC10,1
    sw      x9,336(x18)
    li      x9,0
    csrrwi   x6,0xC10,2
    sw      x9,340(x18)
    li      x9,0
    csrrci  x19,mstatus,0
    jal     x1, set_regs
    csrrw   x0,mstatus,x22
    csrrci   x4,mstatus,2
    csrrci   x5,mstatus,1
    sw      x5,344(x18)
    csrrw   x0,mstatus,x22
    csrrci   x5,mstatus,1
    csrrci   x6,mstatus,2
    sw      x6,348(x18)
    csrrw   x0,mstatus,x22
    csrrci   x6,mstatus,2
    jal     x1, set_regs
    csrrw   x0,mstatus,x21
    csrrw   x0,mstatus,x22
    csrrci   x4,mstatus,0
    csrrci   x5,mstatus,0
    sw      x5,352(x18)
    csrrw   x0,mstatus,x22
    csrrci   x5,mstatus,0
    csrrci   x6,mstatus,0
    sw      x6,356(x18)
    csrrw   x0,mstatus,x22
    csrrci   x6,mstatus,0
    csrrw   x0,mstatus,x19
    jal     x1, set_regs
    csrrw   x0,mtvec,x22
    csrrci   x4,mtvec,2
    csrrci   x5,mtvec,1
    li      x5,0x401
    sw      x5,360(x18)
    csrrw   x0,mtvec,x22
    csrrci   x5,mtvec,1
    csrrci   x6,mtvec,2
    li      x6,0x401
    sw      x6,364(x18)
    csrrw   x0,mtvec,x22
    csrrci   x6,mtvec,2
    jal     x1, set_regs
    csrrw   x0,mtvec,x21
    csrrw   x0,mtvec,x22
    csrrci   x4,mtvec,0
    csrrci   x5,mtvec,0
    li      x5,0x401
    sw      x5,368(x18)
    csrrw   x0,mtvec,x22
    csrrci   x5,mtvec,0
    csrrci   x6,mtvec,0
    li      x6,0x401
    sw      x6,372(x18)
    csrrw   x0,mtvec,x22
    csrrci   x6,mtvec,0
    jal     x1, set_regs
    csrrw   x0,mcause,x22
    csrrci   x4,mcause,2
    csrrci   x5,mcause,1
    sw      x5,376(x18)
    csrrw   x0,mcause,x22
    csrrci   x5,mcause,1
    csrrci   x6,mcause,2
    sw      x6,380(x18)
    csrrw   x0,mcause,x22
    csrrci   x6,mcause,2
    jal     x1, set_regs
    csrrw   x0,mcause,x21
    csrrw   x0,mcause,x22
    csrrci   x4,mcause,0
    csrrci   x5,mcause,0
    sw      x5,384(x18)
    csrrw   x0,mcause,x22
    csrrci   x5,mcause,0
    csrrci   x6,mcause,0
    sw      x6,388(x18)
    csrrw   x0,mcause,x22
    csrrci   x6,mcause,0
    jal     x1, set_regs
    csrrw   x0,mepc,x22
    csrrci   x4,mepc,2
    csrrci   x5,mepc,1
    sw      x5,392(x18)
    csrrw   x0,mepc,x22
    csrrci   x5,mepc,1
    csrrci   x6,mepc,2
    sw      x6,396(x18)
    csrrw   x0,mepc,x22
    csrrci   x6,mepc,2
    jal     x1, set_regs
    csrrw   x0,mepc,x21
    csrrw   x0,mepc,x22
    csrrci   x4,mepc,0
    csrrci   x5,mepc,0
    sw      x5,400(x18)
    csrrw   x0,mepc,x22
    csrrci   x5,mepc,0
    csrrci   x6,mepc,0
    sw      x6,404(x18)
    csrrw   x0,mepc,x22
    csrrci   x6,mepc,0
    jal     x1, set_regs
    csrrw   x0,0xC10,x22
    csrrci   x4,0xC10,2
    sw      x9,408(x18)
    li      x9,0
    csrrci   x5,0xC10,1
    sw      x9,412(x18)
    li      x9,0
    csrrci   x6,0xC10,2
    sw      x9,416(x18)
    li      x9,0
    jal     x1, set_regs
    csrrw   x0,0xC10,x22
    csrrci   x4,0xC10,0
    csrrci   x5,0xC10,0
    sw      x5,420(x18)
    csrrw   x0,0xC10,x22
    csrrci   x5,0xC10,0
    csrrci   x6,0xC10,0
    sw      x6,424(x18)
    csrrw   x0,0xC10,x22
    csrrci   x6,0xC10,0
    csrrci  x19,mstatus,0
    jal     x1, set_regs
    csrrc   x0,mstatus,x20
    csrrsi   x4,mstatus,2
    csrrsi   x5,mstatus,1
    sw      x5,428(x18)
    csrrc   x0,mstatus,x20
    csrrsi   x5,mstatus,1
    csrrsi   x6,mstatus,2
    sw      x6,432(x18)
    csrrc   x0,mstatus,x20
    csrrsi   x6,mstatus,2
    jal     x1, set_regs
    csrrw   x0,mstatus,x21
    csrrsi   x4,mstatus,0
    csrrsi   x5,mstatus,0
    sw      x5,436(x18)
    csrrsi   x6,mstatus,0
    sw      x6,440(x18)
    csrrw   x0,mstatus,x19
    jal     x1, set_regs
    csrrc   x0,mtvec,x20
    csrrsi   x4,mtvec,2
    csrrsi   x5,mtvec,1
    li      x5,0x401
    sw      x5,444(x18)
    csrrc   x0,mtvec,x20
    csrrsi   x5,mtvec,1
    csrrsi   x6,mtvec,2
    li      x6,0x401
    sw      x6,448(x18)
    csrrc   x0,mtvec,x20
    csrrsi   x6,mtvec,2
    jal     x1, set_regs
    csrrw   x0,mtvec,x21
    csrrsi   x4,mtvec,0
    csrrsi   x5,mtvec,0
    li      x5,0x401
    sw      x5,452(x18)
    csrrsi   x6,mtvec,0
    li      x6,0x401
    sw      x6,456(x18)
    jal     x1, set_regs
    csrrc   x0,mcause,x20
    csrrsi   x4,mcause,2
    csrrsi   x5,mcause,1
    sw      x5,460(x18)
    csrrc   x0,mcause,x20
    csrrsi   x5,mcause,1
    csrrsi   x6,mcause,2
    sw      x6,464(x18)
    csrrc   x0,mcause,x20
    csrrsi   x6,mcause,2
    jal     x1, set_regs
    csrrw   x0,mcause,x21
    csrrsi   x4,mcause,0
    csrrsi   x5,mcause,0
    sw      x5,468(x18)
    csrrsi   x6,mcause,0
    sw      x6,472(x18)
    jal     x1, set_regs
    csrrc   x0,mepc,x20
    csrrsi   x4,mepc,2
    csrrsi   x5,mepc,1
    sw      x5,476(x18)
    csrrc   x0,mepc,x20
    csrrsi   x5,mepc,1
    csrrsi   x6,mepc,2
    sw      x6,480(x18)
    csrrc   x0,mepc,x20
    csrrsi   x6,mepc,2
    jal     x1, set_regs
    csrrw   x0,mepc,x21
    csrrsi   x4,mepc,0
    csrrsi   x5,mepc,0
    sw      x5,484(x18)
    csrrsi   x6,mepc,0
    sw      x6,488(x18)
    jal     x1, set_regs
    csrrc   x0,0xC10,x20
    csrrsi   x4,0xC10,2
    sw      x9,492(x18)
    li      x9,0
    csrrsi   x5,0xC10,1
    sw      x9,496(x18)
    li      x9,0
    csrrsi   x6,0xC10,2
    sw      x9,500(x18)
    li      x9,0
    jal     x1, set_regs
    csrrsi   x4,0xC10,0
    csrrsi   x5,0xC10,0
    sw      x5,504(x18)
    csrrsi   x6,0xC10,0
    sw      x6,508(x18)
   mv x1,x23
   li x23,0
    jalr x0, x1

####





// saves all caller-saved registers (except return address)
store_regs:
  sw  x3, 0x00(x2)  // gp
  sw  x4, 0x04(x2)  // tp
  sw  x5, 0x08(x2)  // t0
  sw  x6, 0x0c(x2)  // t1
  sw  x7, 0x10(x2)  // t2
  sw x10, 0x14(x2)  // a0
  sw x11, 0x18(x2)  // a1
  sw x12, 0x1c(x2)  // a2
  sw x13, 0x20(x2)  // a3
  sw x14, 0x24(x2)  // a4
  sw x15, 0x28(x2)  // a5
  sw x16, 0x2c(x2)  // a6
  sw x17, 0x30(x2)  // a7
  sw x28, 0x34(x2)  // t3
  sw x29, 0x38(x2)  // t4
  sw x30, 0x3c(x2)  // t5
  sw x31, 0x40(x2)  // t6
  jalr x0, x1

// load back registers from stack
end_except:
  lw  x3, 0x00(x2)
  lw  x4, 0x04(x2)
  lw  x5, 0x08(x2)
  lw  x6, 0x0c(x2)
  lw  x7, 0x10(x2)
  lw x10, 0x14(x2)
  lw x11, 0x18(x2)
  lw x12, 0x1c(x2)
  lw x13, 0x20(x2)
  lw x14, 0x24(x2)
  lw x15, 0x28(x2)
  lw x16, 0x2c(x2)
  lw x17, 0x30(x2)
  lw x28, 0x34(x2)
  lw x29, 0x38(x2)
  lw x30, 0x3c(x2)
  lw x31, 0x40(x2)
  lw  x1, 0x44(x2)
  addi x2, x2, EXCEPTION_STACK_SIZE
  mret
  #j default_exc_handler


/* exception codes to be implemented with custom behavior */

/* ================================= [ instruction address misaligned handler] === */

instruction_address_misaligned_handler:
  j instruction_address_misaligned_handler
  #addi x2, x2, -EXCEPTION_STACK_SIZE
  #sw x1, 0x44(x2)
  #jal x1, store_regs
  #j end_except
  # la x1, end_except
  # jal x0, instruction_access_misaligned_handler_c

/* ================================= [ illegal instruction handler] === */

illegal_insn_handler:
  j illegal_insn_handler
  #addi x2, x2, -EXCEPTION_STACK_SIZE
  #sw x1, 0x44(x2)
  #jal x1, store_regs
  #j end_except
  # la x1, end_except
  # jal x0, illegal_insn_handler_c

/* ================================= [ ecall user instruction handler] === */
/* ecall trap will continue the main program in user mode, trap code to be implemented */

ecall_u_handler:
  addi x2, x2, -EXCEPTION_STACK_SIZE
  sw x1, 0x44(x2)
  jal x1, store_regs
  
  /* mepc+4 allows mret to continue the program after a ecall, added Luca */
  csrrsi x7, mepc, 0
  addi x7,x7,4
  csrrw x7,mepc,x7
  
  j end_except
  # la x1, end_except
  # jal x0, ecall_u_handler_c

/* ================================= [ external interrupt signal handler] === */
/* interrupt handler will resume (machine mode only) the main program, interrupt code to be implemented */

external_interrupt_signal_handler:
  addi x2, x2, -EXCEPTION_STACK_SIZE
  sw x1, 0x44(x2)
  jal x1, store_regs
  //TODO: handle interrupts here
  j end_except
  # la x1, end_except
  # jal x0, external_interrupt_signal_handler_c


default_exc_handler:  
  j default_exc_handler # To infinite loop
  
/* =================================================== [ exceptions ] === */
/* This section has to be down here, since we have to disable rvc for it  */

  .section .vectors, "ax"
  .option norvc;

  .org 0x00
  jal x0, reset_handler
  .org 0x04
  jal x0, instruction_address_misaligned_handler
  .org 0x08
  jal x0, default_exc_handler
  .org 0x0C
  jal x0, illegal_insn_handler
  .org 0x10
  .rept 5

   # Not implemented handlers are substituted with default one

  jal x0, default_exc_handler   
          # reserved[0x10]
          # load_address_misaligned_handler       [0x14] 
          # load_access_fault_handler             [0x18]
          # store_address_misaligned_handler      [0x1C]
          # store_access_fault_handler            [0x20]
  .endr
  .org 0x24
  jal x0, ecall_u_handler
  .org 0x28
  .rept 35

   # Not implemented handlers are substituted with default one

  jal x0, default_exc_handler
          # ecall_s_handler                       [0x28]
          # reserved                              [0x2C] 
          # # ecall_m_handler                     [0x30]
          # reserved                              [0x34-0x80]

          # user_software_interrupt_handler       [0x84]
          # supervisor_software_interrupt_handler [0x88]
          # reserved                              [0x8C]
          # machine_software_interrupt_handler    [0x90]

          # user_timer_interrupt_handler          [0x94]
          # supervisor_timer_interrupt_handler    [0x98]
          # reserved                              [0x9C]
          # machine_timer_interrupt_handler       [0xA0]

          # user_external_interrupt_handler       [0xA4]
          # supervisor_external_interrupt_handler [0xA8]
          # reserved                              [0xAC]
          # machine_external_interrupt_handler    [0xB0]
          
  .endr
  .org 0xB4
  jal x0, default_exc_handler
  .org 0xB8
  .rept 3

  # Not implemented handlers are substituted with default one

  jal x0, default_exc_handler
         # reserved                               [0xB8]
         # reserved                               [0xBC]
         # reserved                               [0xC0]
  .endr
  .org 0xC4
  jal x0, external_interrupt_signal_handler
  .org 0xC8
  jal x0, external_interrupt_signal_handler
  .org 0xCC
  jal x0, external_interrupt_signal_handler
  .org 0xD0
  jal x0, external_interrupt_signal_handler

  .org 0xD4
  jal x0, external_interrupt_signal_handler
  .org 0xD8
  jal x0, external_interrupt_signal_handler
  .org 0xDC
  jal x0, external_interrupt_signal_handler
  .org 0xE0
  jal x0, external_interrupt_signal_handler

  .org 0xE4
  jal x0, external_interrupt_signal_handler
  .org 0xE8
  jal x0, external_interrupt_signal_handler
  .org 0xEC
  jal x0, external_interrupt_signal_handler
  .org 0xF0
  jal x0, external_interrupt_signal_handler

  .org 0xF4
  jal x0, external_interrupt_signal_handler
  .org 0xF8
  jal x0, external_interrupt_signal_handler
  .org 0xFC
  jal x0, external_interrupt_signal_handler
  .org 0x100
  jal x0, external_interrupt_signal_handler





