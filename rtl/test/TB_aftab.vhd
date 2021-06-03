library IEEE;
use IEEE.std_logic_1164.all;
use WORK.all;

entity tb_aftab is
end tb_aftab;

architecture TEST of tb_aftab is


	constant dataWidth    : INTEGER := 8;
	constant addressWidth : INTEGER := 32;


    signal clk_s: std_logic := '0';
    signal rst_s: std_logic := '1';


	signal memReady_s: std_logic:= '1';
	signal memRead_s: std_logic;
	signal memWrite_s: std_logic;
	signal memDataBUS_s: std_logic_vector(dataWidth-1 downto 0);
	signal memAddr_s: std_logic_vector(addressWidth-1 downto 0);

	
	component aftab_memory IS
		GENERIC (
			dataWidth    : INTEGER := 8;
			addressWidth : INTEGER := 32;
			blocksize    : INTEGER := 2**11;
			segmentsno   : INTEGER := 2**19;
			cycle        : TIME    := 25 ns;
			timer        : TIME    := 4 ns);
		PORT (
			clk, readmem, writemem : IN  STD_LOGIC;
			addressBus             : IN  STD_LOGIC_VECTOR (addressWidth - 1 DOWNTO 0);
			dataBus                : INOUT  STD_LOGIC_VECTOR (dataWidth - 1 DOWNTO 0);
			memdataready           : OUT STD_LOGIC
		);
	END component;

    Component aftab_core IS
	GENERIC (len : INTEGER := 32);
	PORT (
		clk        : IN  STD_LOGIC;
		rst        : IN  STD_LOGIC;
		memReady   : IN  STD_LOGIC;
		memRead    : OUT STD_LOGIC;
		memWrite   : OUT STD_LOGIC;
		memDataIN  : IN  STD_LOGIC_VECTOR (7 DOWNTO 0);
		memDataOUT : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
		memAddr    : OUT STD_LOGIC_VECTOR (len - 1 DOWNTO 0)
	);
    END component;




	-- component aftab_mem is 
	-- 	GENERIC (len : INTEGER := 32;
	-- 		 N_bits : integer := 8);
	-- 	PORT (
	-- 		clk        : IN  STD_LOGIC;
	-- 		rst        : IN  STD_LOGIC;
	-- 		memReady   : OUT  STD_LOGIC;
	-- 		memRead    : IN STD_LOGIC;
	-- 		memWrite   : IN STD_LOGIC;
	-- 		memDataIN : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
	-- 		memAddr    : IN STD_LOGIC_VECTOR (len - 1 DOWNTO 0);
	-- 		memDataOUT  : OUT  STD_LOGIC_VECTOR (7 DOWNTO 0)
	-- 	);
	-- end component;


begin

        aftab_ut: aftab_core 
        Generic map (len=>32)
        Port map (clk		=>	clk_s,
				  rst		=>	rst_s,
				  memReady	=>	memReady_s,
				  memRead	=>	memRead_s,
				  memWrite	=>	memWrite_s,
				  memDataIN	=>	memDataBUS_s,
				  memDataOUT=>	memDataBUS_s,
				  memAddr	=>	memAddr_s
		);

		aftab_mem_ut: aftab_memory port map (
			clk				=> clk_s,
			readmem 		=> rst_s,
 			writemem 		=> memWrite_s,
			addressBus 		=> memAddr_s, 
			dataBus     	=> memDataBUS_s,
			memdataready  	=> memReady_s       
		);


        PCLOCK : process(clk_s)
	begin
		clk_s <= not(clk_s) after 1 ns;	
	end process;
	
	rst_s <= '0', '1' after 6 ns, '0' after 30 ns;
       

end TEST;



