# **************************************************************************************
#  Filename: crt0.boot_M.S  #
#  Project:  CNL_RISC-V
#  Version:  1.0
#  Date:     01 April, 2022  #
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
#  Bootloader for Machine-only execution  #
# 
# **************************************************************************************

#define EXCEPTION_STACK_SIZE 72

/* ========================================================= [ entry ] === */
  .section .text
reset_handler:
 
  /* added luca, MSTATUS:0x00001800,  MTVEC  :0x00000011*/
  addi x1,x0,0x180  
  slli x1,x1,4
  csrrw  x1,mstatus,x1 
  csrrwi x1,mtvec,0x11
  
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
  jal x1, main

_end:
  /* when returning from main, infinite loop here */
  jal x0, _end


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
  j default_exc_handler


/* ================================= [ instruction address misaligned handler] === */

instruction_address_misaligned_handler:
  addi x2, x2, -EXCEPTION_STACK_SIZE
  sw x1, 0x44(x2)
  jal x1, store_regs
  j end_except
  # la x1, end_except
  # jal x0, instruction_access_misaligned_handler_c

/* ================================= [ illegal instruction handler] === */
illegal_insn_handler:
  addi x2, x2, -EXCEPTION_STACK_SIZE
  sw x1, 0x44(x2)
  jal x1, store_regs
  j end_except
  # la x1, end_except
  # jal x0, illegal_insn_handler_c

/* ================================= [ ecall user instruction handler] === */
ecall_u_handler:
  addi x2, x2, -EXCEPTION_STACK_SIZE
  sw x1, 0x44(x2)
  jal x1, store_regs
  j end_except
  # la x1, end_except
  # jal x0, ecall_u_handler_c

  /* ================================= [ external interrupt signal handler] === */
external_interrupt_signal_handler:
  addi x2, x2, -EXCEPTION_STACK_SIZE
  sw x1, 0x44(x2)
  jal x1, store_regs
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






