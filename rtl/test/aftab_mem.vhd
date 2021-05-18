LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;


entity aftab_mem is 
	GENERIC (len : INTEGER := 32);
	PORT (
		clk        : IN  STD_LOGIC;
		rst        : IN  STD_LOGIC;
		memReady   : OUT  STD_LOGIC;
		memRead    : IN STD_LOGIC;
		memWrite   : IN STD_LOGIC;
		memDataIN  : OUT  STD_LOGIC_VECTOR (7 DOWNTO 0);
		memDataOUT : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		memAddr    : IN STD_LOGIC_VECTOR (len - 1 DOWNTO 0)
	);
end aftab_mem;



architecture behv of aftab_mem is

begin
-- this implements connection between memory controller and memory datapath.0
    

end architecture;