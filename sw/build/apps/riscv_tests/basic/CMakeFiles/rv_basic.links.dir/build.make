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

# Utility rule file for rv_basic.links.

# Include the progress variables for this target.
include apps/riscv_tests/basic/CMakeFiles/rv_basic.links.dir/progress.make

apps/riscv_tests/basic/CMakeFiles/rv_basic.links: apps/riscv_tests/basic/modelsim.ini
apps/riscv_tests/basic/CMakeFiles/rv_basic.links: apps/riscv_tests/basic/work
apps/riscv_tests/basic/CMakeFiles/rv_basic.links: apps/riscv_tests/basic/tcl_files
apps/riscv_tests/basic/CMakeFiles/rv_basic.links: apps/riscv_tests/basic/waves


apps/riscv_tests/basic/modelsim.ini:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/user/Desktop/Thesis/aftab/sw/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Generating modelsim.ini"
	cd /home/user/Desktop/Thesis/aftab/sw/build/apps/riscv_tests/basic && /usr/bin/cmake -E create_symlink /home/user/Desktop/Thesis/aftab/vsim/modelsim.ini /home/user/Desktop/Thesis/aftab/sw/build/apps/riscv_tests/basic//modelsim.ini

apps/riscv_tests/basic/work:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/user/Desktop/Thesis/aftab/sw/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Generating work"
	cd /home/user/Desktop/Thesis/aftab/sw/build/apps/riscv_tests/basic && /usr/bin/cmake -E create_symlink /home/user/Desktop/Thesis/aftab/vsim/work /home/user/Desktop/Thesis/aftab/sw/build/apps/riscv_tests/basic//work

apps/riscv_tests/basic/tcl_files:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/user/Desktop/Thesis/aftab/sw/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Generating tcl_files"
	cd /home/user/Desktop/Thesis/aftab/sw/build/apps/riscv_tests/basic && /usr/bin/cmake -E create_symlink /home/user/Desktop/Thesis/aftab/vsim/tcl_files /home/user/Desktop/Thesis/aftab/sw/build/apps/riscv_tests/basic//tcl_files

apps/riscv_tests/basic/waves:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/user/Desktop/Thesis/aftab/sw/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Generating waves"
	cd /home/user/Desktop/Thesis/aftab/sw/build/apps/riscv_tests/basic && /usr/bin/cmake -E create_symlink /home/user/Desktop/Thesis/aftab/vsim/waves /home/user/Desktop/Thesis/aftab/sw/build/apps/riscv_tests/basic//waves

rv_basic.links: apps/riscv_tests/basic/CMakeFiles/rv_basic.links
rv_basic.links: apps/riscv_tests/basic/modelsim.ini
rv_basic.links: apps/riscv_tests/basic/work
rv_basic.links: apps/riscv_tests/basic/tcl_files
rv_basic.links: apps/riscv_tests/basic/waves
rv_basic.links: apps/riscv_tests/basic/CMakeFiles/rv_basic.links.dir/build.make

.PHONY : rv_basic.links

# Rule to build all files generated by this target.
apps/riscv_tests/basic/CMakeFiles/rv_basic.links.dir/build: rv_basic.links

.PHONY : apps/riscv_tests/basic/CMakeFiles/rv_basic.links.dir/build

apps/riscv_tests/basic/CMakeFiles/rv_basic.links.dir/clean:
	cd /home/user/Desktop/Thesis/aftab/sw/build/apps/riscv_tests/basic && $(CMAKE_COMMAND) -P CMakeFiles/rv_basic.links.dir/cmake_clean.cmake
.PHONY : apps/riscv_tests/basic/CMakeFiles/rv_basic.links.dir/clean

apps/riscv_tests/basic/CMakeFiles/rv_basic.links.dir/depend:
	cd /home/user/Desktop/Thesis/aftab/sw/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/user/Desktop/Thesis/aftab/sw /home/user/Desktop/Thesis/aftab/sw/apps/riscv_tests/basic /home/user/Desktop/Thesis/aftab/sw/build /home/user/Desktop/Thesis/aftab/sw/build/apps/riscv_tests/basic /home/user/Desktop/Thesis/aftab/sw/build/apps/riscv_tests/basic/CMakeFiles/rv_basic.links.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : apps/riscv_tests/basic/CMakeFiles/rv_basic.links.dir/depend
