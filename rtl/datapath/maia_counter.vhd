-- **************************************************************************************
--	Filename:	maia_counter.vhd
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
--	Generic counter for the TETRISC Maia core
--
-- **************************************************************************************

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY maia_counter IS 
	GENERIC ( len : INTEGER := 2);
	PORT (
		clk,rst   : IN STD_LOGIC;
		zeroCnt   : IN STD_LOGIC;
		incCnt    : IN STD_LOGIC;
		initCnt   : IN STD_LOGIC;
		initValue : IN STD_LOGIC_VECTOR (len-1 DOWNTO 0);
		outCnt    : OUT std_logic_vector (len-1 DOWNTO 0)
	);
END ENTITY maia_counter;
 
ARCHITECTURE Behavioral OF maia_counter IS
   SIGNAL temp: STD_LOGIC_VECTOR (len-1 DOWNTO 0);
BEGIN   
    PROCESS(clk,rst)
    BEGIN
		IF ( rst = '1' ) THEN
			temp <= (OTHERS => '0');
        ELSIF ( clk = '1' and clk 'EVENT)THEN
			IF ( zeroCnt = '1' ) THEN
				 temp <= (OTHERS => '0');
			ELSIF (initCnt = '1') THEN
				temp <= initValue;
			ELSIF (incCnt = '1') THEN
				temp <= temp + 1;
            END IF;
        END IF; 
    END PROCESS;
   outCnt <= temp;
END ARCHITECTURE Behavioral;