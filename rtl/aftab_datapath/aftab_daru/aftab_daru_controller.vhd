-- **************************************************************************************
--	Filename:	aftab_daru_controller.vhd
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
--	Controller of the Data Adjustment Read Unit (DARU) of the AFTAB core
--
-- **************************************************************************************
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY aftab_daru_controller IS
	PORT (
		clk          : IN STD_LOGIC;
		rst          : IN STD_LOGIC;
		startDARU    : IN STD_LOGIC;
		coCnt        : IN STD_LOGIC;
		memReady     : IN STD_LOGIC;
		initCnt      : OUT STD_LOGIC;
		ldAddr       : OUT STD_LOGIC;
		zeroAddr     : OUT STD_LOGIC;
		zeroNumBytes : OUT STD_LOGIC;
		initReading  : OUT STD_LOGIC;
		ldErrorFlag  : OUT STD_LOGIC;
		ldNumBytes   : OUT STD_LOGIC;
		selldEn 	 : OUT STD_LOGIC;
		readMem		 : OUT STD_LOGIC;
		enableAddr	 : OUT STD_LOGIC;
		enableData	 : OUT STD_LOGIC;
		incCnt		 : OUT STD_LOGIC;
		zeroCnt		 : OUT STD_LOGIC;
		completeDARU : OUT STD_LOGIC
	);
END ENTITY aftab_daru_controller;

ARCHITECTURE behavioral OF aftab_daru_controller IS
	TYPE state IS (waitforStart, waitforMemready, complete);
	SIGNAL pstate, nstate : state;

BEGIN

	PROCESS (pstate, startDARU, coCnt, memReady) BEGIN
		nstate <= waitforStart;
		CASE pstate IS
			WHEN waitforStart =>
				IF (startDARU = '1') THEN
					nstate <= waitforMemready;
				ELSE
					nstate <= waitforStart;
				END IF;
			WHEN waitforMemready =>
				IF ((coCnt AND memReady) = '1') THEN
					nstate <= complete;
				ELSE
					nstate <= waitforMemready;
				END IF;
			WHEN complete =>
				nstate <= waitforStart;
			WHEN OTHERS =>
				nstate <= waitforStart;
		END CASE;
	END PROCESS;
	PROCESS (pstate, startDARU, coCnt, memReady) BEGIN
		initCnt <= '0'; 
		ldAddr <= '0';
		zeroCnt <= '0'; 
		zeroAddr <= '0'; 
		zeroNumBytes <= '0';
		ldErrorFlag <= '0';
		ldNumBytes <= '0';
		selldEn <= '0'; 
		readMem <= '0';
		enableAddr <= '0'; 
		enableData <= '0'; 
		incCnt <= '0'; 
		completeDARU <= '0'; 
		initReading <= '0';
		CASE pstate IS
			WHEN waitforStart =>
				initCnt <= startDARU;
				ldAddr <= startDARU;
				ldErrorFlag <= startDARU;
				ldNumBytes <= startDARU;
				initReading <= startDARU;
			WHEN waitforMemready =>
				selldEn <= memReady;
				enableData <= memReady;
				readMem <= '1';
				enableAddr <= '1';
				incCnt <= memReady;
			WHEN complete =>
				completeDARU <= '1';
			WHEN OTHERS =>
				initCnt <= '0'; 
				ldAddr <= '0'; 
				zeroCnt <= '0';
				zeroAddr <= '0';
				zeroNumBytes <= '0'; 
				ldErrorFlag <= '0';
				ldNumBytes <= '0'; 
				selldEn <= '0'; 
				readMem <= '0';
				enableAddr <= '0'; 
				enableData <= '0'; 
				enableData <= '0'; 
				incCnt <= '0'; 
				completeDARU <= '0'; 
				initReading <= '0';
		END CASE;
	END PROCESS;
	PROCESS (clk, rst) BEGIN
		IF (rst = '1') THEN
			pstate <= waitforStart;
		ELSIF (clk = '1' AND clk'event) THEN
			pstate <= nstate;
		END IF;
	END PROCESS;
END ARCHITECTURE behavioral;
