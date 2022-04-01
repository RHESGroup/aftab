# **************************************************************************************
#  Filename: test_machine_user.s  #
#  Project:  CNL_RISC-V
#  Version:  1.0
#  History:
#  Date:     08 February, 2022  #
#
# Copyright (C) 2021 CINI Cybersecurity National Laboratory and University of Teheran
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
#  Example assembly program machine-user #
#
# **************************************************************************************   
	.text
	.globl	main
	.type	main, @function
main:
# 3 November 2021 

            # In file sw/apps/CMakeLists.txt uncomment: set(BOOT_MODE "crt0_boot_MU") to use this program

            csrrc x3,0xC10,x0               # Read PRIVLV. In user mode rise Illegal Instruction Exception.   
            ecall                           # If Invalid Exception reach infinite loop ->
                                            # In file sw/ref/crt0.boot_M.S lable end_except:
                                            # Comment   j default_exc_handler
                                            # Uncomment mret

            li x10,2
            

            # Other tests

            # csrrc x3,mvendorid,x0     #  invalid instruction exc.   Not implemented register
            # div x7,x3,x0              #  invalid instruction exc.   Division by 0
            # ebreak                    #  invalid instruction exc.   Not implemented instruction


fine:            
	j fine



            
           
