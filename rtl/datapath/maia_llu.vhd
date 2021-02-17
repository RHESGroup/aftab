-- **************************************************************************************
--	Filename:	maia_llu.vhd
--	Project:	TETRISC 
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
--	Bitwise logical unit of the TETRISC Maia core
--
-- **************************************************************************************

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY maia_llu IS
	GENERIC (n: INTEGER := 32);
	PORT (
		ain      : IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
		bin      : IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
		selLogic : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
		result   : OUT STD_LOGIC_VECTOR (n-1 DOWNTO 0)
	);
END ENTITY maia_llu;

ARCHITECTURE behavioral OF maia_llu IS 
	SIGNAL y : STD_LOGIC_VECTOR (ain'LENGTH-1 DOWNTO 0);
BEGIN
	PROCESS (ain, bin, selLogic) BEGIN
		CASE selLogic IS
			WHEN "00" => y <= ain XOR bin;
			WHEN "10" => y <= ain OR bin;
			WHEN "11" => y <= ain AND bin;
			WHEN OTHERS => y <= (OTHERS => '0');
		END CASE;
	END PROCESS;
	result <= y (ain'LENGTH - 1 DOWNTO 0);
END ARCHITECTURE behavioral;


