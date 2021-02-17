-- **************************************************************************************
--	Filename:	maia_datapath.vhd
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
--	Datapath of the TETRISC Maia core
--
-- **************************************************************************************

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY maia_datapath IS
	GENERIC ( len : INTEGER := 32);
	PORT (
		clk, rst : IN STD_LOGIC; 
		writeRegFile, setOne, setZero, ComparedSignedUnsignedBar : IN STD_LOGIC;
		selPC, selPCJ, selI4, selAdd, selJL, selADR, selI4PC, selInc4PC, 
		selBSU,selLLU, selASU, selAAU,selDARU, 
		selData, selP1, selP2, selImm : IN STD_LOGIC;
		ldPC, zeroPC, ldADR, zeroADR, ldDR, zeroDR, ldIR, zeroIR  : IN STD_LOGIC;
		selShift : IN STD_LOGIC_VECTOR (1 DOWNTO 0);--
		addSubBar, pass, selAuipc : IN STD_LOGIC;
		muxCode : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
		selLogic : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
  		startDAWU, startDARU, memReady, loadSignedUnsignedBar  : IN STD_LOGIC;
  		startMultiplyAAU, startDivideAAU, signedSigned,signedUnsigned, unsignedUnsigned, selAAL,	selAAH : IN STD_LOGIC;
  		completeAAU  : OUT STD_LOGIC;
		nBytes : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
		memDataIn  : IN STD_LOGIC_VECTOR (7 DOWNTO 0);		
	    memAddrDAWU, memAddrDARU, IR : OUT STD_LOGIC_VECTOR (len-1 DOWNTO 0);
		memDataOut  : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
		lt, eq, gt, completeDAWU, completeDARU, readMem, writeMem, dataError : OUT STD_LOGIC
	);
END ENTITY maia_datapath;

ARCHITECTURE behavioral OF maia_datapath IS 
	SIGNAL imm12 : STD_LOGIC_VECTOR (11 DOWNTO 0);
	SIGNAL immediate, inst, resAAH, resAAL : STD_LOGIC_VECTOR (len-1 DOWNTO 0);
	SIGNAL instrError   : STD_LOGIC;
	SIGNAL rs1, rs2, rd : STD_LOGIC_VECTOR (4 DOWNTO 0);
	SIGNAL p1, p2, writeData, outMux6  : STD_LOGIC_VECTOR (len-1 DOWNTO 0);
	SIGNAL dataDARU, dataDAWU : STD_LOGIC_VECTOR (len-1 DOWNTO 0);
	SIGNAL addResult, lluResult, asuResult, aauResult, bsuResult, outADR, 
	outMux2, inPC, outPC, inc4PC, outMux5, addrIn : STD_LOGIC_VECTOR (len-1 DOWNTO 0);
	--SIGNAL selAAL, selAAH, selQ, selRem : STD_LOGIC;
BEGIN

	IR <= inst;
	registerFile : ENTITY WORK.maia_register_file 
					   GENERIC MAP (len => 32) 
					   PORT MAP (clk => clk,	rst => rst,	setZero => setZero,
							setOne => setOne,	rs1 => inst (19 DOWNTO 15),	rs2 => inst (24 DOWNTO 20),	
							rd => inst (11 DOWNTO 7), writeData => writeData,
							writeRegFile => writeRegFile, p1 => p1, p2 => p2);
										  


	regIR : ENTITY WORK.maia_register 
				GENERIC MAP (len => 32) 
				PORT MAP (clk => clk, rst => rst, zero => zeroIR, 
					load => ldIR, inReg => dataDARU , outReg => inst);	

	immSelSignEx : ENTITY WORK.maia_imm_sel_sign_ext 
					   PORT MAP (IR7 => inst (7), IR20 => inst (20), IR31 => inst (31),
							IR11_8 => inst (11 DOWNTO 8), IR19_12 => inst (19 DOWNTO 12),
							IR24_21 => inst (24 DOWNTO 21), IR30_25 => inst (30 DOWNTO 25),
							selI => muxCode (0), selS => muxCode (1), 
							selBUJ => muxCode (2), selIJ => muxCode (3), 
							selSB => muxCode (4), selU => muxCode (5),
							selISBJ => muxCode (6), selIS => muxCode (7),
							selB => muxCode (8),selJ => muxCode (9),	
							selISB => muxCode (10), selUJ => muxCode (11), Imm => immediate);

	adder : ENTITY WORK.maia_adder 
				GENERIC MAP (N => 32) 
				PORT MAP (Cin => '0', A => immediate, B => outMux2, 
					addResult => addResult, carryOut => OPEN);

	mux1 : ENTITY WORK.maia_multiplexer 
			   GENERIC MAP (len => 32) 
			   PORT MAP (a => addResult, b => inc4PC, s0 => selAdd,
					s1 => selI4, w => inPC );

	regPC : ENTITY WORK.maia_register 
				GENERIC MAP (len => 32) 
				PORT MAP (clk => clk, rst => rst, zero => zeroPC, 
					load => ldPC, inReg => inPC, outReg => outPC);										  

	mux2 : ENTITY WORK.maia_multiplexer 
			  GENERIC MAP (len => 32) 
			  PORT MAP (a => p1, b => outPC, s0 => selJL, s1 => selPC, w => outMux2);

	mux3 : ENTITY WORK.maia_multiplexer 
			   GENERIC MAP (len => 32) 
			   PORT MAP (a => outADR, b => outMux2, s0 => selADR, s1 => selPCJ, w => addrIn);		

	regADR : ENTITY WORK.maia_register 
				GENERIC MAP (len => 32) 
				PORT MAP (clk => clk, rst => rst, zero => zeroADR, 
					load => ldADR, inReg => addResult, outReg => outADR);																  


	i4PC : ENTITY WORK.maia_adder 
			   GENERIC MAP (N => 32) 
			   PORT MAP (Cin => '0', A => outPC, B => (31 downto 3 => '0') & "100", 
			   addResult => inc4PC, carryOut => OPEN);

	writeData <=  inc4PC    WHEN selInc4PC = '1' ELSE 
				  bsuResult WHEN selBSU = '1' ELSE
				  lluResult WHEN selLLU = '1' ELSE
				  asuResult WHEN selASU = '1' ELSE
				  aauResult WHEN selAAU = '1' ELSE
				   dataDARU WHEN selDARU = '1' ELSE
				   (OTHERS => '0');
				 

	regDR : ENTITY WORK.maia_register 
				GENERIC MAP (len => 32) 
				PORT MAP (clk => clk, rst => rst, zero => zeroDR, 
					load => ldDR, inReg => p2, outReg => dataDAWU);

	mux5 : ENTITY WORK.maia_multiplexer 
				GENERIC MAP (len => 32) 
				PORT MAP (a => p2, b => immediate, s0 => selP2, s1 => selImm, w => outMux5);
	mux6 : ENTITY WORK.maia_multiplexer 
				GENERIC MAP (len => 32)
				PORT MAP (a => p1, b => outPC, s0 => selP1, s1 => selAuipc, w => outMux6);

	LLU : ENTITY WORK.maia_llu 
			  GENERIC MAP (N => 32)
			  PORT MAP (ain => outMux6, bin => outMux5, selLogic => selLogic, result => lluResult);

	BSU : ENTITY WORK.maia_barrel_shifter 
			  GENERIC MAP (len => 32) 
			  PORT MAP (shIn => outMux6, nSh => outMux5 (4 DOWNTO 0), selSh => selShift, shOut => bsuResult);

	comparator: ENTITY WORK.maia_comparator 
					GENERIC MAP (n => len)
					PORT MAP (ain => outMux6, bin => outMux5, CompareSignedUnsignedBar => ComparedSignedUnsignedBar ,
						Lt => lt, Eq => eq, Gt => gt);

	addSub : ENTITY WORK.maia_adder_subtractor 
				 GENERIC MAP (len => len) 
				 PORT MAP (a => outMux6, b => outMux5, subSel => addSubBar, pass => pass, 
					cout => OPEN, outRes => asuResult ); --addSel, subSel															

	aau: ENTITY WORK.maia_aau GENERIC MAP (n => len)  PORT MAP(
			clk => clk,
			rst => rst,

			ain => outMux6,
			bin => p2,
			startMultAAU => startMultiplyAAU,
			startDivideAAU => startDivideAAU,
			SignedSigned => signedSigned,
			SignedUnsigned => signedUnsigned,
			UnsignedUnsigned => unsignedUnsigned,
			resAAU1 => resAAH,
			resAAU2 => resAAL,
			completeAAU => completeAAU

		);

	aauResult <= resAAH WHEN selAAH = '1' ElSE 
				 resAAL WHEN selAAL = '1' ELSE (OTHERS => '0');


	dawu : ENTITY WORK.maia_dawu 
			   PORT MAP (clk => clk, rst => rst, startDAWU => startDAWU, 
				  memReady => memReady, nBytes => nBytes, addrIn => addrIn,
				  dataIn => dataDAWU,	addrOut => memAddrDAWU, dataOut => memDataOut,
				  writeMem => writeMem, dataError => dataError, completeDAWU => completeDAWU);
	
	daru: ENTITY WORK.maia_daru 
			  PORT MAP (clk => clk,	rst => rst,	startDARU => startDARU, loadSignedUnsignedBar => loadSignedUnsignedBar,	nBytes => nBytes,
				 addrIn => addrIn,	memData => memDataIn, memReady => memReady, 
				 completeDARU => completeDARU, dataOut => dataDARU,--
				 addrOut => memAddrDARU,	dataError => dataError,
				 instrError => instrError, readMem => readMem);
	
END ARCHITECTURE behavioral;
