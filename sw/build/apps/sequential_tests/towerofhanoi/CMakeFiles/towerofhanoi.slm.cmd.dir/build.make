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

# Utility rule file for towerofhanoi.slm.cmd.

# Include the progress variables for this target.
include apps/sequential_tests/towerofhanoi/CMakeFiles/towerofhanoi.slm.cmd.dir/progress.make

apps/sequential_tests/towerofhanoi/CMakeFiles/towerofhanoi.slm.cmd: apps/sequential_tests/towerofhanoi/slm_files/l2_ram.slm


apps/sequential_tests/towerofhanoi/slm_files/l2_ram.slm: apps/sequential_tests/towerofhanoi/towerofhanoi.s19
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/user/Desktop/Thesis/aftab/sw/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Generating slm_files/l2_ram.slm"
	cd /home/user/Desktop/Thesis/aftab/sw/build/apps/sequential_tests/towerofhanoi/slm_files && /home/user/Desktop/Thesis/aftab/sw/utils/s19toslm.py ../towerofhanoi.s19
	cd /home/user/Desktop/Thesis/aftab/sw/build/apps/sequential_tests/towerofhanoi/slm_files && /usr/bin/cmake -E touch l2_ram.slm

apps/sequential_tests/towerofhanoi/towerofhanoi.s19: apps/sequential_tests/towerofhanoi/towerofhanoi.elf
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/user/Desktop/Thesis/aftab/sw/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Generating towerofhanoi.s19"
	cd /home/user/Desktop/Thesis/aftab/sw/build/apps/sequential_tests/towerofhanoi && /opt/riscv/bin/riscv32-unknown-elf-objcopy --srec-len 1 --output-target=srec /home/user/Desktop/Thesis/aftab/sw/build/apps/sequential_tests/towerofhanoi/towerofhanoi.elf towerofhanoi.s19

towerofhanoi.slm.cmd: apps/sequential_tests/towerofhanoi/CMakeFiles/towerofhanoi.slm.cmd
towerofhanoi.slm.cmd: apps/sequential_tests/towerofhanoi/slm_files/l2_ram.slm
towerofhanoi.slm.cmd: apps/sequential_tests/towerofhanoi/towerofhanoi.s19
towerofhanoi.slm.cmd: apps/sequential_tests/towerofhanoi/CMakeFiles/towerofhanoi.slm.cmd.dir/build.make

.PHONY : towerofhanoi.slm.cmd

# Rule to build all files generated by this target.
apps/sequential_tests/towerofhanoi/CMakeFiles/towerofhanoi.slm.cmd.dir/build: towerofhanoi.slm.cmd

.PHONY : apps/sequential_tests/towerofhanoi/CMakeFiles/towerofhanoi.slm.cmd.dir/build

apps/sequential_tests/towerofhanoi/CMakeFiles/towerofhanoi.slm.cmd.dir/clean:
	cd /home/user/Desktop/Thesis/aftab/sw/build/apps/sequential_tests/towerofhanoi && $(CMAKE_COMMAND) -P CMakeFiles/towerofhanoi.slm.cmd.dir/cmake_clean.cmake
.PHONY : apps/sequential_tests/towerofhanoi/CMakeFiles/towerofhanoi.slm.cmd.dir/clean

apps/sequential_tests/towerofhanoi/CMakeFiles/towerofhanoi.slm.cmd.dir/depend:
	cd /home/user/Desktop/Thesis/aftab/sw/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/user/Desktop/Thesis/aftab/sw /home/user/Desktop/Thesis/aftab/sw/apps/sequential_tests/towerofhanoi /home/user/Desktop/Thesis/aftab/sw/build /home/user/Desktop/Thesis/aftab/sw/build/apps/sequential_tests/towerofhanoi /home/user/Desktop/Thesis/aftab/sw/build/apps/sequential_tests/towerofhanoi/CMakeFiles/towerofhanoi.slm.cmd.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : apps/sequential_tests/towerofhanoi/CMakeFiles/towerofhanoi.slm.cmd.dir/depend
