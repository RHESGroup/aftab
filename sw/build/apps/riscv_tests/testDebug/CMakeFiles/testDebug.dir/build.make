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
CMAKE_SOURCE_DIR = /home/user/Desktop/Thesis/mc2101/sw

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/user/Desktop/Thesis/mc2101/sw/build

# Utility rule file for testDebug.

# Include the progress variables for this target.
include apps/riscv_tests/testDebug/CMakeFiles/testDebug.dir/progress.make

apps/riscv_tests/testDebug/CMakeFiles/testDebug:


testDebug: apps/riscv_tests/testDebug/CMakeFiles/testDebug
testDebug: apps/riscv_tests/testDebug/CMakeFiles/testDebug.dir/build.make

.PHONY : testDebug

# Rule to build all files generated by this target.
apps/riscv_tests/testDebug/CMakeFiles/testDebug.dir/build: testDebug

.PHONY : apps/riscv_tests/testDebug/CMakeFiles/testDebug.dir/build

apps/riscv_tests/testDebug/CMakeFiles/testDebug.dir/clean:
	cd /home/user/Desktop/Thesis/mc2101/sw/build/apps/riscv_tests/testDebug && $(CMAKE_COMMAND) -P CMakeFiles/testDebug.dir/cmake_clean.cmake
.PHONY : apps/riscv_tests/testDebug/CMakeFiles/testDebug.dir/clean

apps/riscv_tests/testDebug/CMakeFiles/testDebug.dir/depend:
	cd /home/user/Desktop/Thesis/mc2101/sw/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/user/Desktop/Thesis/mc2101/sw /home/user/Desktop/Thesis/mc2101/sw/apps/riscv_tests/testDebug /home/user/Desktop/Thesis/mc2101/sw/build /home/user/Desktop/Thesis/mc2101/sw/build/apps/riscv_tests/testDebug /home/user/Desktop/Thesis/mc2101/sw/build/apps/riscv_tests/testDebug/CMakeFiles/testDebug.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : apps/riscv_tests/testDebug/CMakeFiles/testDebug.dir/depend
