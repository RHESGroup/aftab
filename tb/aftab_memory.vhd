-- **************************************************************************************
--	Filename:	aftab_memory.vhd
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
--	Unique memory entity for the AFTAB core
--
-- **************************************************************************************
LIBRARY IEEE;
LIBRARY STD;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;

ENTITY aftab_memory IS
	GENERIC (
		dataWidth    : INTEGER := 8;
		addressWidth : INTEGER := 32;
		size    	 : INTEGER := 2**13; -- 2^12 for data and 2^12 for instr, 4 K each
		cycle        : TIME    := 25 ns;
		timer        : TIME    := 4 ns);  
	PORT (
		clk          : IN  STD_LOGIC;
		rst          : IN  STD_LOGIC;
		readmem      : IN  STD_LOGIC;
		writemem     : IN  STD_LOGIC;
		addressBus   : IN  STD_LOGIC_VECTOR (addressWidth - 1 DOWNTO 0);
		dataBus      : INOUT  STD_LOGIC_VECTOR (dataWidth - 1 DOWNTO 0);
		memdataready : OUT STD_LOGIC
	);
END aftab_memory;

ARCHITECTURE behavioral OF aftab_memory IS

	TYPE mem_type IS ARRAY (0 TO size - 1) OF STD_LOGIC_VECTOR (dataWidth-1 DOWNTO 0);
	SIGNAL mem : mem_type;

BEGIN

RW : PROCESS

		VARIABLE adr                 : STD_LOGIC_VECTOR(12 DOWNTO 0);
		VARIABLE memline             : LINE;
		VARIABLE err_check           : FILE_OPEN_STATUS;
		VARIABLE linechar			 : CHARACTER;
		VARIABLE read_address	     : STD_LOGIC_VECTOR (31 DOWNTO 0);
		VARIABLE read_data		     : STD_LOGIC_VECTOR (31 DOWNTO 0);
		FILE f                       : TEXT;

	BEGIN

		WAIT ON rst, writemem, readmem, addressBus;
		
		IF rst = '1' THEN
			dataBus <= (OTHERS => 'Z');
			memdataready <= '1';
			-- Load memory content from file
			mem <= (OTHERS => (OTHERS => '0'));
			FILE_OPEN(err_check, f, ("./slm_files/spi_stim.txt"), READ_MODE);
			IF err_check = open_ok THEN
				WHILE NOT ENDFILE (f) LOOP
					READLINE (f, memline);
					HREAD (memline, read_address);
					READ (memline, linechar); -- read character '_' 
					HREAD (memline, read_data);
					IF UNSIGNED(read_address) > x"FFFFF" THEN -- it is a data address (see file link.common.ld)
						adr := '1' & read_address(11 DOWNTO 0);
					ELSE -- it is a program address
						adr := '0' & read_address(11 DOWNTO 0);
					END IF;
					mem(TO_INTEGER(UNSIGNED(adr))) 	<= read_data(7 DOWNTO 0);
					mem(TO_INTEGER(UNSIGNED(adr) + 1)) <= read_data(15 DOWNTO 8);
					mem(TO_INTEGER(UNSIGNED(adr) + 2)) <= read_data(23 DOWNTO 16);
					mem(TO_INTEGER(UNSIGNED(adr) + 3)) <= read_data(31 DOWNTO 24);
				END LOOP;
				FILE_CLOSE (f);
			END IF;

		ELSIF readmem = '1' THEN
			memdataready <= '0';
			adr := addressBus(12 DOWNTO 0);
			dataBus <= mem(TO_INTEGER(UNSIGNED(adr)));
		 	WAIT FOR timer;
			memdataready <= '1';
			WAIT FOR cycle;		
			memdataready <= '0';

		ELSIF writemem = '1' THEN
			memdataready <= '0';
			adr := addressBus(12 DOWNTO 0);
			mem(TO_INTEGER(UNSIGNED(adr))) <= dataBus;
		 	WAIT FOR timer;
			memdataready <= '1';
			WAIT FOR cycle;		
			memdataready <= '0';

		ELSE
			memdataready <= '1';
			dataBus <= (OTHERS => 'Z');

		END IF;
	
	END PROCESS;

END behavioral;