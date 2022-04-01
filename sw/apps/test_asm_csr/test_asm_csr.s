# **************************************************************************************
#  Filename: test_asm_csr.s  #
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
#  Assembly test of illegal csr-instruction for missing privileges.  #
#
# **************************************************************************************

    .text
    .globl    main
    .type main, @function
main:
   lui x18,0x100
   jal x1, set_regs
    
    # In file sw/apps/CMakeLists.txt uncomment: set(BOOT_MODE "crt0_boot_MU_test_csr")
    csrrw  x0,0xC10,x4
    sw     x9,512(x18)
    li     x9,0 
    csrrc  x4,0xC10,x4
    sw     x9,516(x18)
    li     x9,0
    csrrs  x4,0xC10,x4
    sw     x9,520(x18)
    li     x9,0    
    csrrwi x4,0xC10,3 
    sw     x9,524(x18)
    li     x9,0
    csrrci x4,0xC10,3
    sw     x9,528(x18)
    li     x9,0
    csrrsi x4,0xC10,3
    sw     x9,532(x18)
    li     x9,0
    csrrw  x4,mie,x0
    sw     x9,536(x18)
    li     x9,0
    csrrc  x4,mie,x0
    sw     x9,540(x18)
    li     x9,0
    csrrs  x4,mie,x0 
    sw     x9,544(x18)
    li     x9,0    
    csrrwi x4,mie,0
    sw     x9,548(x18)
    li     x9,0
    csrrci x4,mie,0
    sw     x9,552(x18)
    li     x9,0
    csrrsi x4,mie,0
    sw     x9,556(x18)
    li     x9,0
      ret

    .text
    .globl  set_regs
    .type   set_regs, @function
set_regs:
    li x4,0x2
    li x5,-0x1
    li x6,-0x2
    li x7,-0x1
    jalr x0, x1

