## Simple script for hierarchical compilation of the aftab_core

vcom -reportprogress 300 -work work ./datapath/aftab_register.vhd
vcom -reportprogress 300 -work work ./datapath/aftab_multiplexer.vhd
vcom -reportprogress 300 -work work ./datapath/aftab_comparator.vhd 
vcom -reportprogress 300 -work work ./datapath/aftab_counter.vhd 
vcom -reportprogress 300 -work work ./datapath/aftab_imm_sel_sign_ext.vhd
vcom -reportprogress 300 -work work ./datapath/aftab_adder.vhd
vcom -reportprogress 300 -work work ./datapath/aftab_adder_subtractor.vhd 
vcom -reportprogress 300 -work work ./datapath/aftab_barrel_shifter.vhd 
vcom -reportprogress 300 -work work ./datapath/aftab_llu.vhd
vcom -reportprogress 300 -work work ./datapath/aftab_sulu.vhd
vcom -reportprogress 300 -work work ./datapath/aftab_register_file.vhd
vcom -reportprogress 300 -work work ./datapath/aftab_aau/aftab_booth_multiplier/aftab_booth_multiplier_controller.vhd
vcom -reportprogress 300 -work work ./datapath/aftab_aau/aftab_booth_multiplier/aftab_booth_multiplier_datapath.vhd
vcom -reportprogress 300 -work work ./datapath/aftab_aau/aftab_booth_multiplier/aftab_booth_multiplier.vhd
vcom -reportprogress 300 -work work ./datapath/aftab_aau/aftab_su_divider/aftab_divider_controller.vhd
vcom -reportprogress 300 -work work ./datapath/aftab_aau/aftab_su_divider/aftab_divider_datapath.vhd
vcom -reportprogress 300 -work work ./datapath/aftab_aau/aftab_su_divider/aftab_divider.vhd
vcom -reportprogress 300 -work work ./datapath/aftab_aau/aftab_su_divider/aftab_tcl.vhd
vcom -reportprogress 300 -work work ./datapath/aftab_aau/aftab_su_divider/aftab_su_divider.vhd
vcom -reportprogress 300 -work work ./datapath/aftab_aau/aftab_aau.vhd
vcom -reportprogress 300 -work work ./datapath/aftab_aau/aftab_shift_register.vhd

vcom -reportprogress 300 -work work ./datapath/aftab_daru/aftab_half_adder.vhd
vcom -reportprogress 300 -work work ./datapath/aftab_daru/aftab_full_adder.vhd
vcom -reportprogress 300 -work work ./datapath/aftab_daru/aftab_decoder.vhd
vcom -reportprogress 300 -work work ./datapath/aftab_daru/aftab_opt_adder.vhd
vcom -reportprogress 300 -work work ./datapath/aftab_daru/aftab_daru_controller.vhd
vcom -reportprogress 300 -work work ./datapath/aftab_daru/aftab_daru_datapath.vhd
vcom -reportprogress 300 -work work ./datapath/aftab_daru/aftab_daru.vhd


vcom -reportprogress 300 -work work ./datapath/aftab_dawu/aftab_dawu_controller.vhd
vcom -reportprogress 300 -work work ./datapath/aftab_dawu/aftab_dawu_datapath.vhd
vcom -reportprogress 300 -work work ./datapath/aftab_dawu/aftab_dawu.vhd

vcom -reportprogress 300 -work work ./datapath/aftab_datapath.vhd
vcom -reportprogress 300 -work work ./aftab_controller.vhd
vcom -reportprogress 300 -work work ./aftab_core.vhd




##vsim -t 100ps -novopt work.tb_dlx
##add wave \
##{sim:/tb_dlx/u1/clk } \


##add wave \
##{sim:/tb_dlx/u1/control_unit_comp/en_id } \

