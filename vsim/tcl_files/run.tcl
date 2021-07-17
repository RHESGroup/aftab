vsim -quiet work.aftab_testbench +nowarnTRAN +nowarnTSCALE +nowarnTFMPC -t 10ps -voptargs="+acc -suppress 2103" -dpicpppath /usr/bin/gcc 

add wave -noupdate -group SYSTEM /aftab_testbench/clk          
add wave -noupdate -group SYSTEM /aftab_testbench/rst          
add wave -noupdate -group SYSTEM /aftab_testbench/memReady     
add wave -noupdate -group SYSTEM /aftab_testbench/memRead      
add wave -noupdate -group SYSTEM /aftab_testbench/memWrite     
add wave -noupdate -group SYSTEM -radix hexadecimal /aftab_testbench/memAddr      
add wave -noupdate -group SYSTEM -radix hexadecimal /aftab_testbench/dataBus      
add wave -noupdate -group SYSTEM /aftab_testbench/cs           
add wave -noupdate -group SYSTEM /aftab_testbench/opr          

add wave -noupdate -group CONTROLLER /aftab_testbench/core/controllerAFTAB/*

add wave -noupdate -group DATAPATH /aftab_testbench/core/datapathAFTAB/*

add wave -noupdate -group RF -radix hexadecimal /aftab_testbench/core/datapathAFTAB/registerFile/registers

add wave -noupdate -group LLU /aftab_testbench/core/datapathAFTAB/LLU/*

add wave -noupdate -group BSU /aftab_testbench/core/datapathAFTAB/BSU/*

add wave -noupdate -group COMPARATOR /aftab_testbench/core/datapathAFTAB/comparator/*

add wave -noupdate -group ADD_SUB /aftab_testbench/core/datapathAFTAB/addSub/*

add wave -noupdate -group AAU /aftab_testbench/core/datapathAFTAB/aau/*

add wave -noupdate -group DAWU /aftab_testbench/core/datapathAFTAB/dawu/*

add wave -noupdate -group DARU /aftab_testbench/core/datapathAFTAB/daru/*

add wave -noupdate -group SULU /aftab_testbench/core/datapathAFTAB/suau/*

add wave -noupdate -group MEMORY -radix hexadecimal /aftab_testbench/memory/rw/adr
add wave -noupdate -group MEMORY -radix hexadecimal /aftab_testbench/memory/mem

run 40 us