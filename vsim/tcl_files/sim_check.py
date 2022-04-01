# **************************************************************************************
#  Filename: sim_check.py  #
#  Project:  CNL_RISC-V
#  Version:  1.0
#  History:
#  Date:     30 March, 2022  #
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
#  Simulation results check against golden model  #
#
# **************************************************************************************

try:
    data_mem = open("./slm_files/dram_dump.txt", 'r')
    golden_model = open("./slm_files/golden_dump.txt", 'r')

    e_flag = 0
    m_count = 0
    print("")
    print("")
    for line_dm, line_g in zip(data_mem, golden_model):
        if line_dm != line_g :
            content_dm = line_dm.split("_")
            content_g = line_g.split("_")
            print("Mismatch @ address 0x"+content_dm[0]+": expected "+content_g[1].rstrip("\n")+" but found "+content_dm[1].rstrip("\n"))
            m_count = m_count + 1
            e_flag = 1


    if e_flag == 0:
        print("")
        print("")
        print("Simulation ended successfully: 0 mismatches found comparing DRAM dump and golden dump.")
    else:
        print("")
        print("")
        print("Simulation ended unsuccessfully: "+str(m_count)+" mismatches found comparing DRAM dump and golden dump.")
        print("Try to enlarge simulation time or check your RTL files.")

    data_mem.close()
    golden_model.close()

except IOError:
    
    print("")
    print("")
    print("Warning: dram_dump.txt or golden_dump.txt does not exist under ./slm_files/. Simulation check exits. ")
finally:

    exit 


