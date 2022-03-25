-- **************************************************************************************
--	Filename:	aftab_oneBitReg.vhd
--	Project:	CNL_RISC-V
--  Version:	1.0
--	History:
--	Date:		16 February 2021
--
-- Copyright (C) 2021 CINI Cybersecurity National Laboratory and University of Tehran
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
--	one bit register for the AFTAB core
--
-- **************************************************************************************
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY aftab_oneBitReg IS
    	PORT (
    	    	clk, rst   : IN  STD_LOGIC;
    	    	zero, load : IN  STD_LOGIC;
    	    	inReg      : IN  STD_LOGIC;
    	    	outReg     : OUT STD_LOGIC
    	);
END ENTITY aftab_oneBitReg;
--
ARCHITECTURE behavioral OF aftab_oneBitReg IS

BEGIN
    	PROCESS (clk, rst)
    	BEGIN
    	    	IF (rst = '1') THEN
    	    	    	outReg <= '0';
    	    	ELSIF (clk = '1' AND clk 'EVENT) THEN
    	    	    	IF (zero = '1') THEN
    	    	    	    	outReg <= '0';
    	    	    	ELSIF (load = '1') THEN
    	    	    	    	outReg <= inReg;
    	    	    	END IF;
    	    	END IF;
    	END PROCESS;
END ARCHITECTURE behavioral;
