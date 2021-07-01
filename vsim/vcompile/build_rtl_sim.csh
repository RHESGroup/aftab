#!/bin/tcsh

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
# source ${AFTAB_PATH}/vsim/vcompile/vcompile_ips.csh  || exit 1

# source ${AFTAB_PATH}/vsim/vcompile/rtl/vcompile_pulpino.sh  || exit 1
source ${AFTAB_PATH}/vsim/vcompile/rtl/vcompile_aftab.sh  || exit 1
# source ${AFTAB_PATH}/vsim/vcompile/rtl/vcompile_tb.sh     || exit 1

echo ""
echo "${Green}--> AFTAB environment compilation complete! ${NC}"
echo ""
