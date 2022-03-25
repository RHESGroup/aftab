LIBRARY IEEE;
LIBRARY STD;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
--
ENTITY aftab_memory_model IS
	GENERIC
	(	by : INTEGER := 1;
		dataWidth    : INTEGER := 8;
		addressWidth : INTEGER := 32;
		cycle        : TIME    := 25 ns;
		timer        : TIME    := 5 ns);
	PORT
	(
		clk, readmem, writemem : IN    STD_LOGIC;
		addressBus             : IN    STD_LOGIC_VECTOR (addressWidth - 1 DOWNTO 0);
		dataBus                : INOUT STD_LOGIC_VECTOR (dataWidth - 1 DOWNTO 0);
		memDataReady           : OUT   STD_LOGIC
	);
END aftab_memory_model;
--
ARCHITECTURE behavioral OF aftab_memory_model IS

	TYPE AutomaticIdGenerator IS PROTECTED
		IMPURE FUNCTION ID RETURN INTEGER;
	END PROTECTED AutomaticIdGenerator;
	
	TYPE AutomaticIdGenerator IS PROTECTED BODY
		VARIABLE counter_val  : INTEGER := 0;
		IMPURE FUNCTION ID RETURN INTEGER IS
		BEGIN
		counter_val:= counter_val + 1;
		RETURN counter_val;
		END FUNCTION ID;
	END PROTECTED BODY AutomaticIdGenerator;
	
	SHARED VARIABLE name: AutomaticIdGenerator;
	SIGNAL memDataReady1, memDataReady2 : STD_LOGIC;
BEGIN
	seg1 : ENTITY WORK.aftab_memory_segment 
		GENERIC MAP(
			dataWidth       => dataWidth,
			addressWidth    => addressWidth,
			segmentID       => name.ID,
			segmentSize     => 2 ** 11,
			blockSize       => 2 ** 11,
			startingAddress => 0,
			cycle           => cycle,
			timer           => timer)
		PORT MAP (
			clk, readmem, writemem,
			addressBus,
			dataBus,
			memDataReady1
			);
	seg2 : ENTITY WORK.aftab_memory_segment 
		GENERIC MAP(
			dataWidth       => dataWidth,
			addressWidth    => addressWidth,
			segmentID       => name.ID,
			segmentSize     => 2 ** 7,
			blockSize       => 2 ** 6,
			startingAddress => 2048,
			cycle           => cycle,
			timer           => timer)
		PORT MAP(
			clk, readmem, writemem,
			addressBus,
			dataBus,
			memDataReady2
			);
	memDataReady <= memDataReady1 OR memDataReady2;
END behavioral;

