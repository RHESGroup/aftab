-- **************************************************************************************
--	Filename:	maia_barrel_shifter.vhd
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
--	Generic barrel shifter for the TETRISC Maia core
--
-- **************************************************************************************

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
--USE IEEE.STD_LOGIC_SIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY maia_barrel_shifter IS
	GENERIC (len: INTEGER := 32);
	PORT (
		shIn  : IN STD_LOGIC_VECTOR (len-1 DOWNTO 0);
		nSh   : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		selSh : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
		shOut : OUT STD_LOGIC_VECTOR (len-1 DOWNTO 0)
	);
END ENTITY maia_barrel_shifter;

ARCHITECTURE behavioral OF maia_barrel_shifter IS

BEGIN
	PROCESS(ShIn, nSh, selSh) BEGIN
		IF (selSh = "00") THEN
			shOut <= STD_LOGIC_VECTOR (unsigned (shIn) SLL (to_integer (unsigned (nSh))));
		ELSIF (selSh = "10") THEN
			shOut <= STD_LOGIC_VECTOR (unsigned (shIn) SRL (to_integer (unsigned (nSh))));
		ELSIF (selSh = "11") THEN
			shOut <= TO_STDLOGICVECTOR (TO_BITVECTOR (STD_LOGIC_VECTOR (unsigned(shIn))) SRA to_integer ( unsigned(nSh)));
		ELSE
			shOut <= (OTHERS => '0');
		END IF;
	END PROCESS;
END ARCHITECTURE behavioral;  