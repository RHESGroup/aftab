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

# Utility rule file for testEvents.bin.cmd.

# Include the progress variables for this target.
include apps/riscv_tests/testEvents/CMakeFiles/testEvents.bin.cmd.dir/progress.make

apps/riscv_tests/testEvents/CMakeFiles/testEvents.bin.cmd: apps/riscv_tests/testEvents/testEvents.bin


apps/riscv_tests/testEvents/testEvents.bin: apps/riscv_tests/testEvents/testEvents.elf
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/user/Desktop/Thesis/aftab/sw/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Generating testEvents.bin"
	cd /home/user/Desktop/Thesis/aftab/sw/build/apps/riscv_tests/testEvents && /opt/riscv/bin/riscv32-unknown-elf-objcopy -R .debug_frame -R .comment -R .stack -R .heapsram -R .heapscm -R .scmlock -O binary /home/user/Desktop/Thesis/aftab/sw/build/apps/riscv_tests/testEvents/testEvents.elf testEvents.bin

testEvents.bin.cmd: apps/riscv_tests/testEvents/CMakeFiles/testEvents.bin.cmd
testEvents.bin.cmd: apps/riscv_tests/testEvents/testEvents.bin
testEvents.bin.cmd: apps/riscv_tests/testEvents/CMakeFiles/testEvents.bin.cmd.dir/build.make

.PHONY : testEvents.bin.cmd

# Rule to build all files generated by this target.
apps/riscv_tests/testEvents/CMakeFiles/testEvents.bin.cmd.dir/build: testEvents.bin.cmd

.PHONY : apps/riscv_tests/testEvents/CMakeFiles/testEvents.bin.cmd.dir/build

apps/riscv_tests/testEvents/CMakeFiles/testEvents.bin.cmd.dir/clean:
	cd /home/user/Desktop/Thesis/aftab/sw/build/apps/riscv_tests/testEvents && $(CMAKE_COMMAND) -P CMakeFiles/testEvents.bin.cmd.dir/cmake_clean.cmake
.PHONY : apps/riscv_tests/testEvents/CMakeFiles/testEvents.bin.cmd.dir/clean

apps/riscv_tests/testEvents/CMakeFiles/testEvents.bin.cmd.dir/depend:
	cd /home/user/Desktop/Thesis/aftab/sw/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/user/Desktop/Thesis/aftab/sw /home/user/Desktop/Thesis/aftab/sw/apps/riscv_tests/testEvents /home/user/Desktop/Thesis/aftab/sw/build /home/user/Desktop/Thesis/aftab/sw/build/apps/riscv_tests/testEvents /home/user/Desktop/Thesis/aftab/sw/build/apps/riscv_tests/testEvents/CMakeFiles/testEvents.bin.cmd.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : apps/riscv_tests/testEvents/CMakeFiles/testEvents.bin.cmd.dir/depend
