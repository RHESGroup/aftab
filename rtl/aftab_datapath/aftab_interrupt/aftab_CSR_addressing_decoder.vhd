-- **************************************************************************************
-- Filename: aftab_CSR_addressing_decoder.vhd
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
-- CSR addressing decoder decodes the counter value to the 12-bit address of CSRs
--
-- **************************************************************************************
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
ENTITY aftab_CSR_addressing_decoder IS
	PORT
	(
		cntOutput        : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
		outAddr          : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
	);
END aftab_CSR_addressing_decoder;
--
ARCHITECTURE functional OF aftab_CSR_addressing_decoder IS
BEGIN
	outAddr(11 DOWNTO 8) <= "0011";
	outAddr(7)           <= '0';
	outAddr(6)           <= '1' WHEN cntOutput = "000" ELSE
									'1' WHEN cntOutput = "001" ELSE
									'1' WHEN cntOutput = "010" ELSE
									'1' WHEN cntOutput = "111" ELSE
									'0';
	outAddr(05 DOWNTO 3) <= "000";
	outAddr(02 DOWNTO 0) <= "100" WHEN cntOutput = "000" ELSE --mip
									"010" WHEN cntOutput = "001" ELSE --mcause
									"000" WHEN cntOutput = "100" ELSE --mstatus
									"001" WHEN cntOutput = "010" ELSE --mepc
									"101" WHEN cntOutput = "011" ELSE --mtvec
									"000" WHEN cntOutput = "101" ELSE
									"000" WHEN cntOutput = "110" ELSE
									"011" WHEN cntOutput = "111" ELSE --mtval
									"000";
END functional;