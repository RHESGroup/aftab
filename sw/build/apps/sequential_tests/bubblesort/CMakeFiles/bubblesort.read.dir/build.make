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

# Utility rule file for bubblesort.read.

# Include the progress variables for this target.
include apps/sequential_tests/bubblesort/CMakeFiles/bubblesort.read.dir/progress.make

bubblesort.read: apps/sequential_tests/bubblesort/CMakeFiles/bubblesort.read.dir/build.make
	cd /home/user/Desktop/Thesis/aftab/sw/build/apps/sequential_tests/bubblesort && /opt/riscv/bin/riscv32-unknown-elf-objdump -Mmarch=rv32im -d /home/user/Desktop/Thesis/aftab/sw/build/apps/sequential_tests/bubblesort/bubblesort.elf > bubblesort.read
.PHONY : bubblesort.read

# Rule to build all files generated by this target.
apps/sequential_tests/bubblesort/CMakeFiles/bubblesort.read.dir/build: bubblesort.read

.PHONY : apps/sequential_tests/bubblesort/CMakeFiles/bubblesort.read.dir/build

apps/sequential_tests/bubblesort/CMakeFiles/bubblesort.read.dir/clean:
	cd /home/user/Desktop/Thesis/aftab/sw/build/apps/sequential_tests/bubblesort && $(CMAKE_COMMAND) -P CMakeFiles/bubblesort.read.dir/cmake_clean.cmake
.PHONY : apps/sequential_tests/bubblesort/CMakeFiles/bubblesort.read.dir/clean

apps/sequential_tests/bubblesort/CMakeFiles/bubblesort.read.dir/depend:
	cd /home/user/Desktop/Thesis/aftab/sw/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/user/Desktop/Thesis/aftab/sw /home/user/Desktop/Thesis/aftab/sw/apps/sequential_tests/bubblesort /home/user/Desktop/Thesis/aftab/sw/build /home/user/Desktop/Thesis/aftab/sw/build/apps/sequential_tests/bubblesort /home/user/Desktop/Thesis/aftab/sw/build/apps/sequential_tests/bubblesort/CMakeFiles/bubblesort.read.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : apps/sequential_tests/bubblesort/CMakeFiles/bubblesort.read.dir/depend
