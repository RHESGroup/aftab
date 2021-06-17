vsim work.tb_aftab
add wave -position end  sim:/tb_aftab/clk_s
add wave -position end  sim:/tb_aftab/rst_s
add wave -position end  sim:/tb_aftab/aftab_ut/controllerAFTAB/p_state
add wave -position end  sim:/tb_aftab/aftab_ut/datapathAFTAB/regPC/outReg
add wave -position end  sim:/tb_aftab/aftab_ut/datapathAFTAB/IR
add wave -position end  sim:/tb_aftab/aftab_ut/datapathAFTAB/registerFile/REGISTERS

run 1000 ns
