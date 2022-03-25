-- **************************************************************************************
--	Filename:	aftab_booth_multiplier_controller.vhd
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
--	Controller of the generic Booth multiplier for the AFTAB core
--
-- **************************************************************************************
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;
ENTITY aftab_booth_multiplier_controller IS
	GENERIC
	(
		len    : INTEGER := 33;
		lenCnt : INTEGER := 6);
	PORT
	(
		clk        : IN  STD_LOGIC;
		rst        : IN  STD_LOGIC;
		startBooth : IN  STD_LOGIC;
		shrQ       : OUT STD_LOGIC;
		ldQ        : OUT STD_LOGIC;
		ldM        : OUT STD_LOGIC;
		ldP        : OUT STD_LOGIC;
		zeroP      : OUT STD_LOGIC;
		sel        : OUT STD_LOGIC;
		subSel     : OUT STD_LOGIC;
		op         : IN  STD_LOGIC_VECTOR (1 DOWNTO 0);
		done       : OUT STD_LOGIC
	);
END ENTITY aftab_booth_multiplier_controller;
--
ARCHITECTURE behavioral OF aftab_booth_multiplier_controller IS
	TYPE state IS (Idle, Init, Count_Shift);
	SIGNAL pstate, nstate : state;
	SIGNAL temp           : STD_LOGIC_VECTOR (lenCnt - 1 DOWNTO 0);
	SIGNAL co             : STD_LOGIC;
	SIGNAL cnt_en         : STD_LOGIC;
	SIGNAL cnt_rst        : STD_LOGIC;
	SIGNAL initCnt        : STD_LOGIC;
	CONSTANT initValue    : STD_LOGIC_VECTOR (lenCnt - 1 DOWNTO 0) := STD_LOGIC_VECTOR (to_unsigned (((2 ** (lenCnt - 1)) - 1), lenCnt));
BEGIN
	PROCESS (pstate, startBooth, co, op) BEGIN
		nstate <= Init;
		CASE pstate IS
			WHEN Idle=>
				IF (startBooth = '1') THEN
					nstate <= Init;
				ELSE
					nstate <= Idle;
				END IF;
			WHEN Init=>
				nstate <= Count_Shift;
			WHEN Count_Shift =>
				IF (co = '0') THEN
					nstate <= Count_Shift;
				ELSE
					nstate <= Idle;
				END IF;
			WHEN OTHERS =>
				nstate <= Init;
		END CASE;
	END PROCESS;
	PROCESS (pstate, startBooth, co, op) BEGIN
		ldM     <= '0';
		ldQ     <= '0';
		ldP     <= '0';
		zeroP   <= '0';
		shrQ    <= '0';
		sel     <= '0';
		subsel  <= '0';
		done    <= '0';
		cnt_rst <= '0';
		initCnt <= '0';
		cnt_en  <= '0';
		CASE pstate IS
			WHEN Idle =>
				done   <= '1';
			WHEN Init =>
				ldQ     <= startBooth;
				zeroP   <= startBooth;
				ldM     <= '1';
				initCnt <= '1';
			WHEN Count_Shift =>
				cnt_en <= '1';
				--done   <= co;
				shrQ <= '1';
				ldP  <= '1';
				IF (op = "10") THEN
					subsel <= '1';
					sel    <= '1';
				ELSIF (op = "01") THEN
					sel <= '1';
				END IF;
			WHEN OTHERS =>
				ldM     <= '0';
				ldQ     <= '0';
				ldP     <= '0';
				zeroP   <= '0';
				shrQ    <= '0';
				sel     <= '0';
				subsel  <= '0';
				done    <= '0';
				cnt_rst <= '0';
				initCnt <= '0';
				cnt_en  <= '0';
		END CASE;
	END PROCESS;
	
	sequential : PROCESS (clk, rst) BEGIN
		IF rst = '1' THEN
			pstate <= Idle;
		ELSIF (clk = '1' AND clk'event) THEN
			pstate <= nstate;
		END IF;
	END PROCESS sequential;
	
	counter : ENTITY work.aftab_counter
		GENERIC
		MAP(len => lenCnt)
		PORT MAP
		(
			clk       => clk,
			rst       => rst,
			zeroCnt   => cnt_rst,
			incCnt    => cnt_en,
			initCnt   => initCnt,
			initValue => initValue,
			outCnt    => OPEN,
			coCnt     => co
		);
END ARCHITECTURE behavioral;
