-- **************************************************************************************
--	Filename:	aftab_memory.vhd
--	Project:	CNL_RISC-V
--  Version:	1.0
--	Date:		29 March 2022
--
-- Copyright (C) 2022 CINI Cybersecurity National Laboratory and University of Teheran
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
		dataWidth      : INTEGER := 8;
		addressWidth   : INTEGER := 32;
		actual_address : INTEGER := 13;
		size           : INTEGER := 2**actual_address -- 2^12 for data and 2^12 for instr, 4 K each
	);  
	PORT (
		clk           : IN  STD_LOGIC;
		rst           : IN  STD_LOGIC;
		readMem       : IN  STD_LOGIC;
		writeMem      : IN  STD_LOGIC;
		addressBus    : IN  STD_LOGIC_VECTOR (addressWidth - 1 DOWNTO 0);
		dataIn     	  : IN  STD_LOGIC_VECTOR (dataWidth - 1 DOWNTO 0);
		dataOut       : OUT STD_LOGIC_VECTOR (dataWidth - 1 DOWNTO 0);
		log_en 		  : IN STD_LOGIC;
		ready  		  : OUT STD_LOGIC
	);
END aftab_memory;

ARCHITECTURE behavioral OF aftab_memory IS

	TYPE mem_type IS ARRAY (0 TO size - 1) OF STD_LOGIC_VECTOR (dataWidth-1 DOWNTO 0);
	SIGNAL mem : MEM_TYPE;

	-- Memory boundaries - change this according to the linker script: sw/ref/link.common.ld
	CONSTANT base_iram : INTEGER := 16#00000#; 
	CONSTANT end_iram : INTEGER := 16#FFFFF#;
	
	CONSTANT base_dram : INTEGER := 16#100000#; 
	CONSTANT end_dram : INTEGER := 16#100600#;

	CONSTANT base_dram_actual : INTEGER := 16#1000#;
	CONSTANT size_dram : INTEGER := 16#0FFF#;
	
BEGIN

RW : PROCESS(rst, clk, writeMem, readMem, addressBus, log_en)

		VARIABLE adr                 : STD_LOGIC_VECTOR(actual_address-1 DOWNTO 0);
		VARIABLE memline             : LINE;
		VARIABLE memline_log         : LINE;
		VARIABLE err_check           : FILE_OPEN_STATUS;
		VARIABLE linechar	         : CHARACTER;
		VARIABLE read_address	     : STD_LOGIC_VECTOR (31 DOWNTO 0);
		VARIABLE read_data           : STD_LOGIC_VECTOR (31 DOWNTO 0);
		FILE f                       : TEXT;
		FILE f_log                   : TEXT;
		variable index 				 : INTEGER:=0;	

	BEGIN

		IF rst = '1' THEN
			dataOut <= (OTHERS => 'Z');
			ready <= '1';
			-- Load memory content from file
			mem <= (OTHERS => (OTHERS => '0'));
			FILE_OPEN(err_check, f, ("./slm_files/spi_stim.txt"), READ_MODE);
			IF err_check = open_ok THEN
				WHILE NOT ENDFILE (f) LOOP
					READLINE (f, memline);
					HREAD (memline, read_address);
					READ (memline, linechar); -- read character '_' 
					HREAD (memline, read_data);
					IF UNSIGNED(read_address) > end_iram THEN -- it is a data address (see file link.common.ld)
						adr := '1' & read_address(actual_address-2 DOWNTO 0);
					ELSE -- it is a program address
						adr := '0' & read_address(actual_address-2 DOWNTO 0);
					END IF;
					mem(TO_INTEGER(UNSIGNED(adr))) 	   <= read_data(7 DOWNTO 0);
					mem(TO_INTEGER(UNSIGNED(adr) + 1)) <= read_data(15 DOWNTO 8);
					mem(TO_INTEGER(UNSIGNED(adr) + 2)) <= read_data(23 DOWNTO 16);
					mem(TO_INTEGER(UNSIGNED(adr) + 3)) <= read_data(31 DOWNTO 24);
				END LOOP;
				FILE_CLOSE (f);
			END IF;
		
		ELSIF log_en = '1' THEN

			FILE_OPEN(err_check, f_log, ("./slm_files/dram_dump.txt"), WRITE_MODE);
			index:=base_dram;
			WHILE index < (base_dram+size_dram-1) LOOP
				write(memline_log,to_hstring(to_signed(index, 32)),right,8);
				write(memline_log,'_',right,1);
				hwrite(memline_log, mem(index-base_dram+base_dram_actual+3)&mem(index-base_dram+base_dram_actual+2)&mem(index-base_dram+base_dram_actual+1)&mem(index-base_dram+base_dram_actual), right, 8);
      			writeline(f_log, memline_log);
				index:=index+4;				
			END LOOP;

			FILE_CLOSE (f_log);

			
		ELSIF  readMem = '1' THEN
		
			IF UNSIGNED(addressBus) > end_iram THEN 
				adr := '1' & addressBus(actual_address-2 DOWNTO 0);
			ELSE
				adr := '0' & addressBus(actual_address-2 DOWNTO 0);
			END IF;
			dataOut <= mem(TO_INTEGER(UNSIGNED(adr)));

		ELSIF writeMem = '1' and falling_edge(clk) THEN
			IF UNSIGNED(addressBus) > end_iram THEN 
				adr := '1' & addressBus(actual_address-2 DOWNTO 0);
				mem(TO_INTEGER(UNSIGNED(adr))) <= dataIn;
			END IF;
			-- writing on instruction portion is inhibited

		ELSE
			dataOut <= (OTHERS => 'Z');
			
		END IF;
	
	END PROCESS;

END behavioral;
