-- **************************************************************************************
--	Filename:	maia_core.vhd
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
--	Top entity of the TETRISC Maia core
--
-- **************************************************************************************

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY maia_core IS
GENERIC( len : INTEGER := 32);
PORT (
		clk, rst, memReady : IN std_logic;
		memRead, memWrite : OUT std_logic;
		memDataIN : IN std_logic_vector (7 DOWNTO 0);		
		memDataOUT : OUT std_logic_vector (7 DOWNTO 0);

		memAddr : OUT std_logic_vector (len-1 DOWNTO 0)
		--memAddrDARU : OUT std_logic_vector (len-1 DOWNTO 0)
		-- : IN std_logic; 
		--w : OUT std_logic_vector (len-1 DOWNTO 0)
		);
END ENTITY;
--
ARCHITECTURE procedural OF maia_core IS 
SIGNAL selPCJ, selPC, selADR, selI4, selP2, selP1, selJL, selImm, selAdd, selI4PC, selInc4pc,selData, selBSU, selLLU, selDARU,selASU, selAAU, shr, shl, 
		 dataInstrBar, writeRegFile, addSubBar, pass, selAuipc, comparedsignedunsignedbar,
	    ldIR, ldADR, ldPC, ldDr,
		 setOne, setZero,
		 startDARU, startDAWU, completeDARU, completeDAWU, loadSignedUnsignedBar,
		 startMultiplyAAU, startDivideAAU, completeAAU, signedSigned, signedUnsigned, unsignedUnsigned, selAAL,	selAAH, 
		 eq, gt,lt,
		 dataerror:std_logic;
SIGNAL nBytes : std_logic_vector (1 DOWNTO 0);
SIGNAL selLogic : std_logic_vector (1 DOWNTO 0);
SIGNAL selShift : std_logic_vector (1 DOWNTO 0);
SIGNAL muxCode : std_logic_vector (11 DOWNTO 0);
SIGNAL IR : std_logic_vector (31 DOWNTO 0);


BEGIN


datapath: ENTITY WORK.maia_datapath PORT MAP(
		clk => clk,
		rst => rst,
		writeRegFile => writeRegFile,
		setOne => setOne,
		setZero => setZero,
		ComparedSignedUnsignedBar => ComparedSignedUnsignedBar,
		selPC => selPC,
		selPCJ => selPCJ,
		selI4 => selI4,
		selAdd => selAdd,
		selP1 => selP1,
		selADR => selADR,
		selI4PC => selI4PC,
		selInc4pc => selInc4pc,
		selBSU => selBSU,
		selLLU => selLLU,
		selASU => selASU,
		selAAU => selAAU,
		selDARU => selDARU,
		selData => selData,
		selP2 => selP2,
		selJL => selJL,
		selImm => selImm ,
		ldPC => ldPC,
		zeroPC => '0',
		ldADR => ldADR,
		zeroADR => '0',
		ldDR => ldDR,
		zeroDR => '0',
		ldIR => ldIR,
		zeroIR => '0',
		selShift => selShift,

		addSubBar => addSubBar,
		pass => pass,
		selAuipc => selAuipc,
		muxCode => muxCode,
		selLogic => selLogic,
		startDAWU => startDAWU,
		startDARU => startDARU,
		memReady => memReady,
		loadSignedUnsignedBar => loadSignedUnsignedBar,
		
		startMultiplyAAU =>  startMultiplyAAU,
		startDivideAAU => startDivideAAU   , 
		signedSigned => signedSigned    ,
		signedUnsigned => signedUnsigned   , 
		unsignedUnsigned => unsignedUnsigned   , 
		selAAL => selAAL   ,	
		selAAH =>  selAAH  , 
  
  		completeAAU => completeAAU,
		
		nBytes => nBytes,
		memDataIn => memDataIn,
		memAddrDAWU => memAddr,
		memAddrDARU => memAddr,
		IR => IR,
		memDataOut => memDataOut,
		lt => lt,
		eq => eq,
		gt => gt,
		completeDAWU => completeDAWU,
		completeDARU => completeDARU,
		readMem => memRead,
		writeMem => memWrite,
		dataError => dataError 
	);


controller: ENTITY WORK.maia_controller PORT MAP( 
		clk => clk,
		rst => rst,  
		completeDARU => completeDARU,
		completeDAWU => completeDAWU,
		completeAAU => completeAAU,
		lt => lt,
		eq => eq,
		gt => gt,
		IR => IR,
		muxCode => muxCode,
		nBytes => nBytes,
		selLogic => selLogic,
		selShift => selShift,
		selPCJ => selPCJ,
		selPC => selPC,
		selADR => selADR,
		selI4 => selI4,
		selP1 => selP1,
		selP2 => selP2,
		selJL => selJL,
		selImm => selImm,
		selAdd => selAdd,
		selInc4PC  => selInc4PC, 
		selBSU  => selBSU,
		selLLU  => selLLU, 
		selASU  => selASU, 
		selAAU  => selAAU,
		selDARU  => selDARU, 
		dataInstrBar => dataInstrBar,
		writeRegFile => writeRegFile,
		addSubBar => addSubBar,
		pass => pass,
		selAuipc => selAuipc,
		comparedsignedunsignedbar => comparedsignedunsignedbar,
		ldIR => ldIR,
		ldADR => ldADR,
		ldPC => ldPC,
		ldDr => ldDr,
		setOne => setOne,
		setZero => setZero,
		startDARU => startDARU,
		startDAWU => startDAWU,
		loadSignedUnsignedBar => loadSignedUnsignedBar,
		startMultiplyAAU => startMultiplyAAU,
		startDivideAAU => startDivideAAU,
		signedSigned => signedSigned,
		signedUnsigned => signedUnsigned,
		unsignedUnsigned => unsignedUnsigned,
		selAAL => selAAL,	
		selAAH => selAAH 
	);
END ARCHITECTURE procedural;
