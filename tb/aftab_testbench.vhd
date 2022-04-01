-- **************************************************************************************
--	Filename:	aftab_testbench.vhd
--	Project:	CNL_RISC-V
--  Version:	1.0
--	History:
--	Date:		1 June 2021
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
--	Testbench for the AFTAB core
--
-- **************************************************************************************

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY aftab_testbench IS
END aftab_testbench;

ARCHITECTURE behavior OF aftab_testbench IS
	-- Core inputs
	SIGNAL clk                      : STD_LOGIC := '0';
	SIGNAL rst                      : STD_LOGIC := '0';
	SIGNAL memReady                 : STD_LOGIC := '0';
	SIGNAL dataBusIn                : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => 'Z');
	SIGNAL platformInterruptSignals : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
	SIGNAL machineExternalInterrupt : STD_LOGIC := '0';
	SIGNAL machineTimerInterrupt    : STD_LOGIC := '0';
	SIGNAL machineSoftwareInterrupt : STD_LOGIC := '0';
	SIGNAL userExternalInterrupt    : STD_LOGIC := '0';
	SIGNAL userTimerInterrupt       : STD_LOGIC := '0';
	SIGNAL userSoftwareInterrupt    : STD_LOGIC := '0';

	-- Core outputs
	SIGNAL memRead             : STD_LOGIC;
	SIGNAL memWrite            : STD_LOGIC;
	SIGNAL interruptProcessing : STD_LOGIC;
	SIGNAL memAddr             : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => 'Z');
	SIGNAL dataBusOut          : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => 'Z');
 

	SIGNAL log_en : STD_LOGIC := '0'; -- this signal is set up by run.tcl at the end of the simulation to dump memory

	CONSTANT clk_period : TIME := 30 ns;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
	core : ENTITY WORK.aftab_core
		PORT MAP(
			clk        => clk, 
			rst        => rst, 
			memRead    => memRead, 
			memWrite   => memWrite, 
			memDataIn  => dataBusIn, 
			memDataOut => dataBusOut, 
			memAddr    => memAddr, 
			memReady   => memReady, 
			----
			machineExternalInterrupt => machineExternalInterrupt, 
			machineTimerInterrupt    => machineTimerInterrupt,   
			machineSoftwareInterrupt => machineSoftwareInterrupt, 
			userExternalInterrupt    => userExternalInterrupt,   
			userTimerInterrupt       => userTimerInterrupt,      
			userSoftwareInterrupt    => userSoftwareInterrupt,   
			platformInterruptSignals => platformInterruptSignals, 
			interruptProcessing      => interruptProcessing
		);
			--
	memory : ENTITY WORK.aftab_memory
		PORT MAP(
			clk          => clk,
			rst          => rst, 
			readMem      => memRead, 
			writeMem     => memWrite, 
			addressBus   => memAddr, 
			dataIn       => dataBusOut, 
			dataOut      => dataBusIn, 
			log_en       => log_en, 
			ready 	     => memReady
		);

	clk_process : PROCESS
	BEGIN
		clk <= '0';
		WAIT FOR clk_period/2;
		clk <= '1';
		WAIT FOR clk_period/2;
	END PROCESS;
			
	-- Stimulus process
	stim_proc : PROCESS
	BEGIN
		-- hold reset state for 100 ns.
		WAIT FOR 120 ns;
		rst <= '1';
		WAIT FOR 40 ns;
		rst <= '0';
		-- uncomment this and set at proper time if you want to set interrupts signals on at some point
		--WAIT FOR 1700 ns;
		--platformInterruptSignals <= X"0001";
		WAIT;

	END PROCESS;

END behavior;