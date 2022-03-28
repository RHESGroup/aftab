-- **************************************************************************************
--	Filename:	aftab_booth_multiplier_datapath.vhd
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
--	Datapath of the generic Booth multiplier for the AFTAB core
--
-- **************************************************************************************
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY aftab_booth_multiplier_datapath IS
	GENERIC
		(len : INTEGER := 33);
	PORT
	(
		clk    : IN  STD_LOGIC;
		rst    : IN  STD_LOGIC;
		shrMr  : IN  STD_LOGIC;
		ldMr   : IN  STD_LOGIC;
		ldM    : IN  STD_LOGIC;
		ldp    : IN  STD_LOGIC;
		zeroP  : IN  STD_LOGIC;
		sel    : IN  STD_LOGIC;
		subsel : IN  STD_LOGIC;
		M      : IN  STD_LOGIC_VECTOR (len - 1 DOWNTO 0);
		Mr     : IN  STD_LOGIC_VECTOR (len - 1 DOWNTO 0);
		P      : OUT STD_LOGIC_VECTOR (2 * len - 1 DOWNTO 0);
		op     : OUT STD_LOGIC_VECTOR (1 DOWNTO 0)
	);
END ENTITY aftab_booth_multiplier_datapath;
ARCHITECTURE behavioral OF aftab_booth_multiplier_datapath IS
	SIGNAL outM   : STD_LOGIC_VECTOR (len - 1 DOWNTO 0);
	SIGNAL Pin    : STD_LOGIC_VECTOR (len - 1 DOWNTO 0);
	SIGNAL Pout   : STD_LOGIC_VECTOR (len - 1 DOWNTO 0);
	SIGNAL result : STD_LOGIC_VECTOR (len - 1 DOWNTO 0);
	SIGNAL outMr  : STD_LOGIC_VECTOR (len DOWNTO 0);
	SIGNAL shMr   : STD_LOGIC_VECTOR (len DOWNTO 0);
	SIGNAL seiMr  : STD_LOGIC;
BEGIN
	mReg : ENTITY WORK.aftab_register
		GENERIC
		MAP(len => len)
		PORT MAP
		(
			clk    => clk,
			rst    => rst,
			zero   => '0',
			load   => ldM,
			inReg  => M,
			outReg => outM);
	shMr <= (Mr & '0');
	MrReg : ENTITY WORK.aftab_shift_register
		GENERIC
		MAP(len => len + 1)
		PORT
		MAP(
		clk    => clk,
		rst    => rst,
		inReg  => shMr,
		shiftR => shrMr,
		shiftL => '0',
		load   => ldMr,
		zero   => '0',
		serIn  => seiMr,
		serOut => OPEN,
		outReg => outMr);
	pReg : ENTITY WORK.aftab_register
		GENERIC
		MAP(len => len)
		PORT
		MAP(
		clk    => clk,
		rst    => rst,
		zero   => zeroP,
		load   => ldp,
		inReg  => Pin,
		outReg => Pout);
	addSub : ENTITY WORK.aftab_adder_subtractor
		GENERIC
		MAP(len => len)
		PORT
		MAP(
		a      => Pout,
		b      => outM,
		subSel => subSel,
		pass   => '0',
		cout   => OPEN,
		outRes => result);
	Pin  <= (result (len - 1) & result (len - 1 DOWNTO 1)) WHEN sel = '1' ELSE (Pout(len - 1) & Pout (len - 1 DOWNTO 1));
	seiMr<= result (0) WHEN sel = '1' ELSE Pout (0);
	op   <= outMr (1 DOWNTO 0);
	P    <= (Pout & outMr (len DOWNTO 1));
END ARCHITECTURE behavioral;
