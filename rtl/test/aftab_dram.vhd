
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;
use WORK.all;

entity aftab_dram  is
generic(Address_bits:integer  := 32; 
		N_bits: integer := 8;
        N_lines: integer := 64);
 port ( 
		rst: IN std_logic;
		clk: IN std_logic;
	 	input_data: IN std_logic_vector(N_bits-1 downto 0);
		input_address: 	IN std_logic_vector(31 downto 0);
		read_enable: In std_logic;
		write_enable: in std_logic;
		enable: In  std_logic;
		output_data: out std_logic_vector(N_bits-1 downto 0));
end aftab_dram;

architecture str of aftab_dram is
	type size_mem is array (0 to N_lines-1) of std_logic_vector ( N_bits-1 downto 0);
	signal mem_s : size_mem;
begin 

mem_proc: process (clk,read_enable,input_address) is

begin
if rst = '0' then
	mem_s <=  (others => (others => "0"));  
else
  if  clk'event and clk = '1' then
	if enable = '1' then
		if write_enable = '1' and to_integer(unsigned(input_address)) >= BASE_DRAM and  to_integer(unsigned(input_address)) < BASE_DRAM + SIZE_DRAM  then
			mem_s(to_integer(unsigned(input_address))) <= input_data;
		end if;
	end if;
  end if;
   
  if read_enable = '1'   then
	output_data <= mem_s(to_integer(unsigned(input_address)));
  end if; 
  
end if;

end process;
	
end str;
