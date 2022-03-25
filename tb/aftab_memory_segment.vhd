LIBRARY IEEE;
LIBRARY STD;
USE IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
--USE IEEE.STD_LOGIC_ARITH.ALL;
--USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;
--
ENTITY aftab_memory_segment IS
	GENERIC
	(
		dataWidth       : INTEGER := 8;
		addressWidth    : INTEGER := 32;
		segmentID       : INTEGER := 1;
		segmentSize     : INTEGER := 2 ** 10;
		blockSize       : INTEGER := 2 ** 2;
		startingAddress : INTEGER := 0;
		cycle           : TIME    := 25 ns;
		timer           : TIME    := 4 ns);
	PORT
	(
		clk, readmem, writemem : IN    STD_LOGIC;
		addressBus             : IN    STD_LOGIC_VECTOR (addressWidth - 1 DOWNTO 0);
		dataBus                : INOUT STD_LOGIC_VECTOR (dataWidth - 1 DOWNTO 0);
		memDataReady           : OUT   STD_LOGIC
	);
END aftab_memory_segment;
--
ARCHITECTURE behavioral OF aftab_memory_segment IS
	PROCEDURE check (segmentSize : IN INTEGER; blockSize : IN INTEGER) IS
		VARIABLE countSeg, countBlock : INTEGER := 0;
		VARIABLE s                    : STD_LOGIC_VECTOR (9 DOWNTO 0);
		VARIABLE b                    : STD_LOGIC_VECTOR (9 DOWNTO 0);
	BEGIN
		s := std_logic_vector(to_unsigned(segmentSize, 10));
		b := std_logic_vector(to_unsigned(blockSize, 10));
		FOR i IN 0 TO 9 LOOP
			IF (s(i) = '1') THEN
				countSeg := countSeg + 1;
			END IF;
			IF (b(i) = '1') THEN
				countBlock := countBlock + 1;
			END IF;
		END LOOP;
		IF (countSeg /= 1) THEN
			ASSERT false REPORT "Invalid segmentSize" SEVERITY note;
		END IF;
		IF (countBlock /= 1) THEN
			ASSERT false REPORT "Invalid blockSize" SEVERITY note;
		END IF;
	END check;
	
	TYPE mem_type IS ARRAY (0 TO blockSize - 1) OF STD_LOGIC_VECTOR (dataWidth - 1 DOWNTO 0);
	
	PROCEDURE MemLoad (buffermem : OUT mem_type; fileno : IN INTEGER) IS
		VARIABLE memline   : LINE;
		VARIABLE offset    : INTEGER := 0;
		VARIABLE err_check : FILE_OPEN_STATUS;
		VARIABLE hexcode_v : STD_LOGIC_VECTOR (dataWidth - 1 DOWNTO 0);
		FILE f             : TEXT;
	BEGIN
		buffermem := (OTHERS => (OTHERS => '0'));
		FILE_OPEN (err_check, f, ("mem" & INTEGER'IMAGE (segmentID) & "-" & INTEGER'IMAGE (fileno) & ".hex"), READ_MODE);
		IF err_check = open_ok THEN
			WHILE NOT ENDFILE (f) LOOP
				readline (f, memline);
				HREAD (memline, hexcode_v);
				buffermem (offset) := hexcode_v;
				offset             := offset + 1;
			END LOOP;
			file_close (f);
		END IF;
	END memload;
	
	PROCEDURE updateFILE (buffermem : IN mem_type; fileno : IN INTEGER) IS
		VARIABLE memline : LINE;
		FILE f           : TEXT OPEN WRITE_MODE IS ("mem" & INTEGER'IMAGE (segmentID) & "-" & INTEGER'IMAGE (fileno) & ".hex");
	BEGIN
		FOR i IN 0 TO blockSize - 1 LOOP
			HWRITE (memline, buffermem (i));
			WRITELINE (f, memline);
		END LOOP;
		FILE_CLOSE (f);
	END updatefile;
	SIGNAL cs : STD_LOGIC;
	SIGNAL addressBusInS : STD_LOGIC_VECTOR (addressWidth - 1 DOWNTO 0);

BEGIN

	check(segmentSize, blockSize);
	
	RW : PROCESS
		VARIABLE buffermem         : mem_type := (OTHERS => (OTHERS => '0'));
		VARIABLE addressBusInteger : INTEGER;
		VARIABLE memLoadedNum      : INTEGER := 1;
		VARIABLE blockID           : INTEGER;
		VARIABLE init              : BOOLEAN := true;
	BEGIN
		IF (init = true) THEN
			MemLoad (buffermem, 1);
			memLoadedNum := 1;
			init         := false;
		END IF;
		dataBus <= (OTHERS => 'Z');
		WAIT FOR 0 ns;
		--addressBusInteger := (conv_integer(addressBus) - startingAddress);
	--	addressBusInteger := (conv_integer(unsigned(addressBus)));
		addressBusInteger := to_integer(unsigned(addressBus));
		addressBusInS <=  std_logic_vector(to_unsigned(addressBusInteger, addressBus'length));
	---	addressBusInS <=  conv_std_logic_vector(addressBusInteger MOD blockSize, addressBus'length);
		blockID           := ((addressBusInteger/blockSize) + 1);
		memDataReady <= '0';
		IF (readmem = '1' AND cs = '1') THEN
			memDataReady <= '0';
			
			IF (memLoadedNum /= (blockID)) THEN
				UpdateFILE (buffermem, memLoadedNum);
				MemLoad (buffermem, blockID);
				memLoadedNum := blockID;
			END IF;
			
			dataBus <= buffermem (addressBusInteger MOD blockSize);
			
			WAIT FOR timer;
			memDataReady <= '1';
			WAIT FOR cycle;
			memDataReady <= '0';
		ELSIF (writemem = '1' AND cs = '1') THEN
			memDataReady <= '0';
			
			IF (memLoadedNum /= (blockID)) THEN
				UpdateFILE (buffermem, memLoadedNum);
				MemLoad (buffermem, blockID);
				memLoadedNum := blockID;
			END IF;
			
			buffermem (addressBusInteger MOD blockSize) := dataBus;
			
			WAIT FOR timer;
			memDataReady <= '1';
			WAIT FOR cycle;
			memDataReady <= '0';
		END IF;
		WAIT ON writemem, readmem, cs, addressBus;
	END PROCESS;
	cs <= '1' WHEN (startingAddress <= unsigned(addressBus) AND unsigned(addressBus) < (startingAddress + segmentSize)) ELSE '0';
END behavioral;

