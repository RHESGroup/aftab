LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY aftab_oneBitReg IS
    	PORT (
    	    	clk, rst   : IN  STD_LOGIC;
    	    	zero, load : IN  STD_LOGIC;
    	    	inReg      : IN  STD_LOGIC;
    	    	outReg     : OUT STD_LOGIC
    	);
END ENTITY aftab_oneBitReg;
--
ARCHITECTURE behavioral OF aftab_oneBitReg IS

BEGIN
    	PROCESS (clk, rst)
    	BEGIN
    	    	IF (rst = '1') THEN
    	    	    	outReg <= '0';
    	    	ELSIF (clk = '1' AND clk 'EVENT) THEN
    	    	    	IF (zero = '1') THEN
    	    	    	    	outReg <= '0';
    	    	    	ELSIF (load = '1') THEN
    	    	    	    	outReg <= inReg;
    	    	    	END IF;
    	    	END IF;
    	END PROCESS;
END ARCHITECTURE behavioral;
