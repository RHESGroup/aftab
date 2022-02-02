-- **************************************************************************************
-- Filename: aftab_CSR_address_logic.vhd
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
-- CSR address logic of the AFTAB core
--
-- **************************************************************************************

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY aftab_CSR_address_logic IS
	PORT 
	(
		addressRegBank : IN  std_logic_vector(11 DOWNTO 0);
		loadMieReg     : OUT std_logic;
		loadMieField   : OUT std_logic
	);
END ENTITY aftab_CSR_address_logic;

ARCHITECTURE behavioral OF aftab_CSR_address_logic IS
BEGIN
	loadMieReg   <= '1' WHEN addressRegBank = X"304" ELSE '0';
	loadMieField <= '1' WHEN addressRegBank = X"300" ELSE '0';
END ARCHITECTURE behavioral;