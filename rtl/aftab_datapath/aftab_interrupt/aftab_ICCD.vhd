-- **************************************************************************************
-- Filename: aftab_ICCD.vhd
-- Project: CNL_RISC-V
-- Version: 1.0
-- History:
-- Date: 14 December 2021
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
-- File content description:
-- Interrupt check cause detection in the AFTAB core
-- This unit rises interrupt and exception and generates cause code.
-- It also determine the delegation mode.
-- 
-- **************************************************************************************
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.numeric_std.ALL;
ENTITY aftab_ICCD IS
	GENERIC
		(len : INTEGER := 32);
	PORT
	(
		clk            : IN  STD_LOGIC;
		rst            : IN  STD_LOGIC;
		inst           : IN  STD_LOGIC_VECTOR(len - 1 DOWNTO 0);
		outPC          : IN  STD_LOGIC_VECTOR(len - 1 DOWNTO 0);
		outADR         : IN  STD_LOGIC_VECTOR(len - 1 DOWNTO 0);
		mipCC          : IN  STD_LOGIC_VECTOR(len - 1 DOWNTO 0);
		mieCC          : IN  STD_LOGIC_VECTOR(len - 1 DOWNTO 0);
		midelegCSR     : IN  STD_LOGIC_VECTOR(len - 1 DOWNTO 0);
		medelegCSR     : IN  STD_LOGIC_VECTOR(len - 1 DOWNTO 0);
		mieFieldCC     : IN  STD_LOGIC;
		uieFieldCC     : IN  STD_LOGIC;
		ldDelegation   : IN  STD_LOGIC;
		ldMachine      : IN  STD_LOGIC;
		ldUser         : IN  STD_LOGIC;
		tempFlags      : IN  STD_LOGIC_VECTOR(5 DOWNTO 0);
		interruptRaise : OUT STD_LOGIC;
		exceptionRaise : OUT STD_LOGIC;
		delegationMode : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		curPRV         : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		causeCode      : OUT STD_LOGIC_VECTOR(len - 1 DOWNTO 0);
		trapValue      : OUT STD_LOGIC_VECTOR(len - 1 DOWNTO 0)
	);
END ENTITY aftab_ICCD;
--
ARCHITECTURE behavioral OF aftab_ICCD IS
	SIGNAL interRaiseTemp, exceptionRaiseTemp : STD_LOGIC;
	SIGNAL tempIllegalInstr, tempInstrAddrMisaligned, 
		   tempStoreAddrMisaligned,	tempLoadAddrMisaligned, 
		   tempDividedByZero, tempEcallFlag, interRaiseReserved : STD_LOGIC;
	SIGNAL currentPRV, delegationReg : STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL interReserved : STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL interRaiseMachineExternal, interRaiseMachineSoftware, 
		   interRaiseMachineTimer, interRaiseUserExternal, 
		   interRaiseUserSoftware, interRaiseUserTimer, 
		   user, machine : STD_LOGIC;
BEGIN
	PROCESS (clk, rst)
	BEGIN
		IF (rst = '1') THEN
			currentPRV <= "11";
		ELSIF (clk = '1' AND clk 'EVENT) THEN
			IF (ldMachine = '1') THEN
				currentPRV <= "11";
			ELSIF (ldUser = '1') THEN
				currentPRV <= "00";
			END IF;
		END IF;
	END PROCESS;
	curPRV <= currentPRV;
	PROCESS (clk, rst)
	BEGIN
		IF (rst = '1') THEN
			delegationMode <= (OTHERS => '0');
		ELSIF (clk = '1' AND clk 'EVENT) THEN
			IF (ldDelegation = '1') THEN
				delegationMode <= delegationReg;
			END IF;
		END IF;
	END PROCESS;
	--Current Mode
	user                      <= NOT(currentPRV(1)) AND NOT(currentPRV(0));
	machine                   <= currentPRV(1) AND currentPRV(0);
	--Exception Flags
	tempEcallFlag             <= tempFlags(5);
	tempDividedByZero         <= tempFlags(4);
	tempIllegalInstr          <= tempFlags(3);
	tempInstrAddrMisaligned   <= tempFlags(2);
	tempLoadAddrMisaligned    <= tempFlags(1);
	tempStoreAddrMisaligned   <= tempFlags(0);
	exceptionRaiseTemp        <= ((tempIllegalInstr OR tempInstrAddrMisaligned) OR 
								  (tempStoreAddrMisaligned OR tempLoadAddrMisaligned)) OR 
								  (tempDividedByZero OR tempEcallFlag);
	exceptionRaise            <= exceptionRaiseTemp;
	--Interrupt Source
	interRaiseMachineExternal <= (user OR (machine AND mieFieldCC)) AND 
								 (mipCC(11) AND mieCC(11));
	interRaiseMachineSoftware <= (user OR (machine AND mieFieldCC)) AND 
								 (mipCC(3) AND mieCC(3));
	interRaiseMachineTimer    <= (user OR (machine AND mieFieldCC)) AND 
					             (mipCC(7) AND mieCC(7));
	interRaiseUserExternal    <= (user AND uieFieldCC) AND (mipCC(8) AND mieCC(8));
	interRaiseUserSoftware    <= (user AND uieFieldCC) AND (mipCC(0) AND mieCC(0));
	interRaiseUserTimer       <= (user AND uieFieldCC) AND (mipCC(4) AND mieCC(4));
	
	interReserved             <= (mipCC(31 DOWNTO 16) AND mieCC(31 DOWNTO 16));
	interRaiseReserved        <= mieFieldCC AND (interReserved(15) OR interReserved(14) OR 
												 interReserved(13) OR interReserved(12) OR 
												 interReserved(11) OR interReserved(10) OR 
												 interReserved(9)  OR interReserved(8)  OR 
												 interReserved(7)  OR interReserved(6)  OR 
												 interReserved(5)  OR interReserved(4)  OR 
												 interReserved(3)  OR interReserved(2)  OR 
												 interReserved(1)  OR interReserved(0));
	
	
	
	interRaiseTemp            <= interRaiseMachineExternal OR interRaiseMachineSoftware OR 
								 interRaiseMachineTimer    OR interRaiseUserExternal    OR 
								 interRaiseUserSoftware    OR interRaiseUserTimer       OR 
								 interRaiseReserved;
	interruptRaise <= interRaiseTemp;
	causeCodeGeneration : PROCESS (exceptionRaiseTemp, tempIllegalInstr, tempInstrAddrMisaligned, 
									tempStoreAddrMisaligned, tempLoadAddrMisaligned, tempDividedByZero, 
									tempEcallFlag, interRaiseTemp, mipCC
								   )
	BEGIN
		IF (exceptionRaiseTemp = '1') THEN
			IF    (tempIllegalInstr = '1') THEN
				causeCode <= '0' & STD_LOGIC_VECTOR(to_unsigned(2, len - 1));
			ELSIF (tempInstrAddrMisaligned = '1') THEN
				causeCode <= '0' & STD_LOGIC_VECTOR(to_unsigned(0, len - 1));
			ELSIF (tempStoreAddrMisaligned = '1') THEN
				causeCode <= '0' & STD_LOGIC_VECTOR(to_unsigned(6, len - 1));
			ELSIF (tempLoadAddrMisaligned = '1') THEN
				causeCode <= '0' & STD_LOGIC_VECTOR(to_unsigned(4, len - 1));
			ELSIF (tempEcallFlag = '1') THEN
				causeCode <= '0' & STD_LOGIC_VECTOR(to_unsigned(8, len - 1)); --ecall from user
			ELSE
				causeCode <= (OTHERS => '0');
			END IF;
		ELSIF (interRaiseTemp = '1') THEN
			IF    (mipCC(11) = '1') THEN
				causeCode <= '1' & STD_LOGIC_VECTOR(to_unsigned(11, len - 1));
			ELSIF (mipCC(3) = '1') THEN
				causeCode <= '1' & STD_LOGIC_VECTOR(to_unsigned(3, len - 1));
			ELSIF (mipCC(7) = '1') THEN
				causeCode <= '1' & STD_LOGIC_VECTOR(to_unsigned(7, len - 1));
			ELSIF (mipCC(8) = '1') THEN
				causeCode <= '1' & STD_LOGIC_VECTOR(to_unsigned(8, len - 1));
			ELSIF (mipCC(0) = '1') THEN
				causeCode <= '1' & STD_LOGIC_VECTOR(to_unsigned(0, len - 1));
			ELSIF (mipCC(4) = '1') THEN
				causeCode <= '1' & STD_LOGIC_VECTOR(to_unsigned(4, len - 1));		
			--for reserved		
			ELSIF (mipCC(16) = '1') THEN
				causeCode <= '1' & STD_LOGIC_VECTOR(to_unsigned(16, len - 1));	
			ELSIF (mipCC(17) = '1') THEN
				causeCode <= '1' & STD_LOGIC_VECTOR(to_unsigned(17, len - 1));
			ELSIF (mipCC(18) = '1') THEN
				causeCode <= '1' & STD_LOGIC_VECTOR(to_unsigned(18, len - 1));
			ELSIF (mipCC(19) = '1') THEN
				causeCode <= '1' & STD_LOGIC_VECTOR(to_unsigned(19, len - 1));
			ELSIF (mipCC(20) = '1') THEN
				causeCode <= '1' & STD_LOGIC_VECTOR(to_unsigned(20, len - 1));
			ELSIF (mipCC(21) = '1') THEN
				causeCode <= '1' & STD_LOGIC_VECTOR(to_unsigned(21, len - 1));
			ELSIF (mipCC(22) = '1') THEN
				causeCode <= '1' & STD_LOGIC_VECTOR(to_unsigned(22, len - 1));
			ELSIF (mipCC(23) = '1') THEN
				causeCode <= '1' & STD_LOGIC_VECTOR(to_unsigned(23, len - 1));
			ELSIF (mipCC(24) = '1') THEN
				causeCode <= '1' & STD_LOGIC_VECTOR(to_unsigned(24, len - 1));
			ELSIF (mipCC(25) = '1') THEN
				causeCode <= '1' & STD_LOGIC_VECTOR(to_unsigned(25, len - 1));
			ELSIF (mipCC(26) = '1') THEN
				causeCode <= '1' & STD_LOGIC_VECTOR(to_unsigned(26, len - 1));
			ELSIF (mipCC(27) = '1') THEN
				causeCode <= '1' & STD_LOGIC_VECTOR(to_unsigned(27, len - 1));
			ELSIF (mipCC(28) = '1') THEN
				causeCode <= '1' & STD_LOGIC_VECTOR(to_unsigned(28, len - 1));
			ELSIF (mipCC(29) = '1') THEN
				causeCode <= '1' & STD_LOGIC_VECTOR(to_unsigned(29, len - 1));
			ELSIF (mipCC(30) = '1') THEN
				causeCode <= '1' & STD_LOGIC_VECTOR(to_unsigned(30, len - 1));
			ELSIF (mipCC(31) = '1') THEN
				causeCode <= '1' & STD_LOGIC_VECTOR(to_unsigned(31, len - 1));
			ELSE
				causeCode <= (OTHERS => '0');
			END IF;
		ELSE
			causeCode <= (OTHERS => '0');
		END IF;
	END PROCESS;
	delegationCheck : PROCESS (exceptionRaiseTemp, interRaiseTemp, tempIllegalInstr, 
							   tempInstrAddrMisaligned, tempStoreAddrMisaligned, 
							   tempLoadAddrMisaligned, tempDividedByZero, tempEcallFlag, 
							   mipCC, machine, user, medelegCSR, midelegCSR
							   )
	BEGIN
		IF (exceptionRaiseTemp = '1') THEN
			IF    (tempIllegalInstr = '1' AND user = '1' AND medelegCSR(2) = '1') THEN
				delegationReg <= "00";
			ELSIF (tempInstrAddrMisaligned = '1' AND user = '1' AND medelegCSR(0) = '1') THEN
				delegationReg <= "00";
			ELSIF (tempStoreAddrMisaligned = '1' AND user = '1' AND medelegCSR(6) = '1') THEN
				delegationReg <= "00";
			ELSIF (tempLoadAddrMisaligned = '1' AND user = '1' AND medelegCSR(4) = '1') THEN
				delegationReg <= "00";
			ELSIF (tempDividedByZero = '1' AND user = '1' AND medelegCSR(10) = '1') THEN
				delegationReg <= "00";
			ELSIF (tempEcallFlag = '1' AND user = '1' AND medelegCSR(11) = '1') THEN
				delegationReg <= "00";
			ELSE
				delegationReg <= "11";
			END IF;
		ELSIF (interRaiseTemp = '1') THEN
			IF    (mipCC(8) = '1' AND user = '1' AND midelegCSR(8) = '1') THEN
				delegationReg <= "00";
			ELSIF (mipCC(0) = '1' AND user = '1' AND midelegCSR(0) = '1') THEN
				delegationReg <= "00";
			ELSIF (mipCC(4) = '1' AND user = '1' AND midelegCSR(4) = '1') THEN
				delegationReg <= "00";
			ELSE
				delegationReg <= "11"; --Also for the 16 reserved interrupts 
			END IF;
		ELSE
			delegationReg <= "11";
		END IF;
	END PROCESS;
	trapValue <= inst WHEN (tempIllegalInstr = '1')        ELSE
				outPC WHEN (tempInstrAddrMisaligned = '1') ELSE
			   outADR WHEN (tempStoreAddrMisaligned = '1' OR tempLoadAddrMisaligned = '1') 
			   ELSE (OTHERS => '0');
END ARCHITECTURE behavioral;