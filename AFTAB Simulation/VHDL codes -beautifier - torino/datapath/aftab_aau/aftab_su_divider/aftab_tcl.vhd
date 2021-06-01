-- **************************************************************************************
--	Filename:	aftab_tcl.vhd
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
--	Divider component of the integer divider for the AFTAB core
--
-- **************************************************************************************

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY aftab_tcl IS
	GENERIC (len: INTEGER := 32);
	PORT (
		aIn  : IN STD_LOGIC_VECTOR (len-1 DOWNTO 0);
		en   : IN STD_LOGIC;
		aOut : OUT STD_LOGIC_VECTOR (len-1 DOWNTO 0)
	);
END ENTITY aftab_tcl;

ARCHITECTURE behavioral OF aftab_tcl IS
	SIGNAL aInp : STD_LOGIC_VECTOR (len-1 DOWNTO 0);
BEGIN
	aInp <= NOT (aIn)  WHEN (en = '1' ) ELSE aIn;
	aout <= (aInp + 1) WHEN (en = '1') ELSE aInp;
	
END ARCHITECTURE behavioral;  