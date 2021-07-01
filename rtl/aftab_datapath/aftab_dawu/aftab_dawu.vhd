-- **************************************************************************************
--	Filename:	aftab_dawu.vhd
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
--	Data Adjustment Write Unit (DAWU) of the AFTAB core
--
-- **************************************************************************************
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY aftab_dawu IS
	GENERIC (len : INTEGER := 32);
	PORT (
		clk, rst     : IN  STD_LOGIC;
		startDAWU    : IN  STD_LOGIC;
		memReady 	 : IN  STD_LOGIC;
		nBytes       : IN  STD_LOGIC_VECTOR (1 DOWNTO 0);
		addrIn       : IN  STD_LOGIC_VECTOR (len - 1 DOWNTO 0);
		dataIn       : IN  STD_LOGIC_VECTOR (len - 1 DOWNTO 0);
		addrOut      : OUT STD_LOGIC_VECTOR (len - 1 DOWNTO 0);
		dataOut      : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
		writeMem     : OUT STD_LOGIC;
		dataError    : OUT STD_LOGIC;
		completeDAWU : OUT STD_LOGIC
	);
END ENTITY aftab_dawu;

ARCHITECTURE Behavioral OF aftab_dawu IS
	SIGNAL enableData 	: STD_LOGIC;
	SIGNAL enableAddr 	: STD_LOGIC;
	SIGNAL incCnt 	  	: STD_LOGIC;
	SIGNAL zeroCnt    	: STD_LOGIC;
	SIGNAL initCnt      : STD_LOGIC;
	SIGNAL ldNumBytes 	: STD_LOGIC;
	SIGNAL zeroNumBytes : STD_LOGIC;
	SIGNAL ldAddr       : STD_LOGIC;
	SIGNAL zeroAddr     : STD_LOGIC;
	SIGNAL ldData       : STD_LOGIC;
	SIGNAL zeroData     : STD_LOGIC;
	SIGNAL coCnt        : STD_LOGIC;
	SIGNAL ldErrorFlag  : STD_LOGIC;
BEGIN
	Datapath : ENTITY WORK.aftab_dawu_datapath GENERIC MAP (len => len)
				PORT MAP(
					clk => clk,
					rst => rst, 
					ldData => ldData,
					enableData => enableData, 
					enableAddr => enableAddr,
					incCnt => incCnt, 
					zeroCnt => zeroCnt,
					initCnt => initCnt,
					ldNumBytes => ldNumBytes,
					zeroNumBytes => zeroNumBytes, 
					ldAddr => ldAddr,
					zeroAddr => zeroAddr, 
					zeroData => zeroData,
					nBytesIn => nBytes,
					initValueCnt => "00",
					dataIn => dataIn, 
					addrIn => addrIn, 
					coCnt => coCnt,
					dataOut => dataOut, 
					addrOut => addrOut);
	Controller : ENTITY WORK.aftab_dawu_controller
					PORT MAP(
						clk => clk, 
						rst => rst, 
						coCnt => coCnt,
						startDAWU => startDAWU, 
						memReady => memReady,
						ldData => ldData, 
						enableData => enableData,
						enableAddr => enableAddr, 
						incCnt => incCnt,
						zeroCnt => zeroCnt,
						initCnt => initCnt,
						ldNumBytes => ldNumBytes, 
						zeroNumBytes => zeroNumBytes,
						ldAddr => ldAddr,
						zeroAddr => zeroAddr,
						zeroData => zeroData, 
						writeMem => writeMem,
						ldErrorFlag => ldErrorFlag, 
						completeDAWU => completeDAWU);
END ARCHITECTURE Behavioral;
