-- **************************************************************************************
--	Filename:	maia_divider_datapath.vhd
--	Project:	TETRISC 
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
--	Datapath of generic integer divider for the TETRISC Maia core
--
-- **************************************************************************************

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY maia_divider_datapath IS
	GENERIC( len : INTEGER := 33);
	PORT (
		clk, rst : IN STD_LOGIC;
		dividend, divisor : IN STD_LOGIC_VECTOR (len-1 DOWNTO 0); 
		shRRegR, ShLRegR, ldRegR, zeroRegR, QQ0, selMux1 : IN STD_LOGIC;
		shRRegQ,ShLRegQ,ldRegQ,zeroRegQ,zeroRegM,ldRegM  : IN STD_LOGIC;
		R33 : OUT STD_LOGIC;
		Q   : OUT STD_LOGIC_VECTOR (len-1 DOWNTO 0); 
        Remainder : OUT STD_LOGIC_VECTOR (len DOWNTO 0)
	);
END ENTITY maia_divider_datapath;

ARCHITECTURE behavioral OF maia_divider_datapath IS
	SIGNAL AddResult, sub, M, divisorp, Rprev : STD_LOGIC_VECTOR (len DOWNTO 0);
	SIGNAL line1, outMux1, Qprev : STD_LOGIC_VECTOR (len-1 DOWNTO 0);
	SIGNAL leftbitOutR, leftbitOutQ : STD_LOGIC;
	SIGNAL rightbitInR : STD_LOGIC;
BEGIN

	R33 <= sub(len);
	-- ShReg 33 bit R
	ShRegR : ENTITY work.maia_shift_register 
				GENERIC MAP (len+1) 
				PORT MAP (clk => clk, rst => rst, 
					inReg => AddResult, shiftR => shRRegR, shiftL => ShLRegR, 
					load => ldRegR, zero => zeroRegR, serIn => leftbitOutQ,
					serOut => leftbitOutR, outReg => Rprev);
	-- ShReg 32 bit Q
	ShRegQ : ENTITY work.maia_shift_register
				GENERIC MAP (len) 
				PORT MAP (clk => clk, rst => rst, 
					inReg => outMux1, shiftR => shRRegQ, shiftL => ShLRegQ,
					load => ldRegQ, zero => zeroRegQ,
					serIn => '0', serOut => leftbitOutQ,
					outReg => Qprev);
	
	--rightbitInR <= Qprev(len-1);
	-- concatenation
	divisorp <= divisor(len-1) & divisor;
	-- Reg 33 bit M
	RegM: ENTITY WORK.maia_register 
			  GENERIC MAP (len => len+1) 
			  PORT MAP (clk => clk, rst => rst, zero => zeroRegM, 
				  load => ldRegM, inReg => divisorp, outReg => M);
	-- Subtractor 33 bit 
	sub <= Rprev - M;
	-- line 1
	line1 <= Qprev (len-1 DOWNTO 1) & QQ0;
	-- Mux 33 bit
	Mux33b: ENTITY work.maia_multiplexer_div 
				GENERIC MAP (len => len) 
				PORT MAP (a => dividend, b => line1,
					sel => selMux1,W => outMux1);
	-- Mux 34 bit
	Mux34b: ENTITY work.maia_multiplexer_div 
				GENERIC MAP (len => len+1) 
				PORT MAP (a => sub, b => Rprev,
					 sel => sub(len),W => AddResult);
	Q <= Qprev;
	Remainder <= Rprev;

END ARCHITECTURE behavioral;
