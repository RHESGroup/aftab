-- **************************************************************************************
--	Filename:	aftab_errorDecoderDARU.vhd
--	Project:	CNL_RISC-V
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
--
--
-- **************************************************************************************
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
ENTITY aftab_errorDecoderDARU IS
	GENERIC
		(len : INTEGER := 32);
	PORT
	(
		nBytes              : IN  STD_LOGIC_VECTOR (1 DOWNTO 0);
		addrIn              : IN  STD_LOGIC_VECTOR (1 DOWNTO 0);
		dataInstrBar        : IN  STD_LOGIC;
		checkMisalignedDARU : IN  STD_LOGIC;
		instrMisalignedFlag : OUT STD_LOGIC;
		loadMisalignedFlag  : OUT STD_LOGIC
	);
END ENTITY aftab_errorDecoderDARU;
ARCHITECTURE behavioral OF aftab_errorDecoderDARU IS
	SIGNAL dataReadingError : STD_LOGIC;
	SIGNAL instReadingError : STD_LOGIC;
	SIGNAL misalignedErrorP : STD_LOGIC;
	SIGNAL cmp_01           : STD_LOGIC;
	SIGNAL cmp_10           : STD_LOGIC;
	SIGNAL cmp_11           : STD_LOGIC;
	SIGNAL inReg            : STD_LOGIC_VECTOR (2 DOWNTO 0);
	SIGNAL outReg           : STD_LOGIC_VECTOR (2 DOWNTO 0);
BEGIN
	cmp_01           <= '1' WHEN (addrIn = "01") ELSE '0';
	cmp_10           <= '1' WHEN (addrIn = "10") ELSE '0';
	cmp_11           <= '1' WHEN (addrIn = "11") ELSE '0';
	misalignedErrorP <= (cmp_01 OR cmp_11) WHEN (nBytes = "01") ELSE
		(cmp_01 OR cmp_10 OR cmp_11) WHEN (nBytes = "11") ELSE '0';
	loadMisalignedFlag  <= (misalignedErrorP AND checkMisalignedDARU) WHEN dataInstrBar = '1' ELSE '0';
	instrMisalignedFlag <= (misalignedErrorP AND checkMisalignedDARU) WHEN dataInstrBar = '0' ELSE '0';
END ARCHITECTURE behavioral;