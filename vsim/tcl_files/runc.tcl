# **************************************************************************************
#  Filename: run.tcl  #
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
#  Run command-line simulation of the target and compare results  #
#
# **************************************************************************************

vsim -quiet work.aftab_testbench +nowarnTRAN +nowarnTSCALE +nowarnTFMPC -t 10ps -voptargs="+acc -suppress 2103" -dpicpppath /usr/bin/gcc 

run $var ns
force memRead 0
run 1000 ns
force log_en 1
run 1000 ns
force log_en 0
run 1000 ns

proc sim_check {} {
    set output [exec python ../../../../vsim/tcl_files/sim_check.py]
    echo $output
    quit
}

sim_check




