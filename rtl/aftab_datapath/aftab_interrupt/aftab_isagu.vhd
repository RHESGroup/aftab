-- **************************************************************************************
-- Filename: aftab_iagu.vhd
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
-- Interrupt start address generator unit in the AFTAB core
--
-- **************************************************************************************
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY aftab_isagu IS
	GENERIC (len : INTEGER := 32);
	PORT 
	(
		tvecBase                      : IN  STD_LOGIC_VECTOR(len - 1 DOWNTO 0);
		causeCode                     : IN  STD_LOGIC_VECTOR(5 DOWNTO 0);
		modeTvec                      : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		interruptStartAddressDirect   : OUT STD_LOGIC_VECTOR(len - 1 DOWNTO 0);
		interruptStartAddressVectored : OUT STD_LOGIC_VECTOR(len - 1 DOWNTO 0)
	);
END aftab_isagu;

ARCHITECTURE Behavioral OF aftab_isagu IS
BEGIN
	modeTvec <= tvecBase (1 DOWNTO 0);
	interruptStartAddressDirect   <= tvecBase;
	interruptStartAddressVectored <= tvecBase(len - 1 DOWNTO 8) & (causeCode & "00");
END Behavioral;