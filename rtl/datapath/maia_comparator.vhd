-- **************************************************************************************
--	Filename:	maia_comparator.vhd
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
--	Generic comparator for the TETRISC Maia core
--
-- **************************************************************************************

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY maia_comparator IS
	GENERIC (n: INTEGER := 32);
	PORT (
		ain : IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
		bin : IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
		compareSignedUnsignedBar : IN STD_LOGIC;
		Lt, Eq, Gt : OUT STD_LOGIC
	);
END ENTITY maia_comparator;

ARCHITECTURE behavioral OF maia_comparator IS 
	SIGNAL ainp, binp : STD_LOGIC_VECTOR (n-1 DOWNTO 0);
BEGIN
	ainp (n-1) <= ain(n-1) XOR compareSignedUnsignedBar;
	binp (n-1) <= bin(n-1) XOR compareSignedUnsignedBar;
	ainp (n-2 DOWNTO 0) <= ain (n-2 DOWNTO 0);
	binp (n-2 DOWNTO 0) <= bin (n-2 DOWNTO 0);
	
	Eq <= '1' WHEN (ainp = binp) ELSE '0';
	Gt <= '1' WHEN (ainp > binp) ELSE '0';
	Lt <= '1' WHEN (ainp < binp) ELSE '0';
END ARCHITECTURE behavioral;





