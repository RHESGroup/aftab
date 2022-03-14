-- **************************************************************************************
--	Filename:	aftab_register_bank.vhd
--	Project:	CNL_RISC-V
--  Version:	1.0
--	History:
--	Date:		14 December 2021
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
--	CSR register bank of the AFTAB core
--
-- **************************************************************************************
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
ENTITY aftab_register_bank IS
	GENERIC
		(len : INTEGER := 32);
	PORT
	(
		clk              : IN  STD_LOGIC;
		rst              : IN  STD_LOGIC;
		writeRegBank     : IN  STD_LOGIC;
		addressRegBank   : IN  STD_LOGIC_VECTOR (11 DOWNTO 0);
		inputRegBank     : IN  STD_LOGIC_VECTOR (len - 1 DOWNTO 0);
		loadMieReg       : IN  STD_LOGIC;
		loadMieUieField  : IN  STD_LOGIC;
		outRegBank       : OUT STD_LOGIC_VECTOR (len - 1 DOWNTO 0);
		mirrorUstatus    : OUT STD_LOGIC;
		mirrorUie        : OUT STD_LOGIC;
		mirrorUip        : OUT STD_LOGIC;
		mirror           : OUT STD_LOGIC;
		ldMieReg         : OUT STD_LOGIC;
		ldMieUieField    : OUT STD_LOGIC;
		outMieFieldCCreg : OUT STD_LOGIC;
		outUieFieldCCreg : OUT STD_LOGIC;
		outMieCCreg      : OUT STD_LOGIC_VECTOR (len - 1 DOWNTO 0)
	);
END ENTITY aftab_register_bank;
ARCHITECTURE behavioral OF aftab_register_bank IS
SIGNAL CSR_AddrIn  : STD_LOGIC_VECTOR (11 DOWNTO 0);
SIGNAL CSR_AddrOut : STD_LOGIC_VECTOR (4 DOWNTO 0);
BEGIN
	CSR_registers : ENTITY work.aftab_CSR_registers
		GENERIC
		MAP(len => 32)
		PORT MAP
		(
			clk            => clk,
			rst            => rst,
			writeRegBank   => writeRegBank,
			addressRegBank => CSR_AddrOut,
			inputRegBank   => inputRegBank,
			outRegBank     => outRegBank
		);
	CSR_address_logic : ENTITY work.aftab_CSR_address_logic PORT
		MAP(
		addressRegBank => addressRegBank,
		ldMieReg       => ldMieReg,
		ldMieUieField  => ldMieUieField,
		mirrorUstatus  => mirrorUstatus,
		mirrorUie      => mirrorUie,
		mirrorUip      => mirrorUip,
		mirror         => mirror
		);	
	aftab_CSRAddressTranslator : ENTITY work.aftab_CSRAddressTranslator PORT
		MAP(
		CSR_AddrIn   => addressRegBank,
		CSR_AddrOut  => CSR_AddrOut
		);


	mieCCregister : ENTITY work.aftab_register
		GENERIC
		MAP(len => 32)
		PORT
		MAP(
		clk    => clk,
		rst    => rst,
		zero   => '0',
		load   => loadMieReg,
		inReg  => inputRegBank,
		outReg => outMieCCreg
		);
	mieFieldCCregister : ENTITY work.aftab_oneBitReg
		PORT
	MAP(
	clk    => clk,
	rst    => rst,
	zero   => '0',
	load   => loadMieUieField,
	inReg  => inputRegBank(3),
	outReg => outMieFieldCCreg
	);
	uieFieldCCregister : ENTITY work.aftab_oneBitReg
		PORT
	MAP(
	clk    => clk,
	rst    => rst,
	zero   => '0',
	load   => loadMieUieField,
	inReg  => inputRegBank(0),
	outReg => outUieFieldCCreg
	);
END ARCHITECTURE behavioral;