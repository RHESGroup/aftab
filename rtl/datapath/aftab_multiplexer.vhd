-- **************************************************************************************
--	Filename:	aftab_multiplexer.vhd
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
--	Generic two-input multiplexer the AFTAB core
--
-- **************************************************************************************

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY aftab_multiplexer IS
	GENERIC ( len : INTEGER := 32);
	PORT (
		a    : IN STD_LOGIC_VECTOR (len-1 DOWNTO 0);
		b    : IN STD_LOGIC_VECTOR (len-1 DOWNTO 0);
		s0   : IN STD_LOGIC; 
		s1   : IN STD_LOGIC; 
		w    : OUT STD_LOGIC_VECTOR (len-1 DOWNTO 0)
	);
END ENTITY aftab_multiplexer;

ARCHITECTURE procedural OF aftab_multiplexer IS BEGIN
	PROCESS (a, b, s0, s1) BEGIN
		IF (s0 = '1') THEN 
			w <= a;
		ELSIF (s1 = '1') THEN 
			w <= b;
		ELSE
			w <= (OTHERS => '0');
		END IF;
	END PROCESS;
END ARCHITECTURE procedural;
