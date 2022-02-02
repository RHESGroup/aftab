-- **************************************************************************************
-- Filename: aftab_interrCheckCauseDetection.vhd
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
-- Interrupt check cause detection in the AFTAB core
--
-- **************************************************************************************

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.numeric_std.ALL;

ENTITY aftab_interrCheckCauseDetection IS
	GENERIC (len : INTEGER := 32);
	PORT 
	(
		mipCC          : IN std_logic_vector(len - 1 DOWNTO 0);
		mieCC          : IN std_logic_vector(len - 1 DOWNTO 0);
		mieFieldCC     : IN std_logic;
		interruptRaise : OUT std_logic;
		causeCode      : OUT std_logic_vector(len - 1 DOWNTO 0)
	);
END ENTITY aftab_interrCheckCauseDetection;

ARCHITECTURE behavioral OF aftab_interrCheckCauseDetection IS

	SIGNAL interRaiseTemp : std_logic;

BEGIN
	interRaiseTemp <= (((mipCC(11) AND mieCC(11)) OR (mipCC(7) AND mieCC(7))) OR (mipCC(3) AND mieCC(3)))AND mieFieldCC;
	interruptRaise <= interRaiseTemp;
	causeCodeGeneration : PROCESS (interRaiseTemp, mipCC)
	BEGIN
		IF (interRaiseTemp = '1') THEN
			IF (mipCC(11) = '1') THEN
				causeCode <= interRaiseTemp & std_logic_vector(to_unsigned(11, len - 1));
			ELSIF (mipCC(11) = '0' AND mipCC(3) = '1') THEN
				causeCode <= interRaiseTemp & std_logic_vector(to_unsigned(3, len - 1));
			ELSIF (mipCC(11) = '0' AND mipCC(3) = '0' AND mipCC(7) = '1') THEN
				causeCode <= interRaiseTemp & std_logic_vector(to_unsigned(7, len - 1)); 
			ELSE
				causeCode <= (OTHERS => '0');
			END IF;
		ELSE
			causeCode <= (OTHERS => '0');
		END IF;
	END PROCESS;

END ARCHITECTURE behavioral;