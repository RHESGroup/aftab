-- **************************************************************************************
--	Filename:	maia_booth_multiplier_controller.vhd
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
--	Controller of the generic Booth multiplier for the TETRISC Maia core
--
-- **************************************************************************************

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY maia_booth_multiplier_controller IS
	GENERIC (len : INTEGER := 33);
	PORT (
		clk   : IN STD_LOGIC; 
		rst   : IN STD_LOGIC;
		startBooth : IN STD_LOGIC;	 
		shrQ : OUT STD_LOGIC;
		ldQ : OUT STD_LOGIC;
		ldM : OUT STD_LOGIC;
		ldP : OUT STD_LOGIC;
		zeroP : OUT STD_LOGIC;
		sel : OUT STD_LOGIC;
		subSel : OUT STD_LOGIC;	 
		op    : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
		done  : OUT STD_LOGIC
	);
END ENTITY maia_booth_multiplier_controller ;

ARCHITECTURE behavioral OF maia_booth_multiplier_controller IS 
	
	TYPE state IS (INIT, COUNT, SHIFT);
	SIGNAL pstate, nstate : state;
	SIGNAL cnt  : STD_LOGIC_VECTOR (5 DOWNTO 0);
	SIGNAL temp : STD_LOGIC_VECTOR (6  DOWNTO 0);
	SIGNAL co, cnt_en, cnt_rst  : STD_LOGIC;

BEGIN

	PROCESS (pstate, startBooth, co, op) BEGIN
		nstate <= INIT;
		CASE pstate IS
			WHEN INIT => 
				IF (startBooth = '1') THEN
                nstate <= COUNT;
				ELSE 
                nstate <= INIT;
				END IF; 
			WHEN COUNT => 
				nstate <= SHIFT; 
			WHEN SHIFT => 
				IF (co = '0') THEN             
                nstate <= COUNT; 
				ELSE                    
                nstate <= INIT;
				END IF;
			WHEN OTHERS => 
				nstate <= INIT;
		END CASE;
	END PROCESS;   

    PROCESS (pstate, startBooth, co, op ) 
    BEGIN
		ldM <= '0'; 
		ldQ <= '0'; 
		ldP <= '0'; 
		zeroP <= '0'; 
		shrQ <= '0'; 
		sel <= '0'; 
		subsel <= '0'; 
		done <= '0'; 
		cnt_rst <= '0'; 
		cnt_en <= '0';
		CASE pstate IS
			WHEN INIT => 
				--done    <= '1';
				ldQ     <= '1'; 
				zeroP   <= '1';
				ldM     <= '1'; 
				cnt_rst <= '1';
			WHEN COUNT => cnt_en <= '1';
			WHEN SHIFT => 
				shrQ <= '1'; 
				ldP  <= '1'; 
				done <= co;
				IF (op = "10") THEN
                subsel <= '1'; 
                sel <= '1'; 
				ELSIF (op = "01" ) THEN
                sel <= '1'; 
				END IF;
			WHEN OTHERS =>
				ldM <= '0'; 
				ldQ <= '0'; 
				ldP <= '0'; 
				zeroP <= '0'; 
				shrQ <= '0'; 
				sel <= '0'; 
				subsel <= '0'; 
				done <= '0'; 
				cnt_rst <= '0';
				cnt_en <= '0';
		END CASE;
	END PROCESS;
	  
	sequential : PROCESS (clk) BEGIN
		IF (clk = '1' AND clk'EVENT) THEN
			IF rst = '1' THEN 
				pstate <= INIT;
			ELSE 
				pstate <= nstate;
			END IF;
		END IF;   
    END PROCESS sequential; 

	counter: PROCESS (clk, rst) BEGIN
		IF cnt_rst = '1' THEN 
			temp <= (OTHERS => '0');
		ELSIF (clk = '1' AND clk'EVENT) THEN 
			IF (cnt_en = '1') THEN
				temp <= ('0' & cnt) + '1';
				IF (temp (5 DOWNTO 0) = "100001") THEN
					co <= '1';
				ELSE 
					co <= '0';
				END IF;
			END IF;
		END IF;
    END PROCESS counter; 
	cnt <= temp (5 DOWNTO 0);
	
END ARCHITECTURE behavioral;
		
