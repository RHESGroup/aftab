# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.19

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Disable VCS-based implicit rules.
% : %,v


# Disable VCS-based implicit rules.
% : RCS/%


# Disable VCS-based implicit rules.
% : RCS/%,v


# Disable VCS-based implicit rules.
% : SCCS/s.%


# Disable VCS-based implicit rules.
% : s.%


.SUFFIXES: .hpux_make_needs_suffix_list


# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /opt/customize/cmake/bin/cmake

# The command to remove a file.
RM = /opt/customize/cmake/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /media/sf_Shared/aftab/sw

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /media/sf_Shared/aftab/sw/build

# Utility rule file for test_add.bin.cmd.

# Include the progress variables for this target.
include apps/test_add/CMakeFiles/test_add.bin.cmd.dir/progress.make

apps/test_add/CMakeFiles/test_add.bin.cmd: apps/test_add/test_add.bin


apps/test_add/test_add.bin: apps/test_add/test_add.elf
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/media/sf_Shared/aftab/sw/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Generating test_add.bin"
	cd /media/sf_Shared/aftab/sw/build/apps/test_add && /opt/riscv/bin/riscv32-unknown-elf-objcopy -R .debug_frame -R .comment -R .stack -R .heapsram -R .heapscm -R .scmlock -O binary /media/sf_Shared/aftab/sw/build/apps/test_add/test_add.elf test_add.bin

test_add.bin.cmd: apps/test_add/CMakeFiles/test_add.bin.cmd
test_add.bin.cmd: apps/test_add/test_add.bin
test_add.bin.cmd: apps/test_add/CMakeFiles/test_add.bin.cmd.dir/build.make

.PHONY : test_add.bin.cmd

# Rule to build all files generated by this target.
apps/test_add/CMakeFiles/test_add.bin.cmd.dir/build: test_add.bin.cmd

.PHONY : apps/test_add/CMakeFiles/test_add.bin.cmd.dir/build

apps/test_add/CMakeFiles/test_add.bin.cmd.dir/clean:
	cd /media/sf_Shared/aftab/sw/build/apps/test_add && $(CMAKE_COMMAND) -P CMakeFiles/test_add.bin.cmd.dir/cmake_clean.cmake
.PHONY : apps/test_add/CMakeFiles/test_add.bin.cmd.dir/clean

apps/test_add/CMakeFiles/test_add.bin.cmd.dir/depend:
	cd /media/sf_Shared/aftab/sw/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /media/sf_Shared/aftab/sw /media/sf_Shared/aftab/sw/apps/test_add /media/sf_Shared/aftab/sw/build /media/sf_Shared/aftab/sw/build/apps/test_add /media/sf_Shared/aftab/sw/build/apps/test_add/CMakeFiles/test_add.bin.cmd.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : apps/test_add/CMakeFiles/test_add.bin.cmd.dir/depend

