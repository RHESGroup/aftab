-- **************************************************************************************
--	Filename:	aftab_su_divider.vhd
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
--	Container for the integer divider of the AFTAB core
--
-- **************************************************************************************
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY aftab_su_divider IS
	GENERIC
		(len : INTEGER := 32);
	PORT
	(
		clk               : IN  STD_LOGIC;
		rst               : IN  STD_LOGIC;
		startSDiv         : IN  STD_LOGIC;
		SignedUnsignedbar : IN  STD_LOGIC;
		dividend          : IN  STD_LOGIC_VECTOR (len - 1 DOWNTO 0);
		divisor           : IN  STD_LOGIC_VECTOR (len - 1 DOWNTO 0);
		doneSDiv          : OUT STD_LOGIC;
		dividedByZeroFlag : OUT STD_LOGIC;
		Qout              : OUT STD_LOGIC_VECTOR (len - 1 DOWNTO 0);
		Remout            : OUT STD_LOGIC_VECTOR (len - 1 DOWNTO 0)
	);
END ENTITY aftab_su_divider;
ARCHITECTURE behavioral OF aftab_su_divider IS
	SIGNAL Remp        : STD_LOGIC_VECTOR (len DOWNTO 0);
	SIGNAL ddIn        : STD_LOGIC_VECTOR (len - 1 DOWNTO 0);
	SIGNAL drIn        : STD_LOGIC_VECTOR (len - 1 DOWNTO 0);
	SIGNAL Qp          : STD_LOGIC_VECTOR (len - 1 DOWNTO 0);
	SIGNAL endd        : STD_LOGIC;
	SIGNAL endr        : STD_LOGIC;
	SIGNAL enQ         : STD_LOGIC;
	SIGNAL enR         : STD_LOGIC;
	SIGNAL safeStart   : STD_LOGIC;
	SIGNAL divisorZero : STD_LOGIC;
BEGIN
	divisorZero       <= '1' WHEN divisor = X"00000000" ELSE '0';
	--	dividedByZeroFlag <='1' WHEN (divisor=X"00000000" and startSDiv)  ELSE  '0';
	dividedByZeroFlag <= startSDiv AND divisorZero;
	safeStart         <= NOT(divisorZero) AND startSDiv;
	endd              <= dividend (len - 1) AND SignedUnsignedbar;
	endr              <= divisor (len - 1) AND SignedUnsignedbar;
	enQ               <= (dividend (len - 1) XOR divisor (len - 1)) AND SignedUnsignedbar;
	enR               <= dividend (len - 1) AND SignedUnsignedbar;
	TCLdividend : ENTITY work.aftab_tcl
		GENERIC
		MAP (len => len)
		PORT MAP
		(
			aIn  => dividend,
			en   => endd,
			aOut => ddIn);
	TCLdivisor : ENTITY work.aftab_tcl
		GENERIC
		MAP (len => len)
		PORT
		MAP (
		aIn  => divisor,
		en   => endr,
		aOut => drIn);
	unsignedDiv : ENTITY work.aftab_divider
		GENERIC
		MAP (len => len)
		PORT
		MAP (
		clk       => clk,
		rst       => rst,
		startDiv  => safeStart,
		doneDiv   => doneSDiv,
		dividend  => ddIn,
		divisor   => drIn,
		Q         => Qp,
		Remainder => Remp);
	TCLQ : ENTITY work.aftab_tcl
		GENERIC
		MAP (len => len)
		PORT
		MAP (
		aIn  => Qp,
		en   => enQ,
		aOut => Qout);
	TCLRem : ENTITY work.aftab_tcl
		GENERIC
		MAP (len => len)
		PORT
		MAP (
		aIn  => Remp (len - 1 DOWNTO 0),
		en   => enR,
		aOut => Remout);
END ARCHITECTURE behavioral;
