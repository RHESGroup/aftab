-- **************************************************************************************
--	Filename:	aftab_half_adder.vhd
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
--	full adder for the AFTAB core
--
-- **************************************************************************************
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY aftab_half_adder IS
	PORT (
		i_bit1 : IN STD_LOGIC;
		i_bit2 : IN STD_LOGIC;
		o_sum   : OUT STD_LOGIC;
		o_carry : OUT STD_LOGIC
	);
END aftab_half_adder;

ARCHITECTURE rtl OF aftab_half_adder IS
BEGIN
	o_sum <= i_bit1 XOR i_bit2;
	o_carry <= i_bit1 AND i_bit2;
END rtl;
