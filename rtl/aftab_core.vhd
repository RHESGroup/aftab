-- **************************************************************************************
-- Filename: aftab_core.vhd
-- Project: CNL_RISC-V
-- Version: 1.0
-- History:
-- Date: 16 February 2021
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
-- File content description:
-- Top entity of the AFTAB core
--
-- **************************************************************************************
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
ENTITY aftab_core IS
	GENERIC
		(len : INTEGER := 32);
	PORT
	(
		clk                      : IN  STD_LOGIC;
		rst                      : IN  STD_LOGIC;
		dataMemReady             : IN  STD_LOGIC;
		instrMemReady            : IN  STD_LOGIC;
		instrMemIn               : IN  STD_LOGIC_VECTOR (7 DOWNTO 0);
		dataMemIn                : IN  STD_LOGIC_VECTOR (7 DOWNTO 0);
		dataMemOut               : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
		readDataMem              : OUT STD_LOGIC;
		readInstrMem             : OUT STD_LOGIC;
		writeDataMem             : OUT STD_LOGIC;
		dataMemAddr              : OUT STD_LOGIC_VECTOR (len - 1 DOWNTO 0);
		instrMemAddr             : OUT STD_LOGIC_VECTOR (len - 1 DOWNTO 0);
		--interrupt inputs and outputs
		machineExternalInterrupt : IN  STD_LOGIC;
		machineTimerInterrupt    : IN  STD_LOGIC;
		machineSoftwareInterrupt : IN  STD_LOGIC;
		userExternalInterrupt    : IN  STD_LOGIC;
		userTimerInterrupt       : IN  STD_LOGIC;
		userSoftwareInterrupt    : IN  STD_LOGIC;
		interruptProcessing      : OUT STD_LOGIC
	);
END ENTITY;
--
ARCHITECTURE procedural OF aftab_core IS
	SIGNAL selPC                          : STD_LOGIC;
	SIGNAL selI4                          : STD_LOGIC;
	SIGNAL selP2                          : STD_LOGIC;
	SIGNAL selP1                          : STD_LOGIC;
	SIGNAL selJL                          : STD_LOGIC;
	SIGNAL selImm                         : STD_LOGIC;
	SIGNAL selAdd                         : STD_LOGIC;
	SIGNAL selI4PC                        : STD_LOGIC;
	SIGNAL selInc4pc                      : STD_LOGIC;
	SIGNAL selData                        : STD_LOGIC;
	SIGNAL selBSU                         : STD_LOGIC;
	SIGNAL selLLU                         : STD_LOGIC;
	SIGNAL selDARU                        : STD_LOGIC;
	SIGNAL selASU                         : STD_LOGIC;
	SIGNAL selAAU                         : STD_LOGIC;
	SIGNAL shr                            : STD_LOGIC;
	SIGNAL shl                            : STD_LOGIC;
	SIGNAL dataInstrBar                   : STD_LOGIC;
	SIGNAL writeRegFile                   : STD_LOGIC;
	SIGNAL addSubBar                      : STD_LOGIC;
	SIGNAL pass                           : STD_LOGIC;
	SIGNAL selAuipc                       : STD_LOGIC;
	SIGNAL comparedsignedunsignedbar      : STD_LOGIC;
	SIGNAL ldIR                           : STD_LOGIC;
	SIGNAL ldADR                          : STD_LOGIC;
	SIGNAL ldPC                           : STD_LOGIC;
	SIGNAL ldDr                           : STD_LOGIC;
	SIGNAL ldByteSigned                   : STD_LOGIC;
	SIGNAL ldHalfSigned                   : STD_LOGIC;
	SIGNAL load                           : STD_LOGIC;
	SIGNAL setOne                         : STD_LOGIC;
	SIGNAL setZero                        : STD_LOGIC;
	SIGNAL startDataDARU                  : STD_LOGIC;
	SIGNAL startInstrDARU                 : STD_LOGIC;
	SIGNAL startDAWU                      : STD_LOGIC;
	SIGNAL completeDataDARU               : STD_LOGIC;
	SIGNAL completeInstrDARU              : STD_LOGIC;
	SIGNAL completeDAWU                   : STD_LOGIC;
	SIGNAL startMultiplyAAU               : STD_LOGIC;
	SIGNAL startDivideAAU                 : STD_LOGIC;
	SIGNAL completeAAU                    : STD_LOGIC;
	SIGNAL signedSigned                   : STD_LOGIC;
	SIGNAL signedUnsigned                 : STD_LOGIC;
	SIGNAL unsignedUnsigned               : STD_LOGIC;
	SIGNAL selAAL                         : STD_LOGIC;
	SIGNAL selAAH                         : STD_LOGIC;
	SIGNAL eq                             : STD_LOGIC;
	SIGNAL gt                             : STD_LOGIC;
	SIGNAL lt                             : STD_LOGIC;
	SIGNAL dataerror                      : STD_LOGIC;
	SIGNAL nBytes                         : STD_LOGIC_VECTOR (1 DOWNTO 0);
	SIGNAL selLogic                       : STD_LOGIC_VECTOR (1 DOWNTO 0);
	SIGNAL selShift                       : STD_LOGIC_VECTOR (1 DOWNTO 0);
	SIGNAL muxCode                        : STD_LOGIC_VECTOR (11 DOWNTO 0);
	SIGNAL modeTvec                       : STD_LOGIC_VECTOR (1 DOWNTO 0);
	SIGNAL previousPRV                    : STD_LOGIC_VECTOR (1 DOWNTO 0);
	SIGNAL delegationMode                 : STD_LOGIC_VECTOR (1 DOWNTO 0);
	SIGNAL IR                             : STD_LOGIC_VECTOR (31 DOWNTO 0);
	SIGNAL selCSR                         : STD_LOGIC;
	SIGNAL interruptRaise                 : STD_LOGIC;
	SIGNAL mipCCLdDisable                 : STD_LOGIC;
	SIGNAL ldValueCSR                     : STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL selImmCSR                      : STD_LOGIC;
	SIGNAL selReadWriteCSR                : STD_LOGIC;
	SIGNAL selP1CSR                       : STD_LOGIC;
	SIGNAL clrCSR                         : STD_LOGIC;
	SIGNAL setCSR                         : STD_LOGIC;
	SIGNAL selPC_CSR                      : STD_LOGIC;
	SIGNAL selCCMip_CSR                   : STD_LOGIC;
	SIGNAL selCause_CSR                   : STD_LOGIC;
	SIGNAL selMepc_CSR                    : STD_LOGIC;
	SIGNAL machineStatusAlterationPreCSR  : STD_LOGIC;
	SIGNAL userStatusAlterationPreCSR     : STD_LOGIC;
	SIGNAL machineStatusAlterationPostCSR : STD_LOGIC;
	SIGNAL userStatusAlterationPostCSR    : STD_LOGIC;
	SIGNAL writeRegBank                   : STD_LOGIC;
	SIGNAL dnCntCSR                       : STD_LOGIC;
	SIGNAL upCntCSR                       : STD_LOGIC;
	SIGNAL ldCntCSR                       : STD_LOGIC;
	SIGNAL zeroCntCSR                     : STD_LOGIC;
	SIGNAL ldFlags                        : STD_LOGIC;
	SIGNAL zeroFlags                      : STD_LOGIC;
	SIGNAL ldDelegation                   : STD_LOGIC;
	SIGNAL ldMachine                      : STD_LOGIC;
	SIGNAL ldUser                         : STD_LOGIC;
	SIGNAL loadMieReg                     : STD_LOGIC;
	SIGNAL loadMieUieField                : STD_LOGIC;
	SIGNAL mirrorUser                     : STD_LOGIC;
	SIGNAL selCSRAddrFromInst             : STD_LOGIC;
	SIGNAL selRomAddress                  : STD_LOGIC;
	SIGNAL validAccessCSR                 : STD_LOGIC;
	SIGNAL readOnlyCSR                    : STD_LOGIC;
	SIGNAL selInterruptAddressDirect      : STD_LOGIC;
	SIGNAL selInterruptAddressVectored    : STD_LOGIC;
	SIGNAL ecallFlag                      : STD_LOGIC;
	SIGNAL illegalInstrFlag               : STD_LOGIC;
	SIGNAL instrMisalignedOut             : STD_LOGIC;
	SIGNAL loadMisalignedOut              : STD_LOGIC;
	SIGNAL storeMisalignedOut             : STD_LOGIC;
	SIGNAL selTval_CSR                    : STD_LOGIC;
	SIGNAL exceptionRaise                 : STD_LOGIC;
	SIGNAL checkMisalignedDARU            : STD_LOGIC;
	SIGNAL checkMisalignedDAWU            : STD_LOGIC;
	SIGNAL dividedByZeroOut               : STD_LOGIC;
	SIGNAL mirror                         : STD_LOGIC;
	SIGNAL ldMieReg                       : STD_LOGIC;
	SIGNAL ldMieUieField                  : STD_LOGIC;
	SIGNAL selMedeleg_CSR                 : STD_LOGIC;
	SIGNAL selMideleg_CSR                 : STD_LOGIC;
BEGIN
	datapathAFTAB : ENTITY WORK.aftab_datapath
		PORT MAP
		(
			clk                            => clk,
			rst                            => rst,
			writeRegFile                   => writeRegFile,
			setOne                         => setOne,
			setZero                        => setZero,
			ComparedSignedUnsignedBar      => ComparedSignedUnsignedBar,
			selPC                          => selPC,
			selI4                          => selI4,
			selAdd                         => selAdd,
			selJL                          => selJL,
			selInc4pc                      => selInc4pc,
			selBSU                         => selBSU,
			selLLU                         => selLLU,
			selASU                         => selASU,
			selAAU                         => selAAU,
			selDARU                        => selDARU,
			selP1                          => selP1,
			selP2                          => selP2,
			selImm                         => selImm,
			ldPC                           => ldPC,
			zeroPC                         => '0',
			ldADR                          => ldADR,
			zeroADR                        => '0',
			ldDR                           => ldDR,
			zeroDR                         => '0',
			ldIR                           => ldIR,
			zeroIR                         => '0',
			ldByteSigned                   => ldByteSigned,
			ldHalfSigned                   => ldHalfSigned,
			load                           => load,
			selShift                       => selShift,
			addSubBar                      => addSubBar,
			pass                           => pass,
			selAuipc                       => selAuipc,
			muxCode                        => muxCode,
			selLogic                       => selLogic,
			startDAWU                      => startDAWU,
			startDataDARU                  => startDataDARU,
			startInstrDARU                 => startInstrDARU,
			startMultiplyAAU               => startMultiplyAAU,
			startDivideAAU                 => startDivideAAU,
			signedSigned                   => signedSigned,
			signedUnsigned                 => signedUnsigned,
			unsignedUnsigned               => unsignedUnsigned,
			selAAL                         => selAAL,
			selAAH                         => selAAH,
			dataInstrBar                   => dataInstrBar,
			completeAAU                    => completeAAU,
			nBytes                         => nBytes,
			dataMemReady                   => dataMemReady,
			instrMemReady                  => instrMemReady,
			instrMemIn                     => instrMemIn,
			dataMemIn                      => dataMemIn,
			dataMemOut                     => dataMemOut,
			dataMemAddrDAWU                => dataMemAddr,
			dataMemAddrDARU                => dataMemAddr,
			instrMemAddrDARU               => instrMemAddr,
			writeDataMem                   => writeDataMem,
			readDataMem                    => readDataMem,
			readInstrMem                   => readInstrMem,
			IR                             => IR,
			lt                             => lt,
			eq                             => eq,
			gt                             => gt,
			completeDAWU                   => completeDAWU,
			completeDataDARU               => completeDataDARU,
			completeInstrDARU              => completeInstrDARU,
			selCSR                         => selCSR,
			machineExternalInterrupt       => machineExternalInterrupt,
			machineTimerInterrupt          => machineTimerInterrupt,
			machineSoftwareInterrupt       => machineSoftwareInterrupt,
			userExternalInterrupt          => userExternalInterrupt,
			userTimerInterrupt             => userTimerInterrupt,
			userSoftwareInterrupt          => userSoftwareInterrupt,
			ldValueCSR                     => ldValueCSR,
			mipCCLdDisable                 => mipCCLdDisable,
			selImmCSR                      => selImmCSR,
			selP1CSR                       => selP1CSR,
			selReadWriteCSR                => selReadWriteCSR,
			clrCSR                         => clrCSR,
			setCSR                         => setCSR,
			selPC_CSR                      => selPC_CSR,
			selTval_CSR                    => selTval_CSR,
			selMedeleg_CSR                 => selMedeleg_CSR,
			selMideleg_CSR                 => selMideleg_CSR,
			selCCMip_CSR                   => selCCMip_CSR,
			selCause_CSR                   => selCause_CSR,
			selMepc_CSR                    => selMepc_CSR,
			selInterruptAddressDirect      => selInterruptAddressDirect,
			selInterruptAddressVectored    => selInterruptAddressVectored,
			writeRegBank                   => writeRegBank,
			dnCntCSR                       => dnCntCSR,
			upCntCSR                       => upCntCSR,
			ldCntCSR                       => ldCntCSR,
			zeroCntCSR                     => zeroCntCSR,
			ldFlags                        => ldFlags,
			zeroFlags                      => zeroFlags,
			ldDelegation                   => ldDelegation,
			ldMachine                      => ldMachine,
			ldUser                         => ldUser,
			loadMieReg                     => loadMieReg,
			loadMieUieField                => loadMieUieField,
			mirrorUser                     => mirrorUser,
			machineStatusAlterationPreCSR  => machineStatusAlterationPreCSR,
			userStatusAlterationPreCSR     => userStatusAlterationPreCSR,
			machineStatusAlterationPostCSR => machineStatusAlterationPostCSR,
			userStatusAlterationPostCSR    => userStatusAlterationPostCSR,
			checkMisalignedDARU            => checkMisalignedDARU,
			checkMisalignedDAWU            => checkMisalignedDAWU,
			selCSRAddrFromInst             => selCSRAddrFromInst,
			selRomAddress                  => selRomAddress,
			ecallFlag                      => ecallFlag,
			illegalInstrFlag               => illegalInstrFlag,
			instrMisalignedOut             => instrMisalignedOut,
			loadMisalignedOut              => OPEN,
			storeMisalignedOut             => OPEN,
			dividedByZeroOut               => dividedByZeroOut,
			validAccessCSR                 => validAccessCSR,
			readOnlyCSR                    => readOnlyCSR,
			mirror                         => mirror,
			ldMieReg                       => ldMieReg,
			ldMieUieField                  => ldMieUieField,
			interruptRaise                 => interruptRaise,
			exceptionRaise                 => exceptionRaise,
			delegationMode                 => delegationMode,
			previousPRV                    => previousPRV,
			modeTvec                       => modeTvec
		);
	controllerAFTAB : ENTITY WORK.aftab_controller
		PORT
	MAP(
	clk                            => clk,
	rst                            => rst,
	completeDataDARU               => completeDataDARU,
	completeInstrDARU              => completeInstrDARU,
	completeDAWU                   => completeDAWU,
	completeAAU                    => completeAAU,
	lt                             => lt,
	eq                             => eq,
	gt                             => gt,
	IR                             => IR,
	muxCode                        => muxCode,
	nBytes                         => nBytes,
	selLogic                       => selLogic,
	selShift                       => selShift,
	selPC                          => selPC,
	selI4                          => selI4,
	selP1                          => selP1,
	selP2                          => selP2,
	selJL                          => selJL,
	selImm                         => selImm,
	selAdd                         => selAdd,
	selInc4PC                      => selInc4PC,
	selBSU                         => selBSU,
	selLLU                         => selLLU,
	selASU                         => selASU,
	selAAU                         => selAAU,
	selDARU                        => selDARU,
	dataInstrBar                   => dataInstrBar,
	writeRegFile                   => writeRegFile,
	addSubBar                      => addSubBar,
	pass                           => pass,
	selAuipc                       => selAuipc,
	comparedsignedunsignedbar      => comparedsignedunsignedbar,
	ldIR                           => ldIR,
	ldADR                          => ldADR,
	ldPC                           => ldPC,
	ldDr                           => ldDr,
	ldByteSigned                   => ldByteSigned,
	ldHalfSigned                   => ldHalfSigned,
	load                           => load,
	setOne                         => setOne,
	setZero                        => setZero,
	startDataDARU                  => startDataDARU,
	startInstrDARU                 => startInstrDARU,
	startDAWU                      => startDAWU,
	startMultiplyAAU               => startMultiplyAAU,
	startDivideAAU                 => startDivideAAU,
	signedSigned                   => signedSigned,
	signedUnsigned                 => signedUnsigned,
	unsignedUnsigned               => unsignedUnsigned,
	selAAL                         => selAAL,
	selAAH                         => selAAH,
	interruptRaise                 => interruptRaise,
	exceptionRaise                 => exceptionRaise,
	ecallFlag                      => ecallFlag,
	illegalInstrFlag               => illegalInstrFlag,
	instrMisalignedOut             => instrMisalignedOut,
	loadMisalignedOut              => '0',
	storeMisalignedOut             => '0',
	dividedByZeroOut               => dividedByZeroOut,
	validAccessCSR                 => validAccessCSR,
	readOnlyCSR                    => readOnlyCSR,
	mirror                         => mirror,
	ldMieReg                       => ldMieReg,
	ldMieUieField                  => ldMieUieField,
	delegationMode                 => delegationMode,
	previousPRV                    => previousPRV,
	modeTvec                       => modeTvec,
	mipCCLdDisable                 => mipCCLdDisable,
	selCCMip_CSR                   => selCCMip_CSR,
	selCause_CSR                   => selCause_CSR,
	selPC_CSR                      => selPC_CSR,
	selTval_CSR                    => selTval_CSR,
	selMedeleg_CSR                 => selMedeleg_CSR,
	selMideleg_CSR                 => selMideleg_CSR,
	ldValueCSR                     => ldValueCSR,
	ldCntCSR                       => ldCntCSR,
	dnCntCSR                       => dnCntCSR,
	upCntCSR                       => upCntCSR,
	ldFlags                        => ldFlags,
	zeroFlags                      => zeroFlags,
	ldDelegation                   => ldDelegation,
	ldMachine                      => ldMachine,
	ldUser                         => ldUser,
	loadMieReg                     => loadMieReg,
	loadMieUieField                => loadMieUieField,
	mirrorUser                     => mirrorUser,
	selCSR                         => selCSR,
	selP1CSR                       => selP1CSR,
	selReadWriteCSR                => selReadWriteCSR,
	selImmCSR                      => selImmCSR,
	setCSR                         => setCSR,
	clrCSR                         => clrCSR,
	writeRegBank                   => writeRegBank,
	selCSRAddrFromInst             => selCSRAddrFromInst,
	selRomAddress                  => selRomAddress,
	selMepc_CSR                    => selMepc_CSR,
	selInterruptAddressDirect      => selInterruptAddressDirect,
	selInterruptAddressVectored    => selInterruptAddressVectored,
	checkMisalignedDARU            => checkMisalignedDARU,
	checkMisalignedDAWU            => checkMisalignedDAWU,
	machineStatusAlterationPreCSR  => machineStatusAlterationPreCSR,
	userStatusAlterationPreCSR     => userStatusAlterationPreCSR,
	machineStatusAlterationPostCSR => machineStatusAlterationPostCSR,
	userStatusAlterationPostCSR    => userStatusAlterationPostCSR,
	zeroCntCSR                     => zeroCntCSR
	);
	interruptProcessing <= mipCCLdDisable;
END ARCHITECTURE procedural;
