-- **************************************************************************************
--	Filename:	aftab_shift_register.vhd
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
--	Generic shift register for the AFTAB core
--
-- **************************************************************************************
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_UNSIGNED.ALL;
ENTITY aftab_shift_register IS
	GENERIC (len : INTEGER := 32);
	PORT (
		clk     : IN  STD_LOGIC;
		rst     : IN  STD_LOGIC;
		inReg   : IN  STD_LOGIC_VECTOR (len - 1 DOWNTO 0);
		shiftR 	: IN  STD_LOGIC;
		shiftL 	: IN  STD_LOGIC;
		load  	: IN  STD_LOGIC;
		zero 	: IN  STD_LOGIC;
		serIn   : IN  STD_LOGIC;
		serOut  : OUT STD_LOGIC;
		outReg  : OUT STD_LOGIC_VECTOR (len - 1 DOWNTO 0));
END ENTITY aftab_shift_register;
ARCHITECTURE behavioral OF aftab_shift_register IS
BEGIN
	PROCESS (clk, rst)
		VARIABLE outReg_t : STD_LOGIC_VECTOR (len - 1 DOWNTO 0);
		VARIABLE serOutp : STD_LOGIC;
	BEGIN
		IF (rst = '1') THEN
			outReg_t := (OTHERS => '0');
			serOutp := '0';
		ELSIF (clk = '1' AND clk'event) THEN
			IF zero = '1' THEN
				outReg_t := (OTHERS => '0');
			ELSIF load = '1' THEN
				outReg_t := inReg;
			ELSIF shiftL = '1' THEN
				serOutp := outReg_t (len - 1);
				outReg_t := outReg_t (len - 2 DOWNTO 0) & serIn;
			ELSIF shiftR = '1' THEN
				serOutp := outReg_t (0);
				outReg_t := serIn & outReg_t (len - 1 DOWNTO 1);
			END IF;
		END IF;
		outReg <= outReg_t;
		serOut <= serOutp;
	END PROCESS;
END ARCHITECTURE behavioral;
		       
