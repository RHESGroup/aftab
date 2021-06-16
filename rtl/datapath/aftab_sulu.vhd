-- **************************************************************************************
--	Filename:	aftab_sulu.vhd
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
--	Signed/unsigned load unit for the AFTAB core
--
-- **************************************************************************************
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY aftab_sulu IS
	GENERIC (len : INTEGER := 32);
	PORT (
		loadByteSigned : IN  STD_LOGIC;
		loadHalfSigned : IN  STD_LOGIC;
		load           : IN  STD_LOGIC;
		dataIn         : IN  STD_LOGIC_VECTOR(len - 1 DOWNTO 0);
		dataOut        : OUT STD_LOGIC_VECTOR(len - 1 DOWNTO 0)
	);
END aftab_sulu;
ARCHITECTURE Behavioral OF aftab_sulu IS
BEGIN
	dataOut <= (31 DOWNTO 8 => dataIn(7)) & dataIn (7 DOWNTO 0) WHEN loadByteSigned = '1' ELSE
			(31 DOWNTO 16 => dataIn(15)) & dataIn (15 DOWNTO 0) WHEN loadHalfSigned = '1' ELSE
														 dataIn WHEN load = '1'           ELSE (OTHERS => '0');
END Behavioral;
