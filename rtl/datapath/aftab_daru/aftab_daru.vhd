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
	PORT (
		clk,rst   : IN STD_LOGIC;
		startDARU : IN STD_LOGIC;
		loadSignedUnsignedBar : IN STD_LOGIC;
		nBytes    : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        addrIn    : In STD_LOGIC_VECTOR (31 downto 0);
		memData   : In STD_LOGIC_VECTOR (7 downto 0);
		memReady  : IN STD_LOGIC;
        completeDARU    : OUT STD_LOGIC;
        dataOut, addrOut : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
		dataError, instrError : OUT STD_LOGIC;
		readMem : OUT STD_LOGIC
	);
END ENTITY aftab_daru;

ARCHITECTURE behavioral OF aftab_daru IS
  SIGNAL zeroAddr, ldAddr, selldEn, zeroNumBytes, ldNumBytes,
		 zeroCnt, incCnt, initCnt, initReading, enableAddr, LdErrorFlag, zeroS, ldS : STD_LOGIC;
  SIGNAL coCnt : STD_LOGIC;
  SIGNAL sel, nBO   : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL loadSigned   : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL initValueCnt : STD_LOGIC_VECTOR (1 DOWNTO 0) := (OTHERS => '0');
BEGIN


    DataPath    : ENTITY work.aftab_daru_datapath 
					GENERIC MAP(len => 32) 
					PORT MAP (clk, rst, memReady,nBytes, initValueCnt, addrIn,
						memData, loadSigned, zeroAddr, ldAddr, selldEn, zeroNumBytes, ldNumBytes,
						zeroCnt, incCnt, initCnt, initReading, enableAddr,
						--LdErrorFlag,
						coCnt, nBO, dataOut, addrOut);
   
    Controller  : ENTITY work.aftab_daru_controller 
					PORT MAP (clk, rst, startDARU, loadSignedUnsignedBar,  coCnt, memReady, nBO,
						initCnt, ldAddr, zeroAddr, initReading, ldErrorFlag, ldNumBytes, selldEn,
						readMem, enableAddr, incCnt, zeroCnt, completeDARU, loadSigned);												                                                    
END ARCHITECTURE behavioral;