-- **************************************************************************************
--	Filename:	aftab_decoder.vhd
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
--	2-to-4-bit one-hot decoder for the AFTAB core
--
-- **************************************************************************************
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY aftab_decoder IS
	PORT (
		En         : IN  STD_LOGIC;
		inDecoder  : IN  STD_LOGIC_VECTOR(1 DOWNTO 0);
		outDecoder : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END ENTITY aftab_decoder;

ARCHITECTURE behavioral OF aftab_decoder IS
BEGIN
	PROCESS (inDecoder, En)
	BEGIN
		IF En = '1' THEN
			CASE inDecoder IS
				WHEN "00" => outDecoder <= "0001";
				WHEN "01" => outDecoder <= "0010";
				WHEN "10" => outDecoder <= "0100";
				WHEN "11" => outDecoder <= "1000";
				WHEN OTHERS => outDecoder <= "0000";
			END CASE;
		ELSE
			outDecoder <= "0000";
		END IF;
	END PROCESS;
END ARCHITECTURE behavioral;
