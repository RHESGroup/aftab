# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.16

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/user/Desktop/Thesis/aftab/sw

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/user/Desktop/Thesis/aftab/sw/build

# Utility rule file for testCSR.kcg.

# Include the progress variables for this target.
include apps/riscv_tests/testCSR/CMakeFiles/testCSR.kcg.dir/progress.make

apps/riscv_tests/testCSR/CMakeFiles/testCSR.kcg:
	cd /home/user/Desktop/Thesis/aftab/sw/build/apps/riscv_tests/testCSR && pulp-pc-analyze --rtl --input=trace_core_00.log --binary=testCSR.elf
	cd /home/user/Desktop/Thesis/aftab/sw/build/apps/riscv_tests/testCSR && kcachegrind kcg.txt

testCSR.kcg: apps/riscv_tests/testCSR/CMakeFiles/testCSR.kcg
testCSR.kcg: apps/riscv_tests/testCSR/CMakeFiles/testCSR.kcg.dir/build.make

.PHONY : testCSR.kcg

# Rule to build all files generated by this target.
apps/riscv_tests/testCSR/CMakeFiles/testCSR.kcg.dir/build: testCSR.kcg

.PHONY : apps/riscv_tests/testCSR/CMakeFiles/testCSR.kcg.dir/build

apps/riscv_tests/testCSR/CMakeFiles/testCSR.kcg.dir/clean:
	cd /home/user/Desktop/Thesis/aftab/sw/build/apps/riscv_tests/testCSR && $(CMAKE_COMMAND) -P CMakeFiles/testCSR.kcg.dir/cmake_clean.cmake
.PHONY : apps/riscv_tests/testCSR/CMakeFiles/testCSR.kcg.dir/clean

apps/riscv_tests/testCSR/CMakeFiles/testCSR.kcg.dir/depend:
	cd /home/user/Desktop/Thesis/aftab/sw/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/user/Desktop/Thesis/aftab/sw /home/user/Desktop/Thesis/aftab/sw/apps/riscv_tests/testCSR /home/user/Desktop/Thesis/aftab/sw/build /home/user/Desktop/Thesis/aftab/sw/build/apps/riscv_tests/testCSR /home/user/Desktop/Thesis/aftab/sw/build/apps/riscv_tests/testCSR/CMakeFiles/testCSR.kcg.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : apps/riscv_tests/testCSR/CMakeFiles/testCSR.kcg.dir/depend
