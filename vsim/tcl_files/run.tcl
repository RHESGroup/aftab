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
#  Run ModelSim simulation of the target through GUI  #
#
# **************************************************************************************

vsim -quiet work.aftab_testbench +nowarnTRAN +nowarnTSCALE +nowarnTFMPC -t 10ps -voptargs="+acc -suppress 2103" -dpicpppath /usr/bin/gcc 

add wave -noupdate -group SYSTEM /aftab_testbench/clk          
add wave -noupdate -group SYSTEM /aftab_testbench/rst          
add wave -noupdate -group SYSTEM /aftab_testbench/memReady 
add wave -noupdate -group SYSTEM /aftab_testbench/memRead 
add wave -noupdate -group SYSTEM /aftab_testbench/memWrite     
add wave -noupdate -group SYSTEM -radix hexadecimal /aftab_testbench/memAddr     
add wave -noupdate -group SYSTEM -radix hexadecimal /aftab_testbench/dataBusIn
add wave -noupdate -group SYSTEM -radix hexadecimal /aftab_testbench/dataBusOut     
add wave -noupdate -group SYSTEM /aftab_testbench/log_en
add wave -noupdate -group SYSTEM -radix hexadecimal /aftab_testbench/core/datapathAFTAB/inst
add wave -noupdate -group SYSTEM -radix hexadecimal /aftab_testbench/core/datapathAFTAB/outPC
add wave -noupdate -group SYSTEM /aftab_testbench/core/controllerAFTAB/p_state         

add wave -noupdate -group CONTROLLER /aftab_testbench/core/controllerAFTAB/*

add wave -noupdate -group DATAPATH /aftab_testbench/core/datapathAFTAB/*

add wave -noupdate -group REGISTER_FILE /aftab_testbench/core/datapathAFTAB/registerFile/*

add wave -noupdate -group REGISTERS -radix hexadecimal /aftab_testbench/core/datapathAFTAB/registerFile/rData

add wave -noupdate -group LLU /aftab_testbench/core/datapathAFTAB/LLU/*

add wave -noupdate -group BSU /aftab_testbench/core/datapathAFTAB/BSU/*

add wave -noupdate -group COMPARATOR /aftab_testbench/core/datapathAFTAB/comparator/*

add wave -noupdate -group ADD_SUB /aftab_testbench/core/datapathAFTAB/addSub/*

add wave -noupdate -group AAU /aftab_testbench/core/datapathAFTAB/aau/*

add wave -noupdate -group MUL /aftab_testbench/core/datapathAFTAB/aau/Multiplication/*
add wave -noupdate -group MUL /aftab_testbench/core/datapathAFTAB/aau/Multiplication/controller/pstate

add wave -noupdate -group DIV /aftab_testbench/core/datapathAFTAB/aau/Division/*
add wave -noupdate -group DIV /aftab_testbench/core/datapathAFTAB/aau/Division/unsignedDiv/ControllerDiv/pstate

add wave -noupdate -group DAWU /aftab_testbench/core/datapathAFTAB/dawu/*

add wave -noupdate -group DARU /aftab_testbench/core/datapathAFTAB/daru/*

add wave -noupdate -group SULU /aftab_testbench/core/datapathAFTAB/sulu/*

add wave -noupdate -group INTERRUPTS /aftab_testbench/core/datapathAFTAB/platformInterruptSignals

add wave -noupdate -group INTER_SRC_SYNC_REG /aftab_testbench/core/datapathAFTAB/interSrcSynchReg/*

add wave -noupdate -group CSR_REGISTERS -radix hexadecimal /aftab_testbench/core/datapathAFTAB/register_bank/addressRegBank
add wave -noupdate -group CSR_REGISTERS -radix unsigned /aftab_testbench/core/datapathAFTAB/register_bank/translatedAddress
add wave -noupdate -group CSR_REGISTERS -radix hexadecimal /aftab_testbench/core/datapathAFTAB/register_bank/CSR_registers/rData

add wave -noupdate -group INT_CAUSE_DETECTOR /aftab_testbench/core/datapathAFTAB/interrCheckCauseDetection/*

add wave -noupdate -group EXCEPTIONS /aftab_testbench/core/datapathAFTAB/ecallFlag
add wave -noupdate -group EXCEPTIONS /aftab_testbench/core/datapathAFTAB/dividedByZeroFlag
add wave -noupdate -group EXCEPTIONS /aftab_testbench/core/datapathAFTAB/illegalInstrFlag
add wave -noupdate -group EXCEPTIONS /aftab_testbench/core/datapathAFTAB/instrMisalignedFlag

add wave -noupdate -group EXC_ADDRESS_GENERATOR /aftab_testbench/core/datapathAFTAB/interruptStartAddressGenerator/*

add wave -noupdate -group MEMORY -radix hexadecimal /aftab_testbench/memory/rw/adr
add wave -noupdate -group MEMORY -radix hexadecimal /aftab_testbench/memory/mem

run $var ns



