-- **************************************************************************************
--	Filename:	aftab_daru.vhd
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
--	Data Adjustment Read Unit (DARU) of the AFTAB core
--
-- **************************************************************************************
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY aftab_daru IS
	PORT
	(
		clk                 : IN  STD_LOGIC;
		rst                 : IN  STD_LOGIC;
		startDARU           : IN  STD_LOGIC;
		nBytes              : IN  STD_LOGIC_VECTOR(1 DOWNTO 0);
		addrIn              : IN  STD_LOGIC_VECTOR (31 DOWNTO 0);
		memData             : IN  STD_LOGIC_VECTOR (7 DOWNTO 0);
		memReady            : IN  STD_LOGIC;
		dataInstrBar        : IN  STD_LOGIC;
		checkMisalignedDARU : IN  STD_LOGIC;
		instrMisalignedFlag : OUT STD_LOGIC;
		loadMisalignedFlag  : OUT STD_LOGIC;
		completeDARU        : OUT STD_LOGIC;
		dataOut             : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
		addrOut             : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
		readMem             : OUT STD_LOGIC
	);
END ENTITY aftab_daru;
ARCHITECTURE behavioral OF aftab_daru IS
	SIGNAL zeroAddr     : STD_LOGIC;
	SIGNAL ldAddr       : STD_LOGIC;
	SIGNAL selldEn      : STD_LOGIC;
	SIGNAL zeroNumBytes : STD_LOGIC;
	SIGNAL ldNumBytes   : STD_LOGIC;
	SIGNAL zeroCnt      : STD_LOGIC;
	SIGNAL incCnt       : STD_LOGIC;
	SIGNAL initCnt      : STD_LOGIC;
	SIGNAL initReading  : STD_LOGIC;
	SIGNAL enableAddr   : STD_LOGIC;
	SIGNAL enableData   : STD_LOGIC;
	SIGNAL LdErrorFlag  : STD_LOGIC;
	SIGNAL coCnt        : STD_LOGIC;
	SIGNAL sel          : STD_LOGIC_VECTOR (1 DOWNTO 0);
	SIGNAL initValueCnt : STD_LOGIC_VECTOR (1 DOWNTO 0);
BEGIN
	DataPath : ENTITY work.aftab_daru_datapath
		GENERIC
		MAP(len => 32)
		PORT MAP
		(
		  clk                 => clk,
		  rst                 => rst,
		  nBytes              => nBytes,
		  initValueCnt        => "00",
		  addrIn              => addrIn,
		  memData             => memData,
		  zeroAddr            => zeroAddr,
		  ldAddr              => ldAddr,
		  selldEn             => selldEn,
		  zeroNumBytes        => zeroNumBytes,
		  ldNumBytes          => ldNumBytes,
		  zeroCnt             => zeroCnt,
		  incCnt              => incCnt,
		  initCnt             => initCnt,
		  initReading         => initReading,
		  enableAddr          => enableAddr,
		  enableData          => enableData,
		  dataInstrBar        => dataInstrBar,
		  checkMisalignedDARU => checkMisalignedDARU,
		  instrMisalignedFlag => instrMisalignedFlag,
		  loadMisalignedFlag  => loadMisalignedFlag,
		  coCnt               => coCnt,
		  dataOut             => dataOut,
		  addrOut             => addrOut);
	Controller : ENTITY work.aftab_daru_controller
		PORT
		MAP(
		clk          => clk,
		rst          => rst,
		startDARU    => startDARU,
		coCnt        => coCnt,
		memReady     => memReady,
		initCnt      => initCnt,
		ldAddr       => ldAddr,
		zeroAddr     => zeroAddr,
		zeroNumBytes => zeroNumBytes,
		initReading  => initReading,
		ldErrorFlag  => ldErrorFlag,
		ldNumBytes   => ldNumBytes,
		selldEn      => selldEn,
		readMem      => readMem,
		enableAddr   => enableAddr,
		enableData   => enableData,
		incCnt       => incCnt,
		zeroCnt      => zeroCnt,
		completeDARU => completeDARU);
END ARCHITECTURE behavioral;
