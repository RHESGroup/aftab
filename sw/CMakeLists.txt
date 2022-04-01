# **************************************************************************************
#  Filename: CMakeLists.txt  #
#  Project:  CNL_RISC-V
#  Version:  1.0
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
#  Root CMake file for the AFTAB software system  #
# 
# **************************************************************************************

cmake_minimum_required (VERSION 3.0)

include(CMakeParseArguments)

if (${CMAKE_VERSION} VERSION_GREATER 3.1.0)
  set(USES_TERMINAL "USES_TERMINAL")
else()
  set(USES_TERMINAL "")
endif()

# Force object file extension to be .o
set(UNIX TRUE CACHE STRING "" FORCE)

# System name
# If we set the system to Clang/GCC we get "-rdynamic"
# however we need Linux for dynamic linking stuffs.
# We should probably create a custom system name
set(CMAKE_SYSTEM_NAME "Linux-CXX")

enable_language(C CXX ASM)
project (pulp_software C)

enable_testing()

set(RISCV 1)

# if(${RISCY_RV32F} AND ${USE_ZERO_RISCY})
#   message(SEND_ERROR "Floating Point Extensions are not supported on zero-riscy")
# endif()

# assign default architecture flags if not defined
string(COMPARE EQUAL "${GCC_MARCH}" "" GCC_MARCH_NOT_SET)

if(GCC_MARCH_NOT_SET)
   message("\nUsing default architecture flags!!\n")

   # if(${USE_RISCY})
   #    if(${RISCY_RV32F})
   #       set(GCC_MARCH "IMFDXpulpv2")
   #    else()
   #       set(GCC_MARCH "IMXpulpv2")
   #    endif()
   # else()
   #    if(${ZERO_RV32M})
   #      set(GCC_MARCH "RV32IM")
   #    else()
   #      set(GCC_MARCH "RV32I")
   #    endif()
   # endif()
endif()


message(STATUS "GCC_MARCH= ${GCC_MARCH}")
# -m32 is not a valid option anymore, modified Gianluca Roascio 19/10/2020
#set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -m32 -march=${GCC_MARCH} -Wa,-march=${GCC_MARCH}")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -march=${GCC_MARCH} -Wa,-march=${GCC_MARCH}")
# -Mmarch is not a valid option anymore for objdump, modified Gianluca Roascio 29/06/2021
# set(CMAKE_OBJDUMP_FLAGS -Mmarch=${GCC_MARCH} -d)
set(CMAKE_OBJDUMP_FLAGS -d)

# if(${GCC_MARCH} MATCHES "IMFDXpulpv2")
#   set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -mhard-float")
# endif()

# if(${RVC})
#   message("NOTE: Using compressed instructions")
#   set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -mrvc")
# endif()

# if(${ZERO_RV32E})
#   if (${USE_RISCY})
#     message(SEND_ERROR "RV32E can only be used with Zero-riscy")
#   endif()
#   message("NOTE: Using RV32E ISA")
#   set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -m16r")
# endif()

set(LDSCRIPT      "link.riscv.ld")
set(LDSCRIPT_BOOT "link.boot.ld" )


# set(PULP_PC_ANALYZE "pulp-pc-analyze" CACHE PATH "path to pulp pc analyze binary")

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wextra -Wall -Wno-unused-parameter -Wno-unused-variable -Wno-unused-function -fdata-sections -ffunction-sections -fdiagnostics-color=always")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -L${CMAKE_CURRENT_SOURCE_DIR}/ref -T${LDSCRIPT} -nostartfiles -Wl,--gc-sections")
set(BOOT_LINKER_FLAGS      "-L${CMAKE_CURRENT_SOURCE_DIR}/ref -T${LDSCRIPT_BOOT} -nostartfiles -Wl,--gc-sections")

set(CMAKE_CXX_COMPILER "${CMAKE_C_COMPILER}")
set(CMAKE_CXX_FLAGS    "${CMAKE_C_FLAGS}")

set(CMAKE_ASM_COMPILER "${CMAKE_C_COMPILER}")
set(CMAKE_ASM_FLAGS    "${CMAKE_C_FLAGS}")

# set(PULP_MODELSIM_DIRECTORY "" CACHE PATH "Path to the ModelSim PULPino build")
set(AFTAB_MODELSIM_DIRECTORY "" CACHE PATH "Path to the ModelSim AFTAB build")
set(VSIM "vsim" CACHE FILEPATH "Path to the vsim executable")

################################################################################

 # if(${ZERO_RV32E})
 #   set(crt0      "ref/crt0.riscv_E.S")
 #   set(crt0_boot "ref/crt0.boot_E.S")
 # else()
   set(crt0_boot_M  "ref/crt0.boot_M.S")   # Added by Simone 29 October 2021
   set(crt0_boot_MU "ref/crt0.boot_MU.S")  # 
   set(crt0_boot_MU_test_csr "ref/crt0.boot_MU_test_csr.S") 
 # endif()

 # include_directories(libs/sys_lib/inc)

 # if(${ARDUINO_LIB})
 #  include_directories(libs/Arduino_lib/core_libs/inc)
 #  include_directories(libs/Arduino_lib/separate_libs/inc)
 # endif()

 # if(${RISCY_RV32F})
 #   include_directories(libs/math_fns_lib/inc)
 # endif()

 set_source_files_properties(${crt0} PROPERTIES LANGUAGE C)
 add_library(crt0_boot_M OBJECT ${crt0_boot_M})
 add_library(crt0_boot_MU OBJECT ${crt0_boot_MU})  # Added by Simone 29 October 2021
 add_library(crt0_boot_MU_test_csr OBJECT ${crt0_boot_MU_test_csr})  # Added by Simone 29 October 2021
 set_target_properties(crt0_boot_M PROPERTIES COMPILE_FLAGS "-DBOOT_M")
 set_target_properties(crt0_boot_MU PROPERTIES COMPILE_FLAGS "-DBOOT_MU") # Added by Simone 29 October 2021
 set_target_properties(crt0_boot_MU_test_csr PROPERTIES COMPILE_FLAGS "-DBOOT_MU_test_csr") # Added by Simone 29 October 2021


################################################################################
# Other targets
################################################################################

add_custom_target(vcompile
  COMMAND tcsh -c "./vcompile/build_rtl_sim.csh"
  WORKING_DIRECTORY ${AFTAB_MODELSIM_DIRECTORY}
  ${USES_TERMINAL})

# added Gianluca Roascio 30/03/2022
add_custom_target(gen_test_instr
  COMMAND python3 "test_asm_instr_generator.py"
  WORKING_DIRECTORY ${AFTAB_MODELSIM_DIRECTORY}/../sw/utils
  ${USES_TERMINAL})

add_custom_target(gen_test_csr
  COMMAND python3 "test_asm_csr_generator.py"
  WORKING_DIRECTORY ${AFTAB_MODELSIM_DIRECTORY}/../sw/utils
  ${USES_TERMINAL})

################################################################################

# add_subdirectory(libs/string_lib)
# add_subdirectory(libs/sys_lib)

# if(${RISCY_RV32F})
#  add_subdirectory(libs/math_fns_lib)
# endif()

# if(${ARDUINO_LIB})
#  add_subdirectory(libs/Arduino_lib)
# endif()

# add_subdirectory(libs/bench_lib)

# set(BEEBS_LIB 0)

# if(${BEEBS_LIB})
#  add_subdirectory(libs/beebs_lib)
# endif()

add_subdirectory(apps)

set( SUB_DIRS "test_add"
              "test_dummy"
              "test_asm_arithmetic" 
              "test_asm_branches" 
              "test_asm_data_transfer" 
              "test_asm_logical_shift_lui" 
              "test_machine" 
              "test_machine_user"
              "test_asm_csr") 

set( CLEAN_TARGETS "")

foreach( dir  ${SUB_DIRS})
 list(APPEND CLEAN_TARGETS "apps/${dir}/${dir}.read" )
 list(APPEND CLEAN_TARGETS "apps/${dir}/${dir}.lst" )
 list(APPEND CLEAN_TARGETS "apps/${dir}/transcript" )
 list(APPEND CLEAN_TARGETS "apps/${dir}/vsim.wlf" )
 list(APPEND CLEAN_TARGETS "apps/${dir}/vsim.log" )
 list(APPEND CLEAN_TARGETS "apps/${dir}/slm_files/dram_dump.txt" )
endforeach( )

set_directory_properties(PROPERTIES ADDITIONAL_MAKE_CLEAN_FILES "${CLEAN_TARGETS}")
                            

