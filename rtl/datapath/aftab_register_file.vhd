-- **************************************************************************************
--	Filename:	aftab_shift_register.vhd
--	Project:	CNL_RISC-V
--      Engineer:
--  Version:	1.0
--	History:
--	Date:		16 February 2021
--
-- Copyright (C) 2021 CINI Cybersecurity National Laboratory and University of Teheran
--
-- This source file may be used and distributed without
-- restriction provided that this copyright statement is not
-- removed from the file and that any derivative work contains
-- the original copyright notice and the associated disclaimer.
--
-- This source file is free software; you can redistribute it
-- and/or modify it under the terms of the GNU Lesser General
-- Public License as published by the Free Software Foundation;
-- either version 3.0 of the License, or (at your option) any
-- later version.
--
-- This source is distributed in the hope that it will be
-- useful, but WITHOUT ANY WARRANTY; without even the implied
-- warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
-- PURPOSE. See the GNU Lesser General Public License for more
-- details.
--
-- You should have received a copy of the GNU Lesser General
-- Public License along with this source; if not, download it
-- from https://www.gnu.org/licenses/lgpl-3.0.txt
--
-- **************************************************************************************
--
--	File content description:
--	Generic shift register for the AFTAB core
--
-- **************************************************************************************
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;
use WORK.all;

entity aftab_register_file is
 generic (len: integer := 32);
 port ( clk: 		IN std_logic;
        rst: 	    IN std_logic;
		setZero:     IN std_logic;
	    setOne:      IN std_logic;
		rd: 	IN std_logic_vector(integer(log2(real(len)))-1 downto 0);  
		rs1: 	IN std_logic_vector(integer(log2(real(len)))-1 downto 0);
		rs2: 	IN std_logic_vector(integer(log2(real(len)))-1 downto 0);
		writedata: 	IN std_logic_vector(len-1 downto 0);
		writeRegFile: 	IN std_logic;
        p1: 		OUT std_logic_vector(len-1 downto 0);
		p2: 		OUT std_logic_vector(len-1 downto 0));
end aftab_register_file;

architecture A of aftab_register_file is

    -- suggested structures
    subtype REG_ADDR is natural range 0 to len-1; -- using natural type
	type REG_ARRAY is array(REG_ADDR) of std_logic_vector(len-1 downto 0); 
	signal REGISTERS : REG_ARRAY; 
		
begin 

RegProc: process(CLK)
begin 
	if CLK = '1' and CLK'EVENT then
		if rst = '1' then 
			REGISTERS <= (others => (others => '0'));
		else 
				   p1 <= Registers(to_integer(unsigned(rs1)));
				   p2 <= Registers(to_integer(unsigned(rs2)));
				if writeRegFile = '1' then 
					    Registers(to_integer(unsigned(rd))) <= writedata; 

				end if;

				if setZero = '1' then 
					Registers(to_integer(unsigned(rd))) <= ((others => '0') ); 
				elsif setOne= '1' then 
					Registers(to_integer(unsigned(rd))) <= std_logic_vector(to_unsigned(1,len)); 
				end if;
		end if; 
	end if;
end process RegProc;
end A;