-- **************************************************************************************
--	Filename:	aftab_testbench.vhd
--	Project:	CNL_RISC-V
--  Version:	1.0
--	History:
--	Date:		16 February 2021
--
-- Copyright (C) 2021 CINI Cybersecurity National Laboratory and University of Tehran
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
	--Inputs
	SIGNAL clk          : STD_LOGIC                    := '0';
	SIGNAL rst          : STD_LOGIC                    := '0';
--	SIGNAL memReady     : STD_LOGIC                    := '0';
	SIGNAL dataMemReady      : STD_LOGIC := '0';
	SIGNAL instrMemReady      : STD_LOGIC := '0';
	--SIGNAL memDataIN    : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
	SIGNAL instrMem, dataMem    : STD_LOGIC_VECTOR(7 DOWNTO 0):= (OTHERS => 'Z');
	--Outputs

	SIGNAL readDataMem      : STD_LOGIC;
	SIGNAL readInstrMem      : STD_LOGIC;
	SIGNAL writeDataMem     : STD_LOGIC;
	SIGNAL interruptProcessing : STD_LOGIC;
	--SIGNAL memDataOUT   : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL instrMemAddr, dataMemAddr      : STD_LOGIC_VECTOR(31 DOWNTO 0):= (OTHERS => 'Z');
	SIGNAL cs           : STD_LOGIC := '0';
	SIGNAL opr          : BOOLEAN   := FALSE;
	
	-- Interrupts 
	
	SIGNAL machineExternalInterrupt  : STD_LOGIC    := '0';
	SIGNAL machineTimerInterrupt    : STD_LOGIC    := '0';
	SIGNAL machineSoftwareInterrupt : STD_LOGIC    := '0';
	SIGNAL userExternalInterrupt	 : STD_LOGIC    := '0';
	SIGNAL userTimerInterrupt 		 : STD_LOGIC    := '0';
	SIGNAL userSoftwareInterrupt	 : STD_LOGIC    := '0';
	CONSTANT clk_period : TIME      := 30 ns;
BEGIN
	-- Instantiate the Unit Under Test (UUT)
	uut : ENTITY WORK.aftab_core PORT MAP(
		clk                => clk             ,
		rst                => rst             ,
		dataMemReady       => dataMemReady    ,
		instrMemReady      => instrMemReady   ,
		instrMemIn         => instrMem      ,
		dataMemIn          => dataMem      ,
		dataMemOut         => dataMem      ,
		readDataMem        => readDataMem     ,
		readInstrMem       => readInstrMem    ,
		writeDataMem       => writeDataMem    ,
		dataMemAddr        => dataMemAddr     ,
		instrMemAddr       => instrMemAddr    ,
		
		
		machineExternalInterrupt    =>  machineExternalInterrupt  ,
		machineTimerInterrupt      =>  machineTimerInterrupt    ,
		machineSoftwareInterrupt   =>  machineSoftwareInterrupt ,
		userExternalInterrupt	   =>  userExternalInterrupt	,
		userTimerInterrupt 		   =>  userTimerInterrupt 		,
		userSoftwareInterrupt	   =>  userSoftwareInterrupt	,
		interruptProcessing  =>   interruptProcessing
		
		
	);
	

--		
		 Inst_aftab_InstrMemory: ENTITY WORK.MemoryModel PORT MAP(
		 clk => clk ,
		 readmem => readInstrMem ,
		 writemem => '0' ,
		 addressBus => instrMemAddr ,
		 dataBus => instrMem ,
		 memDataReady => instrMemReady
	 );	
		Inst_aftab_DataMemory: ENTITY WORK.MemoryModel PORT MAP(
		 clk => clk ,
		 readmem => readDataMem ,
		 writemem => writeDataMem ,
		 addressBus => dataMemAddr ,
		 dataBus => dataMem ,
		 memDataReady => dataMemReady
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
		WAIT FOR 100 ns;
		opr <= TRUE;
		WAIT FOR 2 ns;
		--cs  <= '1';
		rst <= '1';
		WAIT FOR 40 ns;
		rst <= '0';		
		WAIT FOR 4000 ns;
		userTimerInterrupt <= '1';
		WAIT FOR 300 ns;
		userTimerInterrupt <= '0';

		WAIT;
	END PROCESS;
END;