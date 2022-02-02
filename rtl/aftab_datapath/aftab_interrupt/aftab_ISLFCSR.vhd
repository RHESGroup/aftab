-- **************************************************************************************
-- Filename: aftab_ISLFCSR.vhd
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
-- Input selection logic for CSRs in the AFTAB core
--
-- **************************************************************************************

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY aftab_ISLFCSR IS
	GENERIC (len : INTEGER := 32);
	PORT 
	(
		selP1                : IN  std_logic;
		selIm                : IN  std_logic;
		selReadWrite         : IN  std_logic;
		clr                  : IN  std_logic;
		set                  : IN  std_logic;
		selPC                : IN  std_logic;
		selmip               : IN  std_logic;
		selCause             : IN  std_logic;
		statusAlterationPre  : IN  std_logic;
		statusAlterationPost : IN  std_logic;
		ir19_15              : IN  std_logic_vector(4 DOWNTO 0);
		CCmip                : IN  std_logic_vector(len - 1 DOWNTO 0);
		causeCode            : IN  std_logic_vector(len - 1 DOWNTO 0);
		P1                   : IN  std_logic_vector(len - 1 DOWNTO 0);
		PC                   : IN  std_logic_vector(len - 1 DOWNTO 0);
		outCSR               : IN  std_logic_vector(len - 1 DOWNTO 0);
		inCSR                : OUT std_logic_vector(len - 1 DOWNTO 0)
	);
END ENTITY aftab_ISLFCSR;

ARCHITECTURE behavioral OF aftab_ISLFCSR IS

	SIGNAL orRes, andRes, regOrImm : std_logic_vector(len - 1 DOWNTO 0);

BEGIN
	regOrImm <= P1 WHEN selP1 = '1' ELSE
	("000000000000000000000000000" & ir19_15) WHEN selIm = '1' ELSE (OTHERS => '0');
	orRes  <= outCSR OR regOrImm;
	andRes <= outCSR AND (NOT regOrImm);
	inCSR  <= regOrImm 	WHEN 	selReadWrite = '1' ELSE
	         orRes     	WHEN 	set = '1' 		   ELSE
	         andRes    	WHEN 	clr = '1'          ELSE
	         CCmip     	WHEN 	selmip = '1'       ELSE
	         causeCode 	WHEN 	selCause = '1'     ELSE
	         PC        	WHEN 	selPC = '1'        ELSE -- The name for selPC must be changed
	         (outCSR(31 DOWNTO 13) & "11" & outCSR(10 DOWNTO 8) & outCSR(3) & outCSR(6 DOWNTO 4) & '0' & outCSR(2 DOWNTO 0)) WHEN statusAlterationPre = '1' ELSE
	         (outCSR(31 DOWNTO 13) & "11" & outCSR(10 DOWNTO 8) & '0' & outCSR(6 DOWNTO 4) & '1' & outCSR(2 DOWNTO 0)) WHEN statusAlterationPost = '1' ELSE (OTHERS => '0');

END ARCHITECTURE behavioral;