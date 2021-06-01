 LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY ErrorDecoderDAWU IS
    	GENERIC (len : INTEGER := 32);
    	PORT (
    	    	clk, rst     : IN  STD_LOGIC;
    	    	nBytes       : IN  STD_LOGIC_VECTOR (1 DOWNTO 0);
    	    	addrIn       : IN  STD_LOGIC_VECTOR (1 DOWNTO 0);
    	    	LdErrorFlag  : IN STD_LOGIC;
    	    	dataError    : OUT STD_LOGIC
    	);
END ENTITY ErrorDecoderDAWU;

ARCHITECTURE behavioral OF ErrorDecoderDAWU IS
    	SIGNAL dataWriteErrorP  : STD_LOGIC;
		SIGNAL cmp_01 				: STD_LOGIC;
		SIGNAL cmp_10 				: STD_LOGIC;
		SIGNAL cmp_11 				: STD_LOGIC;
BEGIN
    	-- Error Decoder
--		PROCESS (nBytes, addrIn) BEGIN
--					IF (nBytes = "01") THEN --Load Half
--						IF (addrIn = "01" OR addrIn = "11") THEN
--						dataWriteErrorP <= '1';
--						END IF;
--					ELSIF (nBytes = "11") THEN -- Load Word
--    	    	    	IF (addrIn = "01" OR addrIn = "11") THEN
--						dataWriteErrorP <= '1';
--						END IF;
--					END IF;
--    	END PROCESS;
		
	cmp_01 <= '1' WHEN (addrIn = "01") ELSE '0';
	cmp_10 <= '1' WHEN (addrIn = "10") ELSE '0';
	cmp_11 <= '1' WHEN (addrIn = "11") ELSE '0';
	
	dataWriteErrorP <= (cmp_01 OR cmp_11)           WHEN (nBytes = "01") ELSE 
	                   (cmp_01 OR cmp_10 OR cmp_11) WHEN (nBytes = "11") ELSE '0';
							  
	
    	--- Error Register
		RegisterInst: ENTITY work.aftab_oneBitReg 
				  PORT MAP (
						 clk => clk, rst => rst,
						 zero => '0', load => LdErrorFlag,
						 inReg => dataWriteErrorP,
						 outReg => dataError);

END ARCHITECTURE behavioral;