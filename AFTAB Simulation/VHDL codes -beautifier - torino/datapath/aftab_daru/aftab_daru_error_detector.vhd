 LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY ErrorDecoderDARU IS
    	GENERIC (len : INTEGER := 32);
    	PORT (
    	    	clk             : IN  STD_LOGIC;
    	    	rst             : IN  STD_LOGIC;
    	    	nBytes          : IN  STD_LOGIC_VECTOR (1 DOWNTO 0);
    	    	addrIn          : IN  STD_LOGIC_VECTOR (1 DOWNTO 0);
    	    	dataInstBar     : IN  STD_LOGIC;
    	    	ldErrorFlag     : IN  STD_LOGIC;
    	    	dataError 		: OUT STD_LOGIC;
    	    	instrError 		: OUT STD_LOGIC;
    	    	misalignedError : OUT STD_LOGIC
    	);
END ENTITY ErrorDecoderDARU;

ARCHITECTURE behavioral OF ErrorDecoderDARU IS
    	SIGNAL dataReadingError : STD_LOGIC;
    	SIGNAL instReadingError : STD_LOGIC;
		SIGNAL misalignedErrorP : STD_LOGIC;
		SIGNAL cmp_01 				: STD_LOGIC;
		SIGNAL cmp_10 				: STD_LOGIC;
		SIGNAL cmp_11 				: STD_LOGIC;
		SIGNAL inReg			   : STD_LOGIC_VECTOR (2 DOWNTO 0);
		SIGNAL outReg 		   	: STD_LOGIC_VECTOR (2 DOWNTO 0);
BEGIN
	cmp_01 <= '1' WHEN (addrIn = "01") ELSE '0';
	cmp_10 <= '1' WHEN (addrIn = "10") ELSE '0';
	cmp_11 <= '1' WHEN (addrIn = "11") ELSE '0';
	
	misalignedErrorP <= (cmp_01 OR cmp_11)           WHEN (nBytes = "01") ELSE 
	                    (cmp_01 OR cmp_10 OR cmp_11) WHEN (nBytes = "11") ELSE '0';
							  
	dataReadingError <= misalignedErrorP WHEN dataInstBar = '1' ELSE '0';
	instReadingError <= misalignedErrorP WHEN dataInstBar = '0' ELSE '0';
	

	inReg <= (dataReadingError & instReadingError & misalignedErrorP);
	
    	--- Error Register
		RegisterInst: ENTITY work.aftab_register 
				  GENERIC MAP(len => 3)
				  PORT MAP (
						 clk => clk, rst => rst,
						 zero => '0', load => ldErrorFlag,
						 inReg => inReg,
						 outReg => outReg);
	dataError <= outReg(2);
	instrError <= outReg(1);
	misalignedError <= outReg(0);

END ARCHITECTURE behavioral;