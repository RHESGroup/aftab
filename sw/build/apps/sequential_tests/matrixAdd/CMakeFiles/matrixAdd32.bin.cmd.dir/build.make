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

# Utility rule file for matrixAdd32.bin.cmd.

# Include the progress variables for this target.
include apps/sequential_tests/matrixAdd/CMakeFiles/matrixAdd32.bin.cmd.dir/progress.make

apps/sequential_tests/matrixAdd/CMakeFiles/matrixAdd32.bin.cmd: apps/sequential_tests/matrixAdd/matrixAdd32/matrixAdd32.bin


apps/sequential_tests/matrixAdd/matrixAdd32/matrixAdd32.bin: apps/sequential_tests/matrixAdd/matrixAdd32/matrixAdd32.elf
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/user/Desktop/Thesis/aftab/sw/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Generating matrixAdd32/matrixAdd32.bin"
	cd /home/user/Desktop/Thesis/aftab/sw/build/apps/sequential_tests/matrixAdd/matrixAdd32 && /opt/riscv/bin/riscv32-unknown-elf-objcopy -R .debug_frame -R .comment -R .stack -R .heapsram -R .heapscm -R .scmlock -O binary /home/user/Desktop/Thesis/aftab/sw/build/apps/sequential_tests/matrixAdd/matrixAdd32/matrixAdd32.elf matrixAdd32.bin

matrixAdd32.bin.cmd: apps/sequential_tests/matrixAdd/CMakeFiles/matrixAdd32.bin.cmd
matrixAdd32.bin.cmd: apps/sequential_tests/matrixAdd/matrixAdd32/matrixAdd32.bin
matrixAdd32.bin.cmd: apps/sequential_tests/matrixAdd/CMakeFiles/matrixAdd32.bin.cmd.dir/build.make

.PHONY : matrixAdd32.bin.cmd

# Rule to build all files generated by this target.
apps/sequential_tests/matrixAdd/CMakeFiles/matrixAdd32.bin.cmd.dir/build: matrixAdd32.bin.cmd

.PHONY : apps/sequential_tests/matrixAdd/CMakeFiles/matrixAdd32.bin.cmd.dir/build

apps/sequential_tests/matrixAdd/CMakeFiles/matrixAdd32.bin.cmd.dir/clean:
	cd /home/user/Desktop/Thesis/aftab/sw/build/apps/sequential_tests/matrixAdd && $(CMAKE_COMMAND) -P CMakeFiles/matrixAdd32.bin.cmd.dir/cmake_clean.cmake
.PHONY : apps/sequential_tests/matrixAdd/CMakeFiles/matrixAdd32.bin.cmd.dir/clean

apps/sequential_tests/matrixAdd/CMakeFiles/matrixAdd32.bin.cmd.dir/depend:
	cd /home/user/Desktop/Thesis/aftab/sw/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/user/Desktop/Thesis/aftab/sw /home/user/Desktop/Thesis/aftab/sw/apps/sequential_tests/matrixAdd /home/user/Desktop/Thesis/aftab/sw/build /home/user/Desktop/Thesis/aftab/sw/build/apps/sequential_tests/matrixAdd /home/user/Desktop/Thesis/aftab/sw/build/apps/sequential_tests/matrixAdd/CMakeFiles/matrixAdd32.bin.cmd.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : apps/sequential_tests/matrixAdd/CMakeFiles/matrixAdd32.bin.cmd.dir/depend
