# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.10

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
CMAKE_SOURCE_DIR = /media/sf_Shared/aftab/sw

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /media/sf_Shared/aftab/sw/build

# Utility rule file for test_asm.

# Include the progress variables for this target.
include apps/test_asm/CMakeFiles/test_asm.dir/progress.make

apps/test_asm/CMakeFiles/test_asm:


test_asm: apps/test_asm/CMakeFiles/test_asm
test_asm: apps/test_asm/CMakeFiles/test_asm.dir/build.make

.PHONY : test_asm

# Rule to build all files generated by this target.
apps/test_asm/CMakeFiles/test_asm.dir/build: test_asm

.PHONY : apps/test_asm/CMakeFiles/test_asm.dir/build

apps/test_asm/CMakeFiles/test_asm.dir/clean:
	cd /media/sf_Shared/aftab/sw/build/apps/test_asm && $(CMAKE_COMMAND) -P CMakeFiles/test_asm.dir/cmake_clean.cmake
.PHONY : apps/test_asm/CMakeFiles/test_asm.dir/clean

apps/test_asm/CMakeFiles/test_asm.dir/depend:
	cd /media/sf_Shared/aftab/sw/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /media/sf_Shared/aftab/sw /media/sf_Shared/aftab/sw/apps/test_asm /media/sf_Shared/aftab/sw/build /media/sf_Shared/aftab/sw/build/apps/test_asm /media/sf_Shared/aftab/sw/build/apps/test_asm/CMakeFiles/test_asm.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : apps/test_asm/CMakeFiles/test_asm.dir/depend
