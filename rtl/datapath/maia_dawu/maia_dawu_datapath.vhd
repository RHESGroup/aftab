-- **************************************************************************************
--	Filename:	maia_dawu_datapath.vhd
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
--	Datapath of the Data Adjustment Write Unit (DAWU) of the TETRISC Maia core
--
-- **************************************************************************************

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY maia_dawu_datapath IS 
	PORT (
		clk, rst : IN STD_LOGIC;
		ldData, enableData, enableAddr, incCnt, zeroCnt, initCnt, ldNumBytes, 
		zeroNumBytes, ldAddr, zeroAddr, zeroData  : IN STD_LOGIC;
		nBytesIn, initValue : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
		dataIn  : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		addrIn  : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		coCnt   : OUT STD_LOGIC;
		dataOut : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
		addrOut : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
END ENTITY maia_dawu_datapath;
 
ARCHITECTURE Behavioral OF maia_dawu_datapath IS
   SIGNAL muxOut, outReg0, outReg1, outReg2, outReg3 : STD_LOGIC_VECTOR (7 DOWNTO 0);
   SIGNAL addrOutReg : STD_LOGIC_VECTOR (31 DOWNTO 0);
   SIGNAL nBytesOut, outCnt, addrOutRegP : STD_LOGIC_VECTOR (1 DOWNTO 0);
BEGIN  

--Register Part 

	nBytesReg : ENTITY WORK.maia_register 
				  GENERIC MAP (len => 2) 
				  PORT MAP (clk => clk, rst => rst, zero => zeroNumBytes, 		
					 load => ldNumBytes, inReg => nBytesIn, outReg => nBytesOut);
										  
	addrReg : ENTITY WORK.maia_register
				GENERIC MAP (len => 32) 
				PORT MAP (clk => clk, rst => rst, zero => zeroAddr, 
					load => ldAddr, inReg => addrIn, outReg => addrOutReg);
 
	reg0 : ENTITY WORK.maia_register
			GENERIC MAP (len => 8) 
			PORT MAP (clk => clk, rst => rst, zero => zeroData, 
				load => ldData, inReg => dataIn (7 DOWNTO 0), outReg => outReg0);
										  
	reg1 : ENTITY WORK.maia_register 
			GENERIC MAP (len => 8) 
			PORT MAP (clk => clk, rst => rst, zero => zeroData, 
				load => ldData, inReg => dataIn (15 DOWNTO 8), outReg => outReg1);
										  
	reg2 : ENTITY WORK.maia_register 
			GENERIC MAP (len => 8) 
			PORT MAP (clk => clk, rst => rst, zero => zeroData, 
				load => ldData, inReg => dataIn (23 DOWNTO 16), outReg => outReg2);
										  
	reg3 : ENTITY WORK.maia_register 
			GENERIC MAP(len => 8) 
			PORT MAP(clk => clk, rst => rst, zero => zeroData, 
				load => ldData, inReg => dataIn(31 DOWNTO 24), outReg => outReg3);
										  
										  
	--Counter Part
	Counter : ENTITY WORK.maia_counter 
				PORT MAP(clk => clk, rst => rst, zeroCnt => zeroCnt, incCnt => incCnt,
					initCnt => initCnt, initValue => initValue, outCnt => outCnt);
	muxOut <= outReg0 WHEN outCnt = "00" ELSE
			  outReg1 WHEN outCnt = "01" ELSE
			  outReg2 WHEN outCnt = "10" ELSE
			  outReg3 WHEN outCnt = "11";
	coCnt <= '1' WHEN (outCnt = nBytesOut) ELSE '0';

	--Buffers
	addrOutRegp <= addrOutReg(1 DOWNTO 0) OR outCnt;												

	addrOut <= (addrOutReg (31 DOWNTO 2) & addrOutRegp)  WHEN (enableAddr = '1') ELSE (OTHERS => 'Z');											
	dataOut <= muxOut  WHEN (enableData = '1') ELSE (OTHERS => 'Z');											

END ARCHITECTURE Behavioral;
