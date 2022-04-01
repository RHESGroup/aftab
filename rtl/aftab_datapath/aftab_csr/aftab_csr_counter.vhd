-- **************************************************************************************
--	Filename:	aftab_csr_counter.vhd
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
-- File content description:
-- Control and Status Register counter to the address of the appropriate CSRs during 
-- the interrupt entry and return instruction states
--
-- **************************************************************************************

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_arith.ALL;
USE IEEE.std_logic_unsigned.ALL;

ENTITY aftab_csr_counter IS
	GENERIC (len : INTEGER := 3);
	PORT 
	(
		clk     : IN STD_LOGIC;
		rst     : IN STD_LOGIC;
		dnCnt   : IN STD_LOGIC;
		upCnt   : IN STD_LOGIC;
		ldCnt   : IN STD_LOGIC;
		zeroCnt : IN STD_LOGIC;
		ldValue : IN STD_LOGIC_VECTOR (len - 1 DOWNTO 0);
		outCnt  : OUT STD_LOGIC_VECTOR (len - 1 DOWNTO 0)
	);
END aftab_csr_counter;
--
ARCHITECTURE Behavioral OF aftab_csr_counter IS
	SIGNAL temp             : STD_LOGIC_VECTOR (len - 1 DOWNTO 0);
	SIGNAL coCntup, coCntdn : STD_LOGIC;
BEGIN
	PROCESS (clk, rst)
	BEGIN
		IF (rst = '1') THEN
			temp <= (OTHERS => '0');
		ELSIF (clk = '1' AND clk 'EVENT) THEN
			IF (zeroCnt = '1') THEN
				temp <= (OTHERS => '0');
			ELSIF (ldCnt = '1') THEN
				temp <= ldValue;
			ELSIF (upCnt = '1' AND coCntup = '0') THEN
				temp <= (temp + 1);
			ELSIF (dnCnt = '1' AND coCntdn = '0') THEN
				temp <= (temp - 1);
			END IF;
		END IF;
	END PROCESS;
	coCntup <= '1' WHEN (temp = (temp'RANGE => '1')) ELSE '0';
	coCntdn <= '1' WHEN (temp = (temp'RANGE => '0')) ELSE '0';
	outCnt  <= temp;
END Behavioral;