LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY aftab_divider_counter IS 
GENERIC( len : INTEGER := 6);
   PORT( 
 	 clk : IN STD_LOGIC;
 	 rst : IN STD_LOGIC;
 	 zeroCnt : IN STD_LOGIC;
 	 incCnt  : IN STD_LOGIC;
 	 initCnt : IN STD_LOGIC;
 	 initValue : IN STD_LOGIC_VECTOR (len-1 DOWNTO 0);
 	 outCnt : OUT STD_LOGIC_VECTOR (len-1 DOWNTO 0);
	 coCnt  : OUT STD_LOGIC);
END aftab_divider_counter;

ARCHITECTURE Behavioral OF aftab_divider_counter IS
   SIGNAL temp : STD_LOGIC_VECTOR (len-1 DOWNTO 0);
   SIGNAL coCntp : STD_LOGIC;
	
BEGIN
    PROCESS (clk, rst)
    BEGIN
		IF( rst = '1' ) THEN
				temp <= (OTHERS => '0');
      ELSIF ( clk = '1' and clk 'EVENT)THEN

			IF( zeroCnt = '1' ) THEN
				 temp <= (OTHERS => '0');
			ELSIF (initCnt = '1') THEN
             temp <= initValue;
			ELSIF (incCnt = '1' AND coCntp = '0') THEN
             temp <= (temp + 1);
			END IF;
     END IF;
    END PROCESS;
   coCntp <= '1' WHEN (temp = (temp'range => '1')) ELSE '0';
   coCnt <= coCntp;
   outCnt <= temp;
END Behavioral;