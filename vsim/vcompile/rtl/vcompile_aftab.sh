#!/bin/tcsh
source ${AFTAB_PATH}/vsim/vcompile/colors.csh

##############################################################################
# Settings
##############################################################################

# set IP=pulpino
set IP=aftab
# set IP_NAME="PULPino"
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

echo "${Green}Compiling component: ${Brown} ${IP_NAME} ${NC}"
echo "${NC}"

##############################################################################
# Compiling RTL
##############################################################################

# # decide if we want to build for riscv or or1k
# if ( ! $?PULP_CORE) then
#   set PULP_CORE="riscv"
# endif

# if ( $PULP_CORE == "riscv" ) then
#   set CORE_DEFINES=+define+RISCV
#   echo "${Yellow} Compiling for RISCV core ${NC}"
# else
#   set CORE_DEFINES=+define+OR10N
#   echo "${Yellow} Compiling for OR10N core ${NC}"
# endif

# # decide if we want to build for riscv or or1k
# if ( ! $?ASIC_DEFINES) then
#   set ASIC_DEFINES=""
# endif

# # components
# vlog -quiet -sv -work ${LIB_PATH} ${RTL_PATH}/components/cluster_clock_gating.sv    || goto error
# vlog -quiet -sv -work ${LIB_PATH} ${RTL_PATH}/components/pulp_clock_gating.sv       || goto error
# vlog -quiet -sv -work ${LIB_PATH} ${RTL_PATH}/components/cluster_clock_inverter.sv  || goto error
# vlog -quiet -sv -work ${LIB_PATH} ${RTL_PATH}/components/cluster_clock_mux2.sv      || goto error
# vlog -quiet -sv -work ${LIB_PATH} ${RTL_PATH}/components/pulp_clock_inverter.sv     || goto error
# vlog -quiet -sv -work ${LIB_PATH} ${RTL_PATH}/components/pulp_clock_mux2.sv         || goto error
# vlog -quiet -sv -work ${LIB_PATH} ${RTL_PATH}/components/generic_fifo.sv            || goto error
# vlog -quiet -sv -work ${LIB_PATH} ${RTL_PATH}/components/rstgen.sv                  || goto error
# vlog -quiet -sv -work ${LIB_PATH} ${RTL_PATH}/components/sp_ram.sv                  || goto error


# # files depending on RISCV vs. OR1K
# vlog -quiet -sv -work ${LIB_PATH} +incdir+${RTL_PATH}/includes ${ASIC_DEFINES} ${CORE_DEFINES} ${RTL_PATH}/core_region.sv        || goto error
# vlog -quiet -sv -work ${LIB_PATH} +incdir+${RTL_PATH}/includes ${ASIC_DEFINES} ${CORE_DEFINES} ${RTL_PATH}/random_stalls.sv      || goto error

# vlog -quiet -sv -work ${LIB_PATH} +incdir+${RTL_PATH}/includes ${ASIC_DEFINES} ${CORE_DEFINES} ${RTL_PATH}/boot_rom_wrap.sv      || goto error
# vlog -quiet -sv -work ${LIB_PATH} +incdir+${RTL_PATH}/includes ${ASIC_DEFINES} ${CORE_DEFINES} ${RTL_PATH}/boot_code.sv          || goto error
# vlog -quiet -sv -work ${LIB_PATH} +incdir+${RTL_PATH}/includes ${ASIC_DEFINES} ${CORE_DEFINES} ${RTL_PATH}/instr_ram_wrap.sv     || goto error
# vlog -quiet -sv -work ${LIB_PATH} +incdir+${RTL_PATH}/includes ${ASIC_DEFINES} ${CORE_DEFINES} ${RTL_PATH}/sp_ram_wrap.sv        || goto error
# vlog -quiet -sv -work ${LIB_PATH} +incdir+${RTL_PATH}/includes ${ASIC_DEFINES} ${CORE_DEFINES} ${RTL_PATH}/ram_mux.sv            || goto error
# vlog -quiet -sv -work ${LIB_PATH} +incdir+${RTL_PATH}/includes ${ASIC_DEFINES} ${CORE_DEFINES} ${RTL_PATH}/axi_node_intf_wrap.sv || goto error
# vlog -quiet -sv -work ${LIB_PATH} +incdir+${RTL_PATH}/includes ${ASIC_DEFINES} ${CORE_DEFINES} ${RTL_PATH}/pulpino_top.sv        || goto error
# vlog -quiet -sv -work ${LIB_PATH} +incdir+${RTL_PATH}/includes ${ASIC_DEFINES} ${CORE_DEFINES} ${RTL_PATH}/peripherals.sv        || goto error
# vlog -quiet -sv -work ${LIB_PATH} +incdir+${RTL_PATH}/includes ${ASIC_DEFINES} ${CORE_DEFINES} ${RTL_PATH}/periph_bus_wrap.sv    || goto error
# vlog -quiet -sv -work ${LIB_PATH} +incdir+${RTL_PATH}/includes ${ASIC_DEFINES} ${CORE_DEFINES} ${RTL_PATH}/axi2apb_wrap.sv       || goto error
# vlog -quiet -sv -work ${LIB_PATH} +incdir+${RTL_PATH}/includes ${ASIC_DEFINES} ${CORE_DEFINES} ${RTL_PATH}/axi_spi_slave_wrap.sv || goto error
# vlog -quiet -sv -work ${LIB_PATH} +incdir+${RTL_PATH}/includes ${ASIC_DEFINES} ${CORE_DEFINES} ${RTL_PATH}/axi_mem_if_SP_wrap.sv || goto error
# vlog -quiet -sv -work ${LIB_PATH} +incdir+${RTL_PATH}/includes ${ASIC_DEFINES} ${CORE_DEFINES} ${RTL_PATH}/clk_rst_gen.sv        || goto error
# vlog -quiet -sv -work ${LIB_PATH} +incdir+${RTL_PATH}/includes ${ASIC_DEFINES} ${CORE_DEFINES} ${RTL_PATH}/axi_slice_wrap.sv     || goto error
# vlog -quiet -sv -work ${LIB_PATH} +incdir+${RTL_PATH}/includes ${ASIC_DEFINES} ${CORE_DEFINES} ${RTL_PATH}/core2axi_wrap.sv      || goto error
  
vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_register.vhd  || goto error
vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_multiplexer.vhd  || goto error
vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_comparator.vhd   || goto error
vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_counter.vhd   || goto error
vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_imm_sel_sign_ext.vhd  || goto error
vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_adder.vhd  || goto error
vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_adder_subtractor.vhd   || goto error
vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_barrel_shifter.vhd   || goto error
vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_llu.vhd  || goto error
vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_sulu.vhd  || goto error
vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_register_file.vhd  || goto error
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


vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_daru/aftab_half_adder.vhd  || goto error
vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_daru/aftab_full_adder.vhd  || goto error
vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_daru/aftab_decoder.vhd  || goto error
vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_daru/aftab_opt_adder.vhd  || goto error
vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_daru/aftab_daru_controller.vhd  || goto error
vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_daru/aftab_daru_datapath.vhd  || goto error
vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_daru/aftab_daru.vhd  || goto error


vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_dawu/aftab_dawu_controller.vhd  || goto error
vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_dawu/aftab_dawu_datapath.vhd  || goto error
vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_dawu/aftab_dawu.vhd  || goto error

vcom -2008 -work work ${RTL_PATH}/aftab_datapath/aftab_datapath.vhd  || goto error
vcom -2008 -work work ${RTL_PATH}/aftab_controller.vhd  || goto error
vcom -2008 -work work ${RTL_PATH}/aftab_core.vhd  || goto error

echo ""
echo "${Cyan}--> ${IP_NAME} compilation complete! ${NC}"
echo ""

vcom -2008 -work work ${TB_PATH}/aftab_memory.vhd  || goto error
vcom -2008 -work work ${TB_PATH}/aftab_testbench.vhd  || goto error

exit 0

##############################################################################
# Error handler
##############################################################################

error:
echo "${Red}"
exit 1
