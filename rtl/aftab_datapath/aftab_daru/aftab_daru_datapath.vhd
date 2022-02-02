-- **************************************************************************************
--	Filename:	aftab_daru_datapath.vhd
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
--	Datapath of the Data Adjustment Read Unit (DARU) of the AFTAB core
--
-- **************************************************************************************
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY aftab_daru_datapath IS
	GENERIC (len : INTEGER := 32);
	PORT (
		clk			 : IN STD_LOGIC;
		rst 		 : IN STD_LOGIC;
		nBytes 		 : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
		initValueCnt : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
		addrIn       : IN STD_LOGIC_VECTOR (len - 1 DOWNTO 0);
		memData      : IN STD_LOGIC_VECTOR ((len/4) - 1 DOWNTO 0);
		zeroAddr     : IN STD_LOGIC;
		ldAddr       : IN STD_LOGIC;
		selldEn      : IN STD_LOGIC;
		zeroNumBytes : IN STD_LOGIC;
		ldNumBytes   : IN STD_LOGIC;
		zeroCnt      : IN STD_LOGIC;
		incCnt       : IN STD_LOGIC;
		initCnt 	 : IN STD_LOGIC;
		initReading  : IN STD_LOGIC;
		enableAddr   : IN STD_LOGIC;
		enableData   : IN STD_LOGIC;
		coCnt 		 : OUT STD_LOGIC;
		dataOut      : OUT STD_LOGIC_VECTOR (len - 1 DOWNTO 0);
		addrOut      : OUT STD_LOGIC_VECTOR (len - 1 DOWNTO 0)
	);
END ENTITY aftab_daru_datapath;

ARCHITECTURE behavioral OF aftab_daru_datapath IS
	SIGNAL readAddr   : STD_LOGIC_VECTOR (len - 1 DOWNTO 0);
	SIGNAL readAddrP  : STD_LOGIC_VECTOR (len - 1 DOWNTO 0);
	SIGNAL dataIn     : STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL outCnt 	  : STD_LOGIC_VECTOR (1 DOWNTO 0);
	SIGNAL nBytesOut  : STD_LOGIC_VECTOR (1 DOWNTO 0);
	SIGNAL outDecoder : STD_LOGIC_VECTOR (3 DOWNTO 0);
BEGIN

	dataIn <= memData WHEN enableData = '1' ELSE	(OTHERS => 'Z');
	-- addrReg
	addrReg : ENTITY WORK.aftab_register
				GENERIC MAP(len => 32)
				PORT MAP(
					clk => clk, 
					rst => rst, 
					zero => zeroAddr,
					load => ldAddr,
					inReg => addrIn, 
					outReg => readAddr);
	-- Decoder
	decoder : ENTITY WORK.aftab_decoder
				PORT MAP(
					inDecoder => outCnt, 
					En => selldEn, 
					outDecoder => outDecoder);
	-- nByte Register
	nByteReg : ENTITY WORK.aftab_register
				GENERIC MAP(len => 2)
				PORT MAP(
					clk => clk, 
					rst => rst, 
					zero => zeroNumBytes,
					load => ldNumBytes,
					inReg => nBytes, 
					outReg => nBytesOut);
	-- Counter
	Counter : ENTITY WORK.aftab_counter 
				GENERIC MAP(len => 2)
				PORT MAP(
					clk => clk, 
					rst => rst,
					zeroCnt => zeroCnt, 
					incCnt => incCnt,
					initCnt => initCnt, 
					initValue => initValueCnt, 
					outCnt => outCnt, 
					coCnt => OPEN);
	-- dataReg
	Reg0 : ENTITY WORK.aftab_register
			GENERIC MAP(len => 8)
			PORT MAP(
				clk => clk,
				rst => rst, 
				zero => initReading,
				load => outDecoder (0), 
				inReg => dataIn, 
				outReg => dataOut (7 DOWNTO 0));
	Reg1 : ENTITY WORK.aftab_register
			GENERIC MAP(len => 8)
			PORT MAP(
				clk => clk, 
				rst => rst, 
				zero => initReading,
				load => outDecoder (1), 
				inReg => dataIn, 
				outReg => dataOut (15 DOWNTO 8));
	Reg2 : ENTITY WORK.aftab_register
			GENERIC MAP(len => 8)
			PORT MAP(
				clk => clk, 
				rst => rst, 
				zero => initReading,
				load => outDecoder (2), 
				inReg => dataIn, 
				outReg => dataOut (23 DOWNTO 16));
	Reg3 : ENTITY WORK.aftab_register
			GENERIC MAP(len => 8)
			PORT MAP(
				clk => clk, 
				rst => rst, 
				zero => initReading,
				load => outDecoder(3), 
				inReg => dataIn, 
				outReg => dataOut (31 DOWNTO 24));
	Adder : ENTITY WORK.aftab_opt_adder
				GENERIC MAP(len => 32)
				PORT MAP(
					A => readAddr,
					B => outCnt, 
					Sum => readAddrP);
	coCnt <= '1' WHEN (outCnt = nBytesOut) ELSE	'0';
	-- Error Decoder
	-- Error Register
	-- Tri-State
	addrOut <= readAddrP WHEN enableAddr = '1' ELSE	(OTHERS => 'Z');
END ARCHITECTURE behavioral;
