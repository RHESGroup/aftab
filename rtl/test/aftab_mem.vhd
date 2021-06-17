
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use ieee.numeric_std.all;

use WORK.all;

entity aftab_mem  is
generic(Address_bits:integer  := 32; 
		N_bits: integer := 8;
        N_lines: integer := 128);
 port ( 
		rst: IN std_logic;
		clk: IN std_logic;
	 	input_data: IN std_logic_vector(N_bits-1 downto 0);
		input_address: 	IN std_logic_vector(31 downto 0);
		read_enable: In std_logic;
		write_enable: in std_logic;
		output_data: out std_logic_vector(N_bits-1 downto 0));
end aftab_mem;

architecture str of aftab_mem is

	constant file_path : string := "./test/asm/test_all/test0.hex";

	type size_mem is array (0 to N_lines-1) of std_logic_vector ( N_bits-1 downto 0);
	signal mem_s : size_mem;
begin 

mem_proc: process (clk,read_enable,input_address) is
	file mem_fp: text;
     variable file_line : line;
     variable addr: integer;
     variable index : integer := 0;
     variable tmp_data_u : std_logic_vector(4*N_bits-1 downto 0);
     variable good: boolean ;
	 constant BASE_IRAM :  integer := 0;
	 constant SIZE_IRAM :  integer := 64;
	 constant BASE_DRAM :  integer := 64;
	 constant SIZE_DRAM :  integer := 64;
begin
if rst = '1' then
		file_open(mem_fp,file_path,READ_MODE);
       while (not endfile(mem_fp)) loop
         readline(mem_fp,file_line);
         hread(file_line,tmp_data_u);
         --hread(file_line,tmp_data_u); -- This reads an hexadecimal value into a std_logic_vector
         mem_s(index) <= tmp_data_u(N_bits - 1 downto 0);       
         mem_s(index+1) <= tmp_data_u(2*N_bits - 1 downto N_bits);     
         mem_s(index+2) <= tmp_data_u(3*N_bits - 1 downto 2*N_bits);   
         mem_s(index+3) <= tmp_data_u(4*N_bits - 1 downto 3*N_bits);   
         index := index + 4;
       end loop;
      
       file_close(mem_fp);
      
      while (index < N_lines) loop 
	  	mem_s(index) <= x"00";
      	index := index + 1;
       end loop;
       index := 0;
      
else
  if  clk'event and clk = '1' then
		if write_enable = '1' and to_integer(unsigned(input_address)) >= BASE_DRAM and  to_integer(unsigned(input_address)) < BASE_DRAM + SIZE_DRAM  then
			mem_s(to_integer(unsigned(input_address))) <= input_data;
		end if;
  end if;
   
  if read_enable = '1'   then
	output_data <= mem_s(to_integer(unsigned(input_address)));
  end if; 
  
end if;

end process;
	
end str;
