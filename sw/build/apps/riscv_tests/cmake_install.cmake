# Install script for directory: /home/user/Desktop/Thesis/aftab/sw/apps/riscv_tests

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "TRUE")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/home/user/Desktop/Thesis/aftab/sw/build/apps/riscv_tests/basic/cmake_install.cmake")
  include("/home/user/Desktop/Thesis/aftab/sw/build/apps/riscv_tests/official/cmake_install.cmake")
  include("/home/user/Desktop/Thesis/aftab/sw/build/apps/riscv_tests/testMisaligned/cmake_install.cmake")
  include("/home/user/Desktop/Thesis/aftab/sw/build/apps/riscv_tests/testEvents/cmake_install.cmake")
  include("/home/user/Desktop/Thesis/aftab/sw/build/apps/riscv_tests/testExceptions/cmake_install.cmake")
  include("/home/user/Desktop/Thesis/aftab/sw/build/apps/riscv_tests/testIRQ/cmake_install.cmake")
  include("/home/user/Desktop/Thesis/aftab/sw/build/apps/riscv_tests/testALU/cmake_install.cmake")
  include("/home/user/Desktop/Thesis/aftab/sw/build/apps/riscv_tests/testALUExt/cmake_install.cmake")
  include("/home/user/Desktop/Thesis/aftab/sw/build/apps/riscv_tests/testMUL/cmake_install.cmake")
  include("/home/user/Desktop/Thesis/aftab/sw/build/apps/riscv_tests/testDivRem/cmake_install.cmake")
  include("/home/user/Desktop/Thesis/aftab/sw/build/apps/riscv_tests/testFPU/cmake_install.cmake")
  include("/home/user/Desktop/Thesis/aftab/sw/build/apps/riscv_tests/testBitManipulation/cmake_install.cmake")
  include("/home/user/Desktop/Thesis/aftab/sw/build/apps/riscv_tests/testCnt/cmake_install.cmake")
  include("/home/user/Desktop/Thesis/aftab/sw/build/apps/riscv_tests/testClip/cmake_install.cmake")
  include("/home/user/Desktop/Thesis/aftab/sw/build/apps/riscv_tests/testVecArith/cmake_install.cmake")
  include("/home/user/Desktop/Thesis/aftab/sw/build/apps/riscv_tests/testVecCmp/cmake_install.cmake")
  include("/home/user/Desktop/Thesis/aftab/sw/build/apps/riscv_tests/testShufflePack/cmake_install.cmake")
  include("/home/user/Desktop/Thesis/aftab/sw/build/apps/riscv_tests/testAddSubNorm/cmake_install.cmake")
  include("/home/user/Desktop/Thesis/aftab/sw/build/apps/riscv_tests/testMacNorm/cmake_install.cmake")
  include("/home/user/Desktop/Thesis/aftab/sw/build/apps/riscv_tests/testDotMul/cmake_install.cmake")
  include("/home/user/Desktop/Thesis/aftab/sw/build/apps/riscv_tests/testCSR/cmake_install.cmake")

endif()

