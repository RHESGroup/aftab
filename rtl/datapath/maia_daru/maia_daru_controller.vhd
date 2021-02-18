-- **************************************************************************************
--	Filename:	maia_daru_controller.vhd
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
--	Controller of the Data Adjustment Read Unit (DARU) of the TETRISC Maia core
--
-- **************************************************************************************

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL; 

ENTITY maia_daru_controller IS
	PORT (
		clk, rst : IN STD_LOGIC;
		
        startDARU, loadSignedUnsignedBar, coCnt, memReady : IN STD_LOGIC;
		nBO : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		initCnt, ldAddr, zeroAddr, initReading, ldErrorFlag, ldNumBytes, selldEn,
		readMem, enableAddr, incCnt, zeroCnt, completeDARU : OUT STD_LOGIC;
		loadSigned : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END ENTITY maia_daru_controller;

ARCHITECTURE behavioral OF maia_daru_controller IS 
   TYPE state IS (waitforStart, waitforMemready, complete);
   SIGNAL pstate, nstate : state;
   SIGNAL loadSUB : STD_LOGIC;
   SIGNAL zeroS, ldS : STD_LOGIC;
BEGIN

	--signRegister
    SignReg : ENTITY WORK.maia_sign_register 
				PORT MAP (clk => clk, rst => rst, zero => zeroS, 
					load => ldS, inReg => loadSignedUnsignedBar, outReg => loadSUB);


	PROCESS (pstate, startDARU, coCnt, memReady) BEGIN
		initCnt <= '0'; ldAddr <= '0'; zeroCnt <= '0'; zeroAddr <= '0'; ldErrorFlag <= '0';
		ldNumBytes <= '0'; selldEn <= '0'; readMem <= '0';
		enableAddr <= '0'; incCnt <= '0'; completeDARU <= '0'; initReading <= '0'; loadSigned <= "0000"; ldS <= '0'; zeroS <= '0';
		CASE pstate IS
			WHEN  waitforStart =>
				initCnt <= startDARU;
				ldAddr <= startDARU;
				ldErrorFlag <= startDARU;
				ldNumBytes <= startDARU; 
				ldS <= startDARU;
				initReading <= startDARU;	
				IF (startDARU = '1') THEN
					nstate <= waitforMemready;
				ELSIF (startDARU = '0') THEN 
					nstate <= waitforStart;
				END IF;
			WHEN waitforMemready =>
				selldEn <= memReady;
				readMem <= '1';
				enableAddr <= '1';
				incCnt <= memReady;
				--completeDARU <= (coCnt AND memReady);
				
				IF ((coCnt AND memReady) = '1' and loadSUB = '1') THEN
				
					
						IF (nBO = "00")THEN	
							loadSigned <= "1110";
						ELSIF (nBO = "01")THEN	
							loadSigned <= "1100";							
						ELSE
							loadSigned <= "0000";	
						END IF;
				ELSE
						loadSigned <= "0000";	
				END IF;				
				
				
				
				
				
				IF (coCnt = '0' OR memReady = '0') THEN
					nstate <= waitforMemready;
				ELSIF ((coCnt AND memReady) = '1') THEN
					nstate <= complete;
				END IF;
				
			WHEN complete =>	
					nstate <= waitforStart;
					completeDARU <= '1';
			WHEN OTHERS => 	
				nstate <= waitforStart;			
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
