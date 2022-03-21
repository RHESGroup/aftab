-- **************************************************************************************
-- Filename: aftab_CSR_registers.vhd
-- Project: CNL_RISC-V
-- Version: 1.0
-- History:
-- Date: 14 December 2021
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
-- File content description:
-- CSR registers of the AFTAB core
--
-- **************************************************************************************
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY aftab_CSR_registers IS
	GENERIC (len : INTEGER := 32);
	PORT 
	(
		clk            : IN STD_LOGIC;
		rst            : IN STD_LOGIC;
		writeRegBank   : IN STD_LOGIC; 
		addressRegBank : IN STD_LOGIC_VECTOR  (4 DOWNTO 0);
		inputRegBank   : IN STD_LOGIC_VECTOR  (len - 1 DOWNTO 0);
		outRegBank     : OUT STD_LOGIC_VECTOR (len - 1 DOWNTO 0)
	);
END ENTITY aftab_CSR_registers;
--
ARCHITECTURE behavioral OF aftab_CSR_registers IS
	TYPE csr_arr IS ARRAY (0 TO 31) OF STD_LOGIC_VECTOR (31 DOWNTO 0);
	SIGNAL rData                : csr_arr;
 
	ATTRIBUTE ramstyle          : STRING;
	ATTRIBUTE ramstyle OF rData : SIGNAL IS "M9K";
 
BEGIN
	wrProc : PROCESS (clk, rst)
	-- wrProc : PROCESS (clk)
	BEGIN
		IF (rst = '1') THEN
			rData <= (OTHERS => (OTHERS => '0'));
		ELSIF (clk = '1' AND clk'EVENT) THEN
			IF (writeRegBank = '1') THEN
				rData(to_integer(unsigned(addressRegBank))) <= inputRegBank;
			END IF;
			outRegBank <= rData(to_integer (unsigned(addressRegBank)));
		END IF;
	END PROCESS;
END ARCHITECTURE behavioral;