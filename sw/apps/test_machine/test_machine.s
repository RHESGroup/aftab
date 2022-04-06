 # **************************************************************************************
#  Filename: test_machine.s  #
#  Project:  CNL_RISC-V
#  Version:  1.0
#  History:
#  Date:     05 April, 2022  #
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
#  Example assembly program machine #
#
# **************************************************************************************   

    .text
	.globl	main
	.type	main, @function
main:
# 3 November 2021 


     lui x1,0x100
    li x2,0x0
    li x3,0x1
    li x4,0x2
    li x5,-0x1
    li x6,-0x2
    li x7,0
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
    sw    x7,0(x1)
    j     t0
target0:

    li x6,0x1
    jalr x7,0(x6) # Testing Misaliged Instruction
t0:
            # In file sw/apps/CMakeLists.txt uncomment: set(BOOT_MODE "crt0_boot_M")
            # li x1,0x100
            # li x2,0x1
            # sw  x2,0(x1)
            # li x6,0x1
            # jalr x2,0(x6)
            # sw   x6,0(x1)

            # csrrc x3,0xC10,x0               # Read not implemented register. In machine mode do not rise Illegal Instruction Exception.   
            # jal x1,0x88                    # Since we are already in machine we can direcly jump tp whatever lable.
                                            # If CSR instruction have to be performed the priviledge level is already the maximum.
            # Other tests

            # csrrc x3,mvendorid,x0     #  invalid instruction exc.   Not implemented register
            # div x7,x3,x0              #  invalid instruction exc.   Division by 0
            # ebreak                    #  invalid instruction exc.   Not implemented instruction

fine:            
	j fine



            
           
