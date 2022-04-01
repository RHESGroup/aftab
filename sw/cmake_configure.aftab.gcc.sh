#!/bin/bash

# **************************************************************************************
#  Filename: cmake_configure.aftab.gcc.sh  #
#  Project:  CNL_RISC-V
#  Version:  1.0
#  History:
#  Date:     22 March, 2022  #
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
#  CMake configure master file to be run to setup environment
#  This file must be run under /sw/build  
#
# **************************************************************************************

#export PATH=/compilerpath/:${PATH}

OBJDUMP=`which riscv32-unknown-elf-objdump`
OBJCOPY=`which riscv32-unknown-elf-objcopy`

COMPILER=`which riscv32-unknown-elf-gcc`
RANLIB=`which riscv32-unknown-elf-ranlib`

DEFAULT_SIM_TIME_NS=1000000

VSIM=`which vsim`

#TARGET_C_FLAGS="-O3 -m32 -g"
#TARGET_C_FLAGS="-O2 -g -falign-functions=16  -funroll-all-loops"
TARGET_C_FLAGS="-O0"

# # if you want to have compressed instructions, set this to 1
# RVC=0

# # if you are using zero-riscy, set this to 1, otherwise it uses RISCY
# USE_ZERO_RISCY=1

# # set this to 1 if you are using the Floating Point extensions for riscy only
# RISCY_RV32F=0

# # zeroriscy with the multiplier
# ZERO_RV32M=1
# # zeroriscy with only 16 registers
# ZERO_RV32E=0

# GCC_MARCH="RV32IM"
GCC_MARCH="rv32im"
# #compile arduino lib
# ARDUINO_LIB=0

# PULP_GIT_DIRECTORY=../../
AFTAB_GIT_DIRECTORY=../../
# SIM_DIRECTORY="$PULP_GIT_DIRECTORY/vsim"
SIM_DIRECTORY="$AFTAB_GIT_DIRECTORY/vsim"
# #insert here your post-layout netlist if you are using IMPERIO
# PL_NETLIST=""

cmake "$AFTAB_GIT_DIRECTORY"/sw/ \
    -DAFTAB_MODELSIM_DIRECTORY="$SIM_DIRECTORY" \
    -DCMAKE_C_COMPILER="$COMPILER" \
    -DGCC_MARCH="$GCC_MARCH" \
    -DCMAKE_C_FLAGS="$TARGET_C_FLAGS" \
    -DCMAKE_OBJCOPY="$OBJCOPY" \
    -DCMAKE_OBJDUMP="$OBJDUMP" \
    -DSIM_TIME_NS:STRING="${1:-$DEFAULT_SIM_TIME_NS}"

# Add -G "Ninja" to the cmake call above to use ninja instead of make
