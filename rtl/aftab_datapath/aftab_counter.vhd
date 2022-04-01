-- **************************************************************************************
--	Filename:	aftab_counter.vhd
--	Project:	CNL_RISC-V
--  Version:	1.0
--	Date:		25 March 2022
--
-- Copyright (C) 2022 CINI Cybersecurity National Laboratory and University of Tehran
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
--	Generic counter for the AFTAB core
--
-- **************************************************************************************

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY aftab_counter IS
	GENERIC (len : INTEGER := 6);
	PORT (
		clk, rst  : IN  STD_LOGIC;
		zeroCnt   : IN  STD_LOGIC;
		incCnt    : IN  STD_LOGIC;
		initCnt   : IN  STD_LOGIC;
		initValue : IN  STD_LOGIC_VECTOR (len - 1 DOWNTO 0);
		outCnt    : OUT STD_LOGIC_VECTOR (len - 1 DOWNTO 0);
		coCnt     : OUT STD_LOGIC);
END aftab_counter;
--
ARCHITECTURE Behavioral OF aftab_counter IS
	SIGNAL temp   : STD_LOGIC_VECTOR (len - 1 DOWNTO 0);
	SIGNAL coCntp : STD_LOGIC;
BEGIN
	PROCESS (clk, rst)
	BEGIN
		IF (rst = '1') THEN
			temp <= (OTHERS => '0');
		ELSIF (clk = '1' AND clk 'EVENT) THEN
			IF (zeroCnt = '1') THEN
				temp <= (OTHERS => '0');
			ELSIF (initCnt = '1') THEN
				temp <= initValue;
			ELSIF (incCnt = '1' AND coCntp = '0') THEN
				temp <= (temp + 1);
			END IF;
		END IF;
	END PROCESS;
	coCntp <= '1' WHEN (temp = (temp'RANGE => '1')) ELSE '0';
	coCnt <= coCntp;
	outCnt <= temp;
END Behavioral;
