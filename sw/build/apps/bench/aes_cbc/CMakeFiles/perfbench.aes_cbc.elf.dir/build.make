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

# Include any dependencies generated for this target.
include apps/bench/aes_cbc/CMakeFiles/perfbench.aes_cbc.elf.dir/depend.make

# Include the progress variables for this target.
include apps/bench/aes_cbc/CMakeFiles/perfbench.aes_cbc.elf.dir/progress.make

# Include the compile flags for this target's objects.
include apps/bench/aes_cbc/CMakeFiles/perfbench.aes_cbc.elf.dir/flags.make

apps/bench/aes_cbc/CMakeFiles/perfbench.aes_cbc.elf.dir/aes_cbc.c.o: apps/bench/aes_cbc/CMakeFiles/perfbench.aes_cbc.elf.dir/flags.make
apps/bench/aes_cbc/CMakeFiles/perfbench.aes_cbc.elf.dir/aes_cbc.c.o: ../apps/bench/aes_cbc/aes_cbc.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/user/Desktop/Thesis/aftab/sw/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object apps/bench/aes_cbc/CMakeFiles/perfbench.aes_cbc.elf.dir/aes_cbc.c.o"
	cd /home/user/Desktop/Thesis/aftab/sw/build/apps/bench/aes_cbc && /opt/riscv/bin/riscv32-unknown-elf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/perfbench.aes_cbc.elf.dir/aes_cbc.c.o   -c /home/user/Desktop/Thesis/aftab/sw/apps/bench/aes_cbc/aes_cbc.c

apps/bench/aes_cbc/CMakeFiles/perfbench.aes_cbc.elf.dir/aes_cbc.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/perfbench.aes_cbc.elf.dir/aes_cbc.c.i"
	cd /home/user/Desktop/Thesis/aftab/sw/build/apps/bench/aes_cbc && /opt/riscv/bin/riscv32-unknown-elf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/user/Desktop/Thesis/aftab/sw/apps/bench/aes_cbc/aes_cbc.c > CMakeFiles/perfbench.aes_cbc.elf.dir/aes_cbc.c.i

apps/bench/aes_cbc/CMakeFiles/perfbench.aes_cbc.elf.dir/aes_cbc.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/perfbench.aes_cbc.elf.dir/aes_cbc.c.s"
	cd /home/user/Desktop/Thesis/aftab/sw/build/apps/bench/aes_cbc && /opt/riscv/bin/riscv32-unknown-elf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/user/Desktop/Thesis/aftab/sw/apps/bench/aes_cbc/aes_cbc.c -o CMakeFiles/perfbench.aes_cbc.elf.dir/aes_cbc.c.s

apps/bench/aes_cbc/CMakeFiles/perfbench.aes_cbc.elf.dir/aes_cbc_test.c.o: apps/bench/aes_cbc/CMakeFiles/perfbench.aes_cbc.elf.dir/flags.make
apps/bench/aes_cbc/CMakeFiles/perfbench.aes_cbc.elf.dir/aes_cbc_test.c.o: ../apps/bench/aes_cbc/aes_cbc_test.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/user/Desktop/Thesis/aftab/sw/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object apps/bench/aes_cbc/CMakeFiles/perfbench.aes_cbc.elf.dir/aes_cbc_test.c.o"
	cd /home/user/Desktop/Thesis/aftab/sw/build/apps/bench/aes_cbc && /opt/riscv/bin/riscv32-unknown-elf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/perfbench.aes_cbc.elf.dir/aes_cbc_test.c.o   -c /home/user/Desktop/Thesis/aftab/sw/apps/bench/aes_cbc/aes_cbc_test.c

apps/bench/aes_cbc/CMakeFiles/perfbench.aes_cbc.elf.dir/aes_cbc_test.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/perfbench.aes_cbc.elf.dir/aes_cbc_test.c.i"
	cd /home/user/Desktop/Thesis/aftab/sw/build/apps/bench/aes_cbc && /opt/riscv/bin/riscv32-unknown-elf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/user/Desktop/Thesis/aftab/sw/apps/bench/aes_cbc/aes_cbc_test.c > CMakeFiles/perfbench.aes_cbc.elf.dir/aes_cbc_test.c.i

apps/bench/aes_cbc/CMakeFiles/perfbench.aes_cbc.elf.dir/aes_cbc_test.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/perfbench.aes_cbc.elf.dir/aes_cbc_test.c.s"
	cd /home/user/Desktop/Thesis/aftab/sw/build/apps/bench/aes_cbc && /opt/riscv/bin/riscv32-unknown-elf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/user/Desktop/Thesis/aftab/sw/apps/bench/aes_cbc/aes_cbc_test.c -o CMakeFiles/perfbench.aes_cbc.elf.dir/aes_cbc_test.c.s

# Object files for target perfbench.aes_cbc.elf
perfbench_aes_cbc_elf_OBJECTS = \
"CMakeFiles/perfbench.aes_cbc.elf.dir/aes_cbc.c.o" \
"CMakeFiles/perfbench.aes_cbc.elf.dir/aes_cbc_test.c.o"

# External object files for target perfbench.aes_cbc.elf
perfbench_aes_cbc_elf_EXTERNAL_OBJECTS = \
"/home/user/Desktop/Thesis/aftab/sw/build/CMakeFiles/crt0.dir/ref/crt0.riscv.S.o"

apps/bench/aes_cbc/perfbench.aes_cbc.elf: apps/bench/aes_cbc/CMakeFiles/perfbench.aes_cbc.elf.dir/aes_cbc.c.o
apps/bench/aes_cbc/perfbench.aes_cbc.elf: apps/bench/aes_cbc/CMakeFiles/perfbench.aes_cbc.elf.dir/aes_cbc_test.c.o
apps/bench/aes_cbc/perfbench.aes_cbc.elf: CMakeFiles/crt0.dir/ref/crt0.riscv.S.o
apps/bench/aes_cbc/perfbench.aes_cbc.elf: apps/bench/aes_cbc/CMakeFiles/perfbench.aes_cbc.elf.dir/build.make
apps/bench/aes_cbc/perfbench.aes_cbc.elf: apps/bench/libperfbench.core.a
apps/bench/aes_cbc/perfbench.aes_cbc.elf: libs/bench_lib/libbench.a
apps/bench/aes_cbc/perfbench.aes_cbc.elf: libs/string_lib/libstring.a
apps/bench/aes_cbc/perfbench.aes_cbc.elf: libs/sys_lib/libsys.a
apps/bench/aes_cbc/perfbench.aes_cbc.elf: apps/bench/aes_cbc/CMakeFiles/perfbench.aes_cbc.elf.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/user/Desktop/Thesis/aftab/sw/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Linking C executable perfbench.aes_cbc.elf"
	cd /home/user/Desktop/Thesis/aftab/sw/build/apps/bench/aes_cbc && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/perfbench.aes_cbc.elf.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
apps/bench/aes_cbc/CMakeFiles/perfbench.aes_cbc.elf.dir/build: apps/bench/aes_cbc/perfbench.aes_cbc.elf

.PHONY : apps/bench/aes_cbc/CMakeFiles/perfbench.aes_cbc.elf.dir/build

apps/bench/aes_cbc/CMakeFiles/perfbench.aes_cbc.elf.dir/clean:
	cd /home/user/Desktop/Thesis/aftab/sw/build/apps/bench/aes_cbc && $(CMAKE_COMMAND) -P CMakeFiles/perfbench.aes_cbc.elf.dir/cmake_clean.cmake
.PHONY : apps/bench/aes_cbc/CMakeFiles/perfbench.aes_cbc.elf.dir/clean

apps/bench/aes_cbc/CMakeFiles/perfbench.aes_cbc.elf.dir/depend:
	cd /home/user/Desktop/Thesis/aftab/sw/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/user/Desktop/Thesis/aftab/sw /home/user/Desktop/Thesis/aftab/sw/apps/bench/aes_cbc /home/user/Desktop/Thesis/aftab/sw/build /home/user/Desktop/Thesis/aftab/sw/build/apps/bench/aes_cbc /home/user/Desktop/Thesis/aftab/sw/build/apps/bench/aes_cbc/CMakeFiles/perfbench.aes_cbc.elf.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : apps/bench/aes_cbc/CMakeFiles/perfbench.aes_cbc.elf.dir/depend
