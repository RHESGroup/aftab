-- **************************************************************************************
--	Filename:	aftab_dawu_datapath.vhd
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
--	Datapath of the Data Adjustment Write Unit (DAWU) of the AFTAB core
--
-- **************************************************************************************
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
ENTITY aftab_dawu_datapath IS
	GENERIC
		(len : INTEGER := 32);
	PORT
	(
		clk                 : IN  STD_LOGIC;
		rst                 : IN  STD_LOGIC;
		ldData              : IN  STD_LOGIC;
		enableData          : IN  STD_LOGIC;
		enableAddr          : IN  STD_LOGIC;
		incCnt              : IN  STD_LOGIC;
		zeroCnt             : IN  STD_LOGIC;
		initCnt             : IN  STD_LOGIC;
		ldNumBytes          : IN  STD_LOGIC;
		zeroNumBytes        : IN  STD_LOGIC;
		ldAddr              : IN  STD_LOGIC;
		zeroAddr            : IN  STD_LOGIC;
		zeroData            : IN  STD_LOGIC;
		nBytesIn            : IN  STD_LOGIC_VECTOR (1 DOWNTO 0);
		initValueCnt        : IN  STD_LOGIC_VECTOR (1 DOWNTO 0);
		dataIn              : IN  STD_LOGIC_VECTOR (len - 1 DOWNTO 0);
		addrIn              : IN  STD_LOGIC_VECTOR (len - 1 DOWNTO 0);
		checkMisalignedDAWU : IN  STD_LOGIC;
		storeMisalignedFlag : OUT STD_LOGIC;
		coCnt               : OUT STD_LOGIC;
		dataOut             : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
		addrOut             : OUT STD_LOGIC_VECTOR (len - 1 DOWNTO 0)
	);
END ENTITY aftab_dawu_datapath;
ARCHITECTURE Behavioral OF aftab_dawu_datapath IS
	SIGNAL muxOut     : STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL outReg0    : STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL outReg1    : STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL outReg2    : STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL outReg3    : STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL addrOutReg : STD_LOGIC_VECTOR (len - 1 DOWNTO 0);
	SIGNAL writeAddr  : STD_LOGIC_VECTOR (len - 1 DOWNTO 0);
	SIGNAL nBytesOut  : STD_LOGIC_VECTOR (1 DOWNTO 0);
	SIGNAL outCnt     : STD_LOGIC_VECTOR (1 DOWNTO 0);
BEGIN
	--Register Part
	nBytesReg : ENTITY WORK.aftab_register
		GENERIC
		MAP(len => 2)
		PORT MAP
		(
			clk    => clk,
			rst    => rst,
			zero   => zeroNumBytes,
			load   => ldNumBytes,
			inReg  => nBytesIn,
			outReg => nBytesOut);
	addrReg : ENTITY WORK.aftab_register
		GENERIC
		MAP(len => len)
		PORT
		MAP(
		clk    => clk,
		rst    => rst,
		zero   => zeroAddr,
		load   => ldAddr,
		inReg  => addrIn,
		outReg => addrOutReg);
	reg0 : ENTITY WORK.aftab_register
		GENERIC
		MAP(len => 8)
		PORT
		MAP(
		clk    => clk,
		rst    => rst,
		zero   => zeroData,
		load   => ldData,
		inReg  => dataIn (7 DOWNTO 0),
		outReg => outReg0);
	reg1 : ENTITY WORK.aftab_register
		GENERIC
		MAP(len => 8)
		PORT
		MAP(
		clk    => clk,
		rst    => rst,
		zero   => zeroData,
		load   => ldData,
		inReg  => dataIn (15 DOWNTO 8),
		outReg => outReg1);
	reg2 : ENTITY WORK.aftab_register
		GENERIC
		MAP(len => 8)
		PORT
		MAP(
		clk    => clk,
		rst    => rst,
		zero   => zeroData,
		load   => ldData,
		inReg  => dataIn (23 DOWNTO 16),
		outReg => outReg2);
	reg3 : ENTITY WORK.aftab_register
		GENERIC
		MAP(len => 8)
		PORT
		MAP(
		clk    => clk,
		rst    => rst,
		zero   => zeroData,
		load   => ldData,
		inReg  => dataIn(31 DOWNTO 24),
		outReg => outReg3);
	--Counter Part
	Counter : ENTITY WORK.aftab_counter
		GENERIC
		MAP(len => 2)
		PORT
		MAP(
		clk       => clk,
		rst       => rst,
		zeroCnt   => zeroCnt,
		incCnt    => incCnt,
		initCnt   => initCnt,
		initValue => initValueCnt,
		outCnt    => outCnt,
		coCnt     => OPEN);
	muxOut <= outReg0 WHEN outCnt = "00" ELSE
		outReg1 WHEN outCnt = "01" ELSE
		outReg2 WHEN outCnt = "10" ELSE
		outReg3 WHEN outCnt = "11";
	coCnt <= '1' WHEN (outCnt = nBytesOut) ELSE '0';
	Adder : ENTITY WORK.aftab_opt_adder
		GENERIC
		MAP(len => 32)
		PORT
		MAP(
		A   => addrOutReg,
		B   => outCnt,
		Sum => writeAddr);
	errorDecoder : ENTITY work.aftab_errorDecoderDAWU
		GENERIC
		MAP (len => len)
		PORT
		MAP (
		nBytes              => nBytesIn,
		addrIn              => addrIn (1 DOWNTO 0),
		checkMisalignedDAWU => checkMisalignedDAWU,
		storeMisalignedFlag => storeMisalignedFlag
		);
	addrOut <= writeAddr WHEN (enableAddr = '1') ELSE (OTHERS => 'Z');
	dataOut <= muxOut WHEN (enableData = '1') ELSE(OTHERS     => 'Z');
END ARCHITECTURE Behavioral;
