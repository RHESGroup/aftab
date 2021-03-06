-- **************************************************************************************
--	Filename:	aftab_imm_sel_sign_ext.vhd
--	Project:	CNL_RISC-V 
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
--	Immediate Selection and Sign Extension Unit (ISSEU) for the AFTAB core
--
-- **************************************************************************************

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY aftab_imm_sel_sign_ext IS 
	PORT (
		IR7  : IN STD_LOGIC;
		IR20 : IN STD_LOGIC;
		IR31 : IN STD_LOGIC;
		IR11_8  : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		IR19_12 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);	
		IR24_21 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		IR30_25 : IN STD_LOGIC_VECTOR (5 DOWNTO 0);
		selI : IN STD_LOGIC;
		selS : IN STD_LOGIC;
		selBUJ : IN STD_LOGIC;
		selIJ : IN STD_LOGIC;
		selSB : IN STD_LOGIC;
		selU : IN STD_LOGIC;
		selISBJ : IN STD_LOGIC;
		selIS : IN STD_LOGIC;
		selB : IN STD_LOGIC;
		selJ : IN STD_LOGIC;
		selISB : IN STD_LOGIC;
		selUJ : IN STD_LOGIC;
		Imm : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
END ENTITY aftab_imm_sel_sign_ext;
 
ARCHITECTURE Behavioral OF aftab_imm_sel_sign_ext IS

BEGIN   
	Imm (0) 	<= 	IR20 WHEN selI='1' ELSE 
				    IR7  WHEN selS='1' ELSE 
				    '0'  WHEN selBUJ='1' ELSE '0';
						
	Imm (4 DOWNTO 1) <=  IR24_21 WHEN selIJ='1' ELSE 
						 IR11_8  WHEN selSB='1' ELSE 
						 (OTHERS =>'0') WHEN selU='1' ELSE 
						 (OTHERS => '0');
						
	Imm (10 DOWNTO 5) <= IR30_25 WHEN selISBJ='1' ELSE 
						 (OTHERS =>'0') WHEN selU='1' ELSE 
						 (OTHERS => '0');
						
	Imm (11) <= 	IR31 WHEN selIS='1' ELSE 
				IR7  WHEN selB='1' ELSE 
				'0'  WHEN selU='1' ELSE 
				IR20 WHEN selJ='1' ELSE '0';
						
	Imm (19 DOWNTO 12) <=  (OTHERS => IR31) WHEN selISB='1' ELSE 
						   IR19_12          WHEN selUJ='1' ELSE 
						   (OTHERS => '0');
							
	Imm (30 DOWNTO 20) <= (OTHERS => IR31)           WHEN selISBJ='1' ELSE 
						  (IR30_25 & IR24_21 & IR20) WHEN selU='1' ELSE 
						  (OTHERS => '0');
	Imm (31) <= IR31;
	
END ARCHITECTURE Behavioral;