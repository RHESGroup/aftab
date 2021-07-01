-- **************************************************************************************
--	Filename:	aftab_core.vhd
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
--	Top entity of the AFTAB core
--
-- **************************************************************************************
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY aftab_core IS
	GENERIC (len : INTEGER := 32);
	PORT (
		clk        : IN  STD_LOGIC;
		rst        : IN  STD_LOGIC;
		memReady   : IN  STD_LOGIC;
		memRead    : OUT STD_LOGIC;
		memWrite   : OUT STD_LOGIC;
		memDataIN  : IN  STD_LOGIC_VECTOR (7 DOWNTO 0);
		memDataOUT : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
		memAddr    : OUT STD_LOGIC_VECTOR (len - 1 DOWNTO 0)
	);
END ENTITY;
--
ARCHITECTURE procedural OF aftab_core IS
	SIGNAL selPCJ : STD_LOGIC;
	SIGNAL selPC : STD_LOGIC;
	SIGNAL selADR : STD_LOGIC;
	SIGNAL selI4 : STD_LOGIC;
	SIGNAL selP2 : STD_LOGIC;
	SIGNAL selP1 : STD_LOGIC;
	SIGNAL selJL : STD_LOGIC;
	SIGNAL selImm : STD_LOGIC;
	SIGNAL selAdd : STD_LOGIC;
	SIGNAL selI4PC : STD_LOGIC;
	SIGNAL selInc4pc : STD_LOGIC;
	SIGNAL selData : STD_LOGIC;
	SIGNAL selBSU : STD_LOGIC;
	SIGNAL selLLU : STD_LOGIC;
	SIGNAL selDARU : STD_LOGIC;
	SIGNAL selASU : STD_LOGIC;
	SIGNAL selAAU : STD_LOGIC;
	SIGNAL shr : STD_LOGIC;
	SIGNAL shl : STD_LOGIC;
	SIGNAL dataInstrBar : STD_LOGIC;
	SIGNAL writeRegFile : STD_LOGIC;
	SIGNAL addSubBar : STD_LOGIC;
	SIGNAL pass : STD_LOGIC;
	SIGNAL selAuipc : STD_LOGIC;
	SIGNAL comparedsignedunsignedbar : STD_LOGIC;
	SIGNAL ldIR : STD_LOGIC;
	SIGNAL ldADR : STD_LOGIC;
	SIGNAL ldPC : STD_LOGIC;
	SIGNAL ldDr : STD_LOGIC;
	SIGNAL ldByteSigned : STD_LOGIC;
	SIGNAL ldHalfSigned : STD_LOGIC;
	SIGNAL load : STD_LOGIC;
	SIGNAL setOne : STD_LOGIC;
	SIGNAL setZero : STD_LOGIC;
	SIGNAL startDARU : STD_LOGIC;
	SIGNAL startDAWU : STD_LOGIC;
	SIGNAL completeDARU : STD_LOGIC;
	SIGNAL completeDAWU : STD_LOGIC;
	SIGNAL startMultiplyAAU : STD_LOGIC;
	SIGNAL startDivideAAU : STD_LOGIC;
	SIGNAL completeAAU : STD_LOGIC;
	SIGNAL signedSigned : STD_LOGIC;
	SIGNAL signedUnsigned : STD_LOGIC;
	SIGNAL unsignedUnsigned : STD_LOGIC;
	SIGNAL selAAL : STD_LOGIC;
	SIGNAL selAAH : STD_LOGIC;
	SIGNAL eq : STD_LOGIC;
	SIGNAL gt : STD_LOGIC;
	SIGNAL lt  : STD_LOGIC;
	SIGNAL dataerror : STD_LOGIC;
	SIGNAL nBytes : STD_LOGIC_VECTOR (1 DOWNTO 0);
	SIGNAL selLogic : STD_LOGIC_VECTOR (1 DOWNTO 0);
	SIGNAL selShift : STD_LOGIC_VECTOR (1 DOWNTO 0);
	SIGNAL muxCode : STD_LOGIC_VECTOR (11 DOWNTO 0);
	SIGNAL IR : STD_LOGIC_VECTOR (31 DOWNTO 0);
BEGIN
	datapathAFTAB : ENTITY WORK.aftab_datapath PORT MAP(
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
		selInc4pc => selInc4pc,
		selBSU => selBSU,
		selLLU => selLLU,
		selASU => selASU,
		selAAU => selAAU,
		selDARU => selDARU,
		selP2 => selP2,
		selJL => selJL,
		selImm => selImm,
		ldPC => ldPC,
		zeroPC => '0',
		ldADR => ldADR,
		zeroADR => '0',
		ldDR => ldDR,
		zeroDR => '0',
		ldIR => ldIR,
		zeroIR => '0',
		ldByteSigned => ldByteSigned,
		ldHalfSigned => ldHalfSigned,
		load => load,
		selShift => selShift,
		addSubBar => addSubBar,
		pass => pass,
		selAuipc => selAuipc,
		muxCode => muxCode,
		selLogic => selLogic,
		startDAWU => startDAWU,
		startDARU => startDARU,
		memReady => memReady,
		startMultiplyAAU => startMultiplyAAU,
		startDivideAAU => startDivideAAU,
		signedSigned => signedSigned,
		signedUnsigned => signedUnsigned,
		unsignedUnsigned => unsignedUnsigned,
		selAAL => selAAL,
		selAAH => selAAH,
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
	controllerAFTAB : ENTITY WORK.aftab_controller PORT MAP(
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
		selInc4PC => selInc4PC,
		selBSU => selBSU,
		selLLU => selLLU,
		selASU => selASU,
		selAAU => selAAU,
		selDARU => selDARU,
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
		ldByteSigned => ldByteSigned,
		ldHalfSigned => ldHalfSigned,
		load => load,
		setOne => setOne,
		setZero => setZero,
		startDARU => startDARU,
		startDAWU => startDAWU,
		startMultiplyAAU => startMultiplyAAU,
		startDivideAAU => startDivideAAU,
		signedSigned => signedSigned,
		signedUnsigned => signedUnsigned,
		unsignedUnsigned => unsignedUnsigned,
		selAAL => selAAL,
		selAAH => selAAH
		);
END ARCHITECTURE procedural;
