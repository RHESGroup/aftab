# CMake generated Testfile for 
# Source directory: /home/user/Desktop/Thesis/aftab/sw/apps/riscv_tests/testIRQ
# Build directory: /home/user/Desktop/Thesis/aftab/sw/build/apps/riscv_tests/testIRQ
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(testIRQ.test "tcsh" "-c" "env VSIM_DIR=/home/user/Desktop/Thesis/aftab/vsim USE_ZERO_RISCY=1 RISCY_RV32F=0 ZERO_RV32M=1 ZERO_RV32E=0 PL_NETLIST= TB_TEST=\"\" /usr/local/modelsim/modelsim_ase/bin/vsim  -c -64 -do 'source tcl_files/run.tcl; run_and_exit;'")
set_tests_properties(testIRQ.test PROPERTIES  LABELS "riscv_tests" WORKING_DIRECTORY "/home/user/Desktop/Thesis/aftab/sw/build/apps/riscv_tests/testIRQ/" _BACKTRACE_TRIPLES "/home/user/Desktop/Thesis/aftab/sw/apps/CMakeSim.txt;235;add_test;/home/user/Desktop/Thesis/aftab/sw/apps/CMakeLists.txt;106;add_sim_targets;/home/user/Desktop/Thesis/aftab/sw/apps/riscv_tests/testIRQ/CMakeLists.txt;9;add_application;/home/user/Desktop/Thesis/aftab/sw/apps/riscv_tests/testIRQ/CMakeLists.txt;0;")