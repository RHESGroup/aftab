# CMake generated Testfile for 
# Source directory: /home/user/Desktop/Thesis/aftab/sw/apps/user_apps/user_app0
# Build directory: /home/user/Desktop/Thesis/aftab/sw/build/apps/user_apps/user_app0
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(user_app0.test "tcsh" "-c" "env VSIM_DIR=/home/user/Desktop/Thesis/aftab/vsim USE_ZERO_RISCY=1 RISCY_RV32F=0 ZERO_RV32M=1 ZERO_RV32E=0 PL_NETLIST= TB_TEST=\"\" /usr/local/modelsim/modelsim_ase/bin/vsim  -c -64 -do 'source tcl_files/run.tcl; run_and_exit;'")
set_tests_properties(user_app0.test PROPERTIES  WORKING_DIRECTORY "/home/user/Desktop/Thesis/aftab/sw/build/apps/user_apps/user_app0/" _BACKTRACE_TRIPLES "/home/user/Desktop/Thesis/aftab/sw/apps/CMakeSim.txt;235;add_test;/home/user/Desktop/Thesis/aftab/sw/apps/CMakeLists.txt;106;add_sim_targets;/home/user/Desktop/Thesis/aftab/sw/apps/user_apps/user_app0/CMakeLists.txt;1;add_application;/home/user/Desktop/Thesis/aftab/sw/apps/user_apps/user_app0/CMakeLists.txt;0;")
add_test(user_app0cpp.test "tcsh" "-c" "env VSIM_DIR=/home/user/Desktop/Thesis/aftab/vsim USE_ZERO_RISCY=1 RISCY_RV32F=0 ZERO_RV32M=1 ZERO_RV32E=0 PL_NETLIST= TB_TEST=\"\" /usr/local/modelsim/modelsim_ase/bin/vsim  -c -64 -do 'source tcl_files/run.tcl; run_and_exit;'")
set_tests_properties(user_app0cpp.test PROPERTIES  WORKING_DIRECTORY "/home/user/Desktop/Thesis/aftab/sw/build/apps/user_apps/user_app0/../user_app0cpp" _BACKTRACE_TRIPLES "/home/user/Desktop/Thesis/aftab/sw/apps/CMakeSim.txt;235;add_test;/home/user/Desktop/Thesis/aftab/sw/apps/CMakeLists.txt;106;add_sim_targets;/home/user/Desktop/Thesis/aftab/sw/apps/user_apps/user_app0/CMakeLists.txt;3;add_application;/home/user/Desktop/Thesis/aftab/sw/apps/user_apps/user_app0/CMakeLists.txt;0;")
