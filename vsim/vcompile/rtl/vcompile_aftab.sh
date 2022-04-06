#!/bin/tcsh
# **************************************************************************************
#  Filename: vcompile_aftab.sh  #
#  Project:  CNL_RISC-V
#  Version:  1.0
#  History:
#  Date:     04 April, 2022  #
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
#  Hardware compilation script #
#
# **************************************************************************************


source ${AFTAB_PATH}/vsim/vcompile/colors.csh

##############################################################################
# Settings
##############################################################################

set IP=aftab
set IP_NAME="AFTAB"


##############################################################################
# Check settings
##############################################################################

# check if environment variables are defined
# if (! $?MSIM_LIBS_PATH ) then
#   echo "${Red} MSIM_LIBS_PATH is not defined ${NC}"
#   exit 1
# endif

if (! $?RTL_PATH ) then
  echo "${Red} RTL_PATH is not defined ${NC}"
  exit 1
endif


# set LIB_NAME="${IP}_lib"
# set LIB_PATH="${MSIM_LIBS_PATH}/${LIB_NAME}"

##############################################################################
# Preparing library
##############################################################################

echo "${Green}--> Compiling ${IP_NAME}... ${NC}"

# rm -rf $LIB_PATH

# vlib $LIB_PATH
# vmap $LIB_NAME $LIB_PATH

##############################################################################
# Compiling RTL
##############################################################################

echo "${Green}Compiling component: ${Brown} generics ${NC}"
echo "${NC}"

vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_register.vhd  || goto error
vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_multiplexer.vhd  || goto error
vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_comparator.vhd   || goto error
vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_counter.vhd   || goto error
vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_imm_sel_sign_ext.vhd  || goto error
vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_full_adder.vhd  || goto error
vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_half_adder.vhd  || goto error
vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_one_bit_register.vhd  || goto error
vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_opt_adder.vhd  || goto error
vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_adder.vhd   || goto error
vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_adder_subtractor.vhd   || goto error
vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_decoder.vhd   || goto error
vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_barrel_shifter.vhd   || goto error
vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_llu.vhd  || goto error
vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_sulu.vhd  || goto error
vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_register_file.vhd  || goto error

echo "${Green}Compiling component: ${Brown} CSR and Interrupts ${NC}"
echo "${NC}"

#added by Luca
vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_csr/aftab_csr_address_ctrl.vhd || goto error

vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_csr/aftab_csr_address_logic.vhd  || goto error
vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_csr/aftab_csr_addressing_decoder.vhd  || goto error
vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_csr/aftab_csr_counter.vhd  || goto error
vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_csr/aftab_csr_isl.vhd  || goto error
vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_csr/aftab_csr_registers.vhd  || goto error
vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_csr/aftab_iccd.vhd  || goto error
vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_csr/aftab_isagu.vhd  || goto error
vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_csr/aftab_register_bank.vhd  || goto error

echo "${Green}Compiling component: ${Brown} AAU ${NC}"
echo "${NC}"

vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_aau/aftab_shift_register.vhd  || goto error
vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_aau/aftab_booth_multiplier/aftab_booth_multiplier_controller.vhd  || goto error
vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_aau/aftab_booth_multiplier/aftab_booth_multiplier_datapath.vhd  || goto error
vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_aau/aftab_booth_multiplier/aftab_booth_multiplier.vhd  || goto error
vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_aau/aftab_su_divider/aftab_divider_controller.vhd  || goto error
vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_aau/aftab_su_divider/aftab_divider_datapath.vhd  || goto error
vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_aau/aftab_su_divider/aftab_divider.vhd  || goto error
vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_aau/aftab_su_divider/aftab_tcl.vhd  || goto error
vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_aau/aftab_su_divider/aftab_su_divider.vhd  || goto error
vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_aau/aftab_aau.vhd  || goto error

echo "${Green}Compiling component: ${Brown} DARU ${NC}"
echo "${NC}"

vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_daru/aftab_daru_controller.vhd  || goto error
vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_daru/aftab_daru_error_detector.vhd  || goto error
vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_daru/aftab_daru_datapath.vhd  || goto error
vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_daru/aftab_daru.vhd  || goto error

echo "${Green}Compiling component: ${Brown} DAWU ${NC}"
echo "${NC}"

vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_dawu/aftab_dawu_controller.vhd  || goto error
vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_dawu/aftab_dawu_error_detector.vhd  || goto error
vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_dawu/aftab_dawu_datapath.vhd  || goto error
vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_dawu/aftab_dawu.vhd  || goto error

echo "${Green}Compiling component: ${Brown} Datapath and Controller ${NC}"
echo "${NC}"

vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_datapath.vhd  || goto error
vcom -2008 -work work ${RTL_PATH}/aftab_controller.vhd  || goto error
vcom -2008 -work work ${RTL_PATH}/aftab_core.vhd  || goto error

echo ""
echo "${Cyan}--> ${IP_NAME} compilation complete! ${NC}"
echo ""

vcom -2008 -work work ${TB_PATH}/aftab_memory.vhd  || goto error
vcom -2008 -work work ${TB_PATH}/aftab_testbench.vhd  || goto error

echo ""
echo "${Cyan}--> Testbench for ${IP_NAME} compiled with success! Simulation can be started. ${NC}"
echo ""

exit 0

##############################################################################
# Error handler
##############################################################################

error:
echo "${Red}"
exit 1
