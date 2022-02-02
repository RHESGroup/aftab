-- **************************************************************************************
-- Filename: aftab_CSRAddressingDecoder.vhd
-- Project: CNL_RISC-V
-- Version: 1.0
-- History:
-- Date: 14 December 2021
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
-- File content description:
-- CSR addressing decoder of the AFTAB core
--
-- **************************************************************************************
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY aftab_CSRAddressingDecoder IS
	PORT 
	(
		cntInput : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		outAddr  : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
	);
END aftab_CSRAddressingDecoder;

ARCHITECTURE functional OF aftab_CSRAddressingDecoder IS
 
BEGIN
	outAddr(11 DOWNTO 7) <= "00110";
	outAddr(6)           <= '1' WHEN cntInput = "000" ELSE
							'1' WHEN cntInput = "001" ELSE
							'1' WHEN cntInput = "011" ELSE
							'0';
	outAddr(05 DOWNTO 3) <= "000";
	outAddr(02 DOWNTO 0) <= "100" WHEN cntInput = "000" ELSE
	                        "010" WHEN cntInput = "001" ELSE
	                        "000" WHEN cntInput = "010" ELSE
	                        "001" WHEN cntInput = "011" ELSE
	                        "101" WHEN cntInput = "100" ELSE
	                        "101" WHEN cntInput = "101" ELSE
	                        "001" WHEN cntInput = "110" ELSE
	                        "010" WHEN cntInput = "111" ELSE
	                        "000";
END functional;