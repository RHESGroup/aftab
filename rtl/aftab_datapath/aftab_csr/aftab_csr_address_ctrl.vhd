-- **************************************************************************************
--	Filename:	aftab_controller.vhd
--	Project:	CNL_RISC-V
--  Version:	1.0
--	Date:		04 April 2022
--
-- Copyright (C) 2022 CINI Cybersecurity National Laboratory and University of Tehran
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
--	This combinatorial unit checks if an intsruction attempts to access a non-existing CSR register
--  used by aftab_datapath.vhd
-- **************************************************************************************

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
ENTITY aftab_csr_address_ctrl IS
	PORT
	(
		addressRegBank   : IN  STD_LOGIC_VECTOR(11 DOWNTO 0);
		validAddressCSR  : OUT STD_LOGIC
	);
END aftab_csr_address_ctrl;



ARCHITECTURE behavioral OF aftab_csr_address_ctrl IS

BEGIN

    validAddressCSR <= '1' WHEN addressRegBank = x"300" ELSE
                       '1' WHEN addressRegBank = x"344" ELSE
                       '1' WHEN addressRegBank = x"304" ELSE
                       '1' WHEN addressRegBank = x"305" ELSE
                       '1' WHEN addressRegBank = x"341" ELSE
                       '1' WHEN addressRegBank = x"342" ELSE
                       '1' WHEN addressRegBank = x"343" ELSE
                       '1' WHEN addressRegBank = x"303" ELSE
                       '1' WHEN addressRegBank = x"302" ELSE
                       '1' WHEN addressRegBank = x"000" ELSE
                       '1' WHEN addressRegBank = x"044" ELSE
                       '1' WHEN addressRegBank = x"004" ELSE
                       '1' WHEN addressRegBank = x"005" ELSE
                       '1' WHEN addressRegBank = x"041" ELSE
                       '1' WHEN addressRegBank = x"042" ELSE
                       '1' WHEN addressRegBank = x"043" ELSE
                       '0';

END behavioral;









