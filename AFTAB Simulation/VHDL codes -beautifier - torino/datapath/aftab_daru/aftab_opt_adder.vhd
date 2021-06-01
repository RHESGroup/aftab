-- **************************************************************************************
--	Filename:	aftab_opt_adder.vhd
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
--	optimized adder for the AFTAB core
--
-- **************************************************************************************
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY aftab_opt_adder IS
	GENERIC (len : INTEGER := 32);
	PORT (
		A   : IN  STD_LOGIC_VECTOR(len - 1 DOWNTO 0);
		B   : IN  STD_LOGIC_VECTOR(1 DOWNTO 0);
		Sum : OUT STD_LOGIC_VECTOR (len - 1 DOWNTO 0));
END aftab_opt_adder;

ARCHITECTURE Behavioral OF aftab_opt_adder IS
	SIGNAL Cin  : STD_LOGIC_VECTOR (len - 1 DOWNTO 0);
	SIGNAL Cout : STD_LOGIC_VECTOR (len - 1 DOWNTO 0);
BEGIN
	FA1 : ENTITY WORK.aftab_full_adder 
			PORT MAP (
				A => A(0),
				B => B(0), 
				Cin => '0', 
				S => Sum(0),
				Cout => Cout(0));
	FA2 : ENTITY WORK.aftab_full_adder 
			PORT MAP (
				A => A(1), 
				B => B(1),
				Cin => Cout(0), 
				S => Sum(1), 
				Cout => Cout(1));
	GEN_HalfAdder :
		FOR I IN 2 TO 31 GENERATE
			HA : ENTITY WORK.aftab_half_adder
				PORT MAP (
					i_bit1 => A(I), 
					i_bit2 => Cout(I - 1), 
					o_sum => Sum (I), 
					o_carry => Cout(I));
		END GENERATE GEN_HalfAdder;
END Behavioral;