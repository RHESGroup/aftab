#!/bin/tcsh
# **************************************************************************************
#  Filename: build_rtl_sim.csh  #
#  Project:  CNL_RISC-V
#  Version:  1.0
#  History:
#  Date:     29 March, 2022  #
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
#  Build rtl sim  #
#
# **************************************************************************************

if (! $?VSIM_PATH ) then
  setenv VSIM_PATH      `pwd`
endif

if (! $?AFTAB_PATH ) then
  setenv AFTAB_PATH      `pwd`/../
endif

# setenv MSIM_LIBS_PATH ${VSIM_PATH}/modelsim_libs

# setenv IPS_PATH       ${AFTAB_PATH}/ips
setenv RTL_PATH       ${AFTAB_PATH}/rtl
setenv TB_PATH        ${AFTAB_PATH}/tb

clear
source ${AFTAB_PATH}/vsim/vcompile/colors.csh

# rm -rf modelsim_libs
# vlib modelsim_libs

rm -rf work
vlib work

echo ""
echo "${Green}--> Compiling AFTAB core... ${NC}"
echo ""

# # IP blocks

source ${AFTAB_PATH}/vsim/vcompile/rtl/vcompile_aftab.sh  || exit 1

echo ""
echo "${Green}--> AFTAB environment compilation complete! ${NC}"
echo ""
