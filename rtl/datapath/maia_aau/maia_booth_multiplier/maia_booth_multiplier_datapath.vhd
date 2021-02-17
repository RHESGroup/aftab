-- **************************************************************************************
--	Filename:	maia_booth_multiplier_datapath.vhd
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
--	Datapath of the generic Booth multiplier for the TETRISC Maia core
--
-- **************************************************************************************

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY maia_booth_multiplier_datapath IS
	GENERIC (len: INTEGER := 33 );
	PORT(   
		clk, rst : IN STD_LOGIC;
		shrQ, ldQ, ldM, ldp, zeroP, sel, subsel: IN STD_LOGIC;
		M  : IN STD_LOGIC_VECTOR (len-1 DOWNTO 0);
		Q  : IN STD_LOGIC_VECTOR (len-1 DOWNTO 0);
		P  : OUT STD_LOGIC_VECTOR (2*len-1 DOWNTO 0);
		op : OUT STD_LOGIC_VECTOR (1 DOWNTO 0)
	);
END ENTITY maia_booth_multiplier_datapath;

ARCHITECTURE behavioral OF maia_booth_multiplier_datapath IS
	SIGNAL outM, Pin, Pout, result : STD_LOGIC_VECTOR (len-1 DOWNTO 0);
	SIGNAL outQ, shQ : STD_LOGIC_VECTOR (len DOWNTO 0);
	SIGNAL seiQ, seoQ : STD_LOGIC;
BEGIN
	mReg : ENTITY WORK.maia_register 
			GENERIC MAP(len => len) 
				PORT MAP(clk => clk, rst => rst, zero => '0', 
					load => ldM, inReg => M, outReg => outM);										  
	shQ <= (Q & '0');										  
	qReg   : ENTITY WORK.maia_shift_register 
				GENERIC MAP(len => len+1) 
				PORT MAP(clk => clk, rst => rst, inReg => shQ,
					shiftR => shrQ, shiftL => '0', load => ldQ, zero => '0', 
					serIn => seiQ, serOut => seoQ, outReg => outQ);
					
	pReg   : ENTITY WORK.maia_register 
				GENERIC MAP(len => len) 
				PORT MAP(clk => clk, rst => rst, zero => zeroP, 
					load => ldp, inReg => Pin, outReg => Pout);
					
	addSub : ENTITY WORK.maia_adder_subtractor 
				GENERIC MAP(len => len) 
				PORT MAP(a => Pout, b => outM, subSel => subSel, pass => '0',
					cout => OPEN, outRes => result );						  
					
	Pin <= (result (len - 1) & result (len - 1 DOWNTO 1)) WHEN sel = '1' ELSE (Pout(len - 1) & Pout (len - 1 DOWNTO 1));						  
	seiQ <= result (0) WHEN sel = '1' ELSE Pout (0);
	op <= outQ (1 DOWNTO 0); 
	P <= (Pout & outQ (len DOWNTO 1));
END ARCHITECTURE behavioral; 