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

# Utility rule file for helloworldcpp.kcg.

# Include the progress variables for this target.
include apps/helloworld/CMakeFiles/helloworldcpp.kcg.dir/progress.make

apps/helloworld/CMakeFiles/helloworldcpp.kcg:
	cd /home/user/Desktop/Thesis/aftab/sw/build/apps/helloworldcpp && pulp-pc-analyze --rtl --input=trace_core_00.log --binary=helloworldcpp.elf
	cd /home/user/Desktop/Thesis/aftab/sw/build/apps/helloworldcpp && kcachegrind kcg.txt

helloworldcpp.kcg: apps/helloworld/CMakeFiles/helloworldcpp.kcg
helloworldcpp.kcg: apps/helloworld/CMakeFiles/helloworldcpp.kcg.dir/build.make

.PHONY : helloworldcpp.kcg

# Rule to build all files generated by this target.
apps/helloworld/CMakeFiles/helloworldcpp.kcg.dir/build: helloworldcpp.kcg

.PHONY : apps/helloworld/CMakeFiles/helloworldcpp.kcg.dir/build

apps/helloworld/CMakeFiles/helloworldcpp.kcg.dir/clean:
	cd /home/user/Desktop/Thesis/aftab/sw/build/apps/helloworld && $(CMAKE_COMMAND) -P CMakeFiles/helloworldcpp.kcg.dir/cmake_clean.cmake
.PHONY : apps/helloworld/CMakeFiles/helloworldcpp.kcg.dir/clean

apps/helloworld/CMakeFiles/helloworldcpp.kcg.dir/depend:
	cd /home/user/Desktop/Thesis/aftab/sw/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/user/Desktop/Thesis/aftab/sw /home/user/Desktop/Thesis/aftab/sw/apps/helloworld /home/user/Desktop/Thesis/aftab/sw/build /home/user/Desktop/Thesis/aftab/sw/build/apps/helloworld /home/user/Desktop/Thesis/aftab/sw/build/apps/helloworld/CMakeFiles/helloworldcpp.kcg.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : apps/helloworld/CMakeFiles/helloworldcpp.kcg.dir/depend
