-- **************************************************************************************
--	Filename:	aftab_booth_multiplier.vhd
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
--	Generic Booth multiplier for the AFTAB core
--
-- **************************************************************************************
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY aftab_booth_multiplier IS
	GENERIC (len : INTEGER := 33);
	PORT (
		clk 	   : IN  STD_LOGIC;
		rst        : IN  STD_LOGIC;
		startBooth : IN  STD_LOGIC;
		M          : IN  STD_LOGIC_VECTOR (len - 1 DOWNTO 0);
		Q          : IN  STD_LOGIC_VECTOR (len - 1 DOWNTO 0);
		P          : OUT STD_LOGIC_VECTOR (2 * len - 1 DOWNTO 0);
		doneBooth  : OUT STD_LOGIC
	);
END ENTITY aftab_booth_multiplier;

ARCHITECTURE behavioral OF aftab_booth_multiplier IS
	SIGNAL op   	: STD_LOGIC_VECTOR (1 DOWNTO 0);
	SIGNAL shrQ 	: STD_LOGIC;
	SIGNAL ldQ 		: STD_LOGIC;
	SIGNAL ldM 		: STD_LOGIC;
	SIGNAL ldP 		: STD_LOGIC;
	SIGNAL zeroP 	: STD_LOGIC;
	SIGNAL sel 		: STD_LOGIC;
	SIGNAL subSel 	: STD_LOGIC;
BEGIN
	Datapath :	 ENTITY WORK.aftab_booth_multiplier_datapath
					GENERIC MAP(len => len)
					PORT MAP(
						clk => clk, 
						rst => rst, 
						shrQ => shrQ, 
						ldQ => ldQ, 
						ldM => ldM,
						ldp => ldp, 
						zeroP => zeroP, 
						sel => sel,
						subsel => subsel, 
						M => M, 
						Q => Q, 
						P => P, 
						op => op);
						
	Controller : ENTITY WORK.aftab_booth_multiplier_controller
					GENERIC MAP(len => len)
					PORT MAP(
						clk => clk, 
						rst => rst,
						startBooth => startBooth,
						shrQ => shrQ, 
						ldQ => ldQ, 
						ldM => ldM,
						ldP => ldP, 
						zeroP => zeroP, 
						sel => sel,
						subSel => subSel,
						op => op, 
						done => doneBooth);
END ARCHITECTURE behavioral;
