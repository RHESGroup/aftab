-- **************************************************************************************
--	Filename:	aftab_CSRAddressTranslator.vhd
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
--	Translating the 12-bit CSR address to 5-bit
--
-- **************************************************************************************
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
ENTITY aftab_CSRAddressTranslator IS
	PORT
	(
		CSR_AddrIn  : IN  STD_LOGIC_VECTOR (11 DOWNTO 0);
		CSR_AddrOut : OUT STD_LOGIC_VECTOR (4 DOWNTO 0)
	);
END ENTITY aftab_CSRAddressTranslator;
ARCHITECTURE behavioral OF aftab_CSRAddressTranslator IS
BEGIN
	Translate : PROCESS (CSR_AddrIn)
	BEGIN
		CASE CSR_AddrIn IS
			WHEN X"300" =>
				CSR_AddrOut <= "00000";
			WHEN X"302" =>
				CSR_AddrOut <= "00001";
			WHEN X"303" =>
				CSR_AddrOut <= "00010";
			WHEN X"304" =>
				CSR_AddrOut <= "00011";
			WHEN X"305" =>
				CSR_AddrOut <= "00100";
			WHEN X"341" =>
				CSR_AddrOut <= "00101";
			WHEN X"342" =>
				CSR_AddrOut <= "00110";
			WHEN X"344" =>
				CSR_AddrOut <= "00111";
			WHEN X"000" =>
				CSR_AddrOut <= "01000";
			WHEN X"004" =>
				CSR_AddrOut <= "01001";
			WHEN X"005" =>
				CSR_AddrOut <= "01010";
			WHEN X"041" =>
				CSR_AddrOut <= "01011";
			WHEN X"042" =>
				CSR_AddrOut <= "01100";
			WHEN X"044" =>
				CSR_AddrOut <= "01101";
			WHEN OTHERS =>
				CSR_AddrOut <= "00000";
		END CASE;
	END PROCESS;
END ARCHITECTURE behavioral;