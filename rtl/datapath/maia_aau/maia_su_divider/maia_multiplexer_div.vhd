-- **************************************************************************************
--	Filename:	maia_multiplexer_div.vhd
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
--	Generic multiplexer for the integer divider of the TETRISC Maia core
--
-- **************************************************************************************

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY maia_multiplexer_div IS
	GENERIC (len: INTEGER := 32);
	PORT (
		a : IN STD_LOGIC_VECTOR (len-1 DOWNTO 0);
		b : IN STD_LOGIC_VECTOR (len-1 DOWNTO 0);
		sel  : IN STD_LOGIC;
	    W    : OUT STD_LOGIC_VECTOR (len-1 DOWNTO 0));
END ENTITY maia_multiplexer_div;

ARCHITECTURE procedural OF maia_multiplexer_div IS BEGIN
	PROCESS (a, b, sel) BEGIN
		IF (sel = '0') THEN
			w <= a;
		ELSE 
			w <= b;
		END IF;
	END PROCESS;
END ARCHITECTURE procedural;
