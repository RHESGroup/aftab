# **************************************************************************************
#  Filename: CMakeSim.txt  #
#  Project:  CNL_RISC-V
#  Version:  1.0
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
#  First-order CMake file for the AFTAB applications  #
# 
# **************************************************************************************

set(UTILS_DIR ${CMAKE_SOURCE_DIR}/utils)

# Added by Simone Peraccini 29 October 2021
set(BOOT_MODE "crt0_boot_M")     
# set(BOOT_MODE "crt0_boot_MU")


set(SIM_TIME_NS 1000000 CACHE STRING "Simulation time.")

include(CMakeSim.txt)

################################################################################
# main application macro
# Optional arguments:
#  - SUBDIR prefix   (prefix application with prefix)
#
# Attention: Every application name has to be unique and must have its own
#            build folder, so if you have multiple applications in one folder,
#            use SUBDIR to separate them
################################################################################
macro(add_application NAME SOURCE_FILES)
  # optional argument parsing
  set(oneValueArgs SUBDIR TB TB_TEST LABELS FLAGS)
  set(multiValueArgs LIBS)
  cmake_parse_arguments(ARG "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})
  set(SUBDIR ${ARG_SUBDIR})

  # include_directories(
  #   ${CMAKE_SOURCE_DIR}/libs/malloc_lib/inc
  #   ${CMAKE_SOURCE_DIR}/libs/string_lib/inc
  #   ${CMAKE_SOURCE_DIR}/libs/sys_lib/inc
  #   ${CMAKE_SOURCE_DIR}/libs/bench_lib/inc
  # )

  # if(${ARDUINO_LIB})
  #   include_directories(
  #     ${CMAKE_SOURCE_DIR}/libs/Arduino_lib/core_libs/inc
  #     ${CMAKE_SOURCE_DIR}/libs/Arduino_lib/separate_libs/inc
  #   )
  # endif()

  # if(${BEEBS_LIB})
  #   include_directories(
  #       ${CMAKE_SOURCE_DIR}/libs/beebs_lib/inc
  #     )
  # endif()

  # changed inserted boot code - modified Gianluca Roascio 28/06/2021
  #add_executable(${NAME}.elf $<TARGET_OBJECTS:crt0> ${SOURCE_FILES})
  add_executable(${NAME}.elf $<TARGET_OBJECTS:${BOOT_MODE}> ${SOURCE_FILES}) # Boot object substituted with ${BOOT_MODE}.  Simone Peraccini 29 Ottobre 2021

  # set subdirectory for add_executable
  if(NOT "${SUBDIR}" STREQUAL "")
    set_target_properties(${NAME}.elf PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${SUBDIR})
  endif()

  # set optional compile flags per application
  if(NOT "${ARG_FLAGS}" STREQUAL "")
    set_target_properties(${NAME}.elf PROPERTIES COMPILE_FLAGS ${ARG_FLAGS})
  endif()

  set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -lm")

  # if(${RISCY_RV32F})
  #   set(MATH_FNS_LIB "math_fns")
  # else()
  #   set(MATH_FNS_LIB "")
  # endif()

  # if(${BEEBS_LIB})
  #   set(BEEBS_LIB_NAME "beebs")
  # else()
  #   set(BEEBS_LIB_NAME "")
  # endif()

  # if(${ARDUINO_LIB})
  #   set(ARDUINO_CORE "Arduino_core")
  #   set(ARDUINO_SEP "Arduino_separate")
  # else()
  #   set(ARDUINO_CORE "")
  #   set(ARDUINO_SEP "")
  # endif()

  # # link libraries
  # target_link_libraries(${NAME}.elf ${ARG_LIBS} ${ARDUINO_SEP} ${ARDUINO_CORE} ${BEEBS_LIB_NAME} bench ${MATH_FNS_LIB} string sys m)

  # this specifies the testbench to use for simulation
  if(ARG_TB)
    set_target_properties(${NAME}.elf PROPERTIES TB ${ARG_TB})
  else()
    set_target_properties(${NAME}.elf PROPERTIES TB run.tcl)
  endif()

  # this specifies the TEST parameter argument for the testbench (if any)
  if(ARG_TB_TEST)
    set_target_properties(${NAME}.elf PROPERTIES TB_TEST ${ARG_TB_TEST})
  else()
    set_target_properties(${NAME}.elf PROPERTIES TB_TEST "")
  endif()

  add_custom_target(${NAME}.read)
  add_custom_command(TARGET ${NAME}.read
    POST_BUILD
    COMMAND ${CMAKE_OBJDUMP} ${CMAKE_OBJDUMP_FLAGS} $<TARGET_FILE:${NAME}.elf> > ${NAME}.read
    WORKING_DIRECTORY ./${SUBDIR}
    DEPENDS ${NAME}.elf)

  # custom target to disassembly also data - added Gianluca Roascio 29/06/2021
  add_custom_target(${NAME}.list)
  add_custom_command(TARGET ${NAME}.list
    POST_BUILD
    COMMAND ${CMAKE_OBJDUMP} -D $<TARGET_FILE:${NAME}.elf> > ${NAME}.lst
    WORKING_DIRECTORY ./${SUBDIR}
    DEPENDS ${NAME}.elf)

  add_custom_target(${NAME}.annotate)
  add_custom_command(TARGET ${NAME}.annotate
    COMMAND  ${UTILS_DIR}/annotate.py ${NAME}.read
    WORKING_DIRECTORY ./${SUBDIR}
    DEPENDS ${NAME}.read)

  # add everything needed for simulation
  add_sim_targets(${NAME})

 if(ARG_LABELS)
    set_tests_properties(${NAME}.test PROPERTIES LABELS "${ARG_LABELS}")
  endif()

endmacro()

################################################################################
# boot code macro
# Attention: Every application name has to be unique and must have its own
#            build folder
################################################################################
macro(add_boot_code NAME SOURCE_FILES)

  # Compile boot code with RVC enabled
  set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -mrvc")

  # optional argument parsing
  set(oneValueArgs SUBDIR TB LABELS FLAGS)
  cmake_parse_arguments(ARG "${options}" "${oneValueArgs}" "" ${ARGN})
  set(SUBDIR ${ARG_SUBDIR})

  # OVERWRITE linker file for boot code!
  set(CMAKE_EXE_LINKER_FLAGS "${BOOT_LINKER_FLAGS}")

  # include_directories(
  #   ${CMAKE_SOURCE_DIR}/libs/sys_lib/inc
  # )

  add_executable(${NAME}.elf $<TARGET_OBJECTS:${BOOT_MODE}> ${SOURCE_FILES})  # Boot object substituted with ${BOOT_MODE}.  Simone Peraccini 29 Ottobre 2021

  # set subdirectory for add_executable
  if(NOT "${SUBDIR}" STREQUAL "")
    set_target_properties(${NAME}.elf PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${SUBDIR})
  endif()

  # set optional compile flags per application
  if(NOT "${ARG_FLAGS}" STREQUAL "")
    set_target_properties(${NAME}.elf PROPERTIES COMPILE_FLAGS ${ARG_FLAGS})
  endif()

  # # link libraries
  # target_link_libraries(${NAME}.elf sys)


  # this specifies the testbench to use for simulation
  if(ARG_TB)
    set_target_properties(${NAME}.elf PROPERTIES TB ${ARG_TB})
  else()
    set_target_properties(${NAME}.elf PROPERTIES TB run.tcl)
  endif()

  add_custom_target(${NAME}.read)
  add_custom_command(TARGET ${NAME}.read
    POST_BUILD
    COMMAND ${CMAKE_OBJDUMP} ${CMAKE_OBJDUMP_FLAGS} $<TARGET_FILE:${NAME}.elf> > ${NAME}.read
    WORKING_DIRECTORY ./${SUBDIR}
    DEPENDS ${NAME}.elf)

  # generate verilog and cde files
  file(MAKE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/${SUBDIR}/boot/)
  add_custom_command(OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/${SUBDIR}/boot/boot_code.sv
    COMMAND ${UTILS_DIR}/s19toboot.py ../${NAME}.s19
    #COMMAND cp boot_code.cde ${PULP_MODELSIM_DIRECTORY}/boot/

    WORKING_DIRECTORY ./${SUBDIR}/boot/
    DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/${SUBDIR}/${NAME}.s19)

  # add_custom_target(${NAME}.install
  #   COMMAND cp boot/boot_code.sv ${CMAKE_SOURCE_DIR}/../rtl/
  #   DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/${SUBDIR}/boot/boot_code.sv
  #   COMMENT STATUS "Copying boot code..."
  #   )


  # add everything needed for simulation
  add_sim_targets(${NAME})

  # if there are labels available for testing
  if(ARG_LABELS)
    set_tests_properties(${NAME}.test PROPERTIES LABELS "${ARG_LABELS}")
  endif()

endmacro()

################################################################################

# add_subdirectory(helloworld)


add_subdirectory(test_add)
add_subdirectory(test_dummy)
add_subdirectory(test_asm_arithmetic)
add_subdirectory(test_asm_branches)
add_subdirectory(test_asm_data_transfer)
add_subdirectory(test_asm_logical_shift_lui)
add_subdirectory(test_machine)
add_subdirectory(test_machine_user)


# if(${ARDUINO_LIB})
#   add_subdirectory(Arduino_tests)
# endif()

# add_subdirectory(bench)

# if(${BEEBS_LIB})
#   add_subdirectory(beebs)
# endif()

# if(${RISCY_RV32F})
#   add_subdirectory(ml_tests)
# endif()

# # RISCV only tests
# if(${RISCV})
#   #add_subdirectory(compressed)
#   add_subdirectory(fpga)
#   add_subdirectory(riscv_tests)
#   add_subdirectory(freertos)
#   add_subdirectory(boot_code)
# endif()
# add_subdirectory(sequential_tests)
# add_subdirectory(imperio_tests)

# if(IS_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/scratch/")
#   add_subdirectory(scratch)
# endif()
