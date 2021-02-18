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
		clk : IN std_logic;
		rst : IN std_logic;
		memReady : IN std_logic;
		memRead : OUT std_logic;
		memWrite : OUT std_logic;
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
	
	SIGNAL selPCJ : std_logic;
	SIGNAL selPC : std_logic;
	SIGNAL selADR : std_logic;
	SIGNAL selI4 : std_logic;
	SIGNAL selP2 : std_logic;
	SIGNAL selP1 : std_logic;
	SIGNAL selJL : std_logic;
	SIGNAL selImm : std_logic;
	SIGNAL selAdd : std_logic;
	SIGNAL selI4PC : std_logic;
	SIGNAL selInc4pc : std_logic;
	SIGNAL selData : std_logic;
	SIGNAL selBSU : std_logic;
	SIGNAL selLLU : std_logic;
	SIGNAL selDARU : std_logic;
	SIGNAL selASU : std_logic;
	SIGNAL selAAU : std_logic;
	SIGNAL shr : std_logic;
	SIGNAL shl : std_logic;
	SIGNAL dataInstrBar : std_logic;
	SIGNAL writeRegFile : std_logic;
	SIGNAL addSubBar : std_logic;
	SIGNAL pass : std_logic;
	SIGNAL selAuipc : std_logic;
	SIGNAL comparedsignedunsignedbar : std_logic;
	SIGNAL ldIR : std_logic;
	SIGNAL ldADR : std_logic;
	SIGNAL ldPC : std_logic;
	SIGNAL ldDr : std_logic;
	SIGNAL setOne : std_logic;
	SIGNAL setZero : std_logic;
	SIGNAL startDARU : std_logic;
	SIGNAL startDAWU : std_logic;
	SIGNAL completeDARU : std_logic;
	SIGNAL completeDAWU : std_logic;
	SIGNAL loadSignedUnsignedBar : std_logic;
	SIGNAL startMultiplyAAU : std_logic;
	SIGNAL startDivideAAU : std_logic;
	SIGNAL completeAAU : std_logic;
	SIGNAL signedSigned : std_logic;
	SIGNAL signedUnsigned : std_logic;
	SIGNAL unsignedUnsigned : std_logic;
	SIGNAL selAAL : std_logic;
	SIGNAL selAAH : std_logic;
	SIGNAL eq : std_logic;
	SIGNAL gt : std_logic;
	SIGNAL lt : std_logic;
	SIGNAL dataerror : std_logic;
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
