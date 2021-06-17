# CMake generated Testfile for 
# Source directory: /home/user/Desktop/Thesis/mc2101/sw/apps/riscv_tests/testDebug
# Build directory: /home/user/Desktop/Thesis/mc2101/sw/build/apps/riscv_tests/testDebug
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(testDebug.test "tcsh" "-c" "env VSIM_DIR=/home/user/Desktop/Thesis/mc2101/vsim USE_ZERO_RISCY=1 RISCY_RV32F=0 ZERO_RV32M=1 ZERO_RV32E=0 PL_NETLIST= TB_TEST=\"\" /usr/local/modelsim/modelsim_ase/bin/vsim  -c -64 -do 'source tcl_files/run_debug.tcl; run_and_exit;'")
set_tests_properties(testDebug.test PROPERTIES  LABELS "riscv_tests" WORKING_DIRECTORY "/home/user/Desktop/Thesis/mc2101/sw/build/apps/riscv_tests/testDebug/" _BACKTRACE_TRIPLES "/home/user/Desktop/Thesis/mc2101/sw/apps/CMakeSim.txt;235;add_test;/home/user/Desktop/Thesis/mc2101/sw/apps/CMakeLists.txt;106;add_sim_targets;/home/user/Desktop/Thesis/mc2101/sw/apps/riscv_tests/testDebug/CMakeLists.txt;9;add_application;/home/user/Desktop/Thesis/mc2101/sw/apps/riscv_tests/testDebug/CMakeLists.txt;0;")
