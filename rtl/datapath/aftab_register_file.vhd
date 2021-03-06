-- **************************************************************************************
--	Filename:	aftab_register_file.vhd
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
--	Register File Unit (RFU) of the AFTAB core
--
-- **************************************************************************************

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY aftab_register_file IS
	GENERIC (len : integer := 32);
	PORT (
		clk			 : IN STD_LOGIC;
		rst      	 : IN STD_LOGIC;
		setZero      : IN STD_LOGIC;
		setOne       : IN STD_LOGIC;
		rs1          : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		rs2          : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		rd           : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		writeData    : IN STD_LOGIC_VECTOR (len-1 DOWNTO 0);
		writeRegFile : IN STD_LOGIC; 
		p1 			 : OUT STD_LOGIC_VECTOR (len-1 DOWNTO 0); 
		p2 			 : OUT STD_LOGIC_VECTOR (len-1 DOWNTO 0) 
	);
END ENTITY aftab_register_file ;

ARCHITECTURE behavioral OF aftab_register_file IS 
	TYPE reg_arr IS ARRAY (0 TO 31) OF STD_LOGIC_VECTOR (31 DOWNTO 0) ;
	SIGNAL rData : reg_arr  := (OTHERS => (OTHERS => '0')) ;
BEGIN 
	p1 <= rData(to_integer (unsigned(rs1))) WHEN (rs1/="00000") ELSE (OTHERS => '0');
	p2 <= rData(to_integer (unsigned(rs2))) WHEN (rs2/="00000") ELSE (OTHERS => '0');
	
	wrProc: PROCESS (clk, rst) 
	BEGIN
		IF (rst = '1') THEN
			rData <= (OTHERS => (OTHERS => '0'));	
		ELSIF (clk = '1' AND clk'EVENT) THEN
			IF (rd/="00000" ) THEN
				IF (setOne = '1') THEN
					rData(to_integer(unsigned(rd))) <= ((len-1 DOWNTO 1 => '0') & '1'); 	
				ELSIF (setZero = '1') THEN
					rData(to_integer(unsigned(rd))) <= (OTHERS => '0');	
				ELSIF (writeRegFile = '1') THEN
					rData(to_integer(unsigned(rd))) <= writeData;
				END IF;
			END IF;
		END IF;
	END PROCESS;
END ARCHITECTURE behavioral;
		
