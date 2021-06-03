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
	signal memDataIN_s: std_logic_vector(dataWidth-1 downto 0);
	signal memDataOUT_s: std_logic_vector(dataWidth-1 downto 0);
	signal memAddr_s: std_logic_vector(addressWidth-1 downto 0);

	
	component aftab_mem  is
		generic(Address_bits:integer  := 32; 
				N_bits: integer := 8;
				N_lines: integer := 128);
		 port ( 
				rst: IN std_logic;
				clk: IN std_logic;
				input_data: IN std_logic_vector(N_bits-1 downto 0);
				input_address: 	IN std_logic_vector(31 downto 0);
				read_enable: In std_logic;
				write_enable: in std_logic;
				output_data: out std_logic_vector(N_bits-1 downto 0));
	end component;
		

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
				  memReady	=>	'1',
				  memRead	=>	memRead_s,
				  memWrite	=>	memWrite_s,
				  memDataIN	=>	memDataIN_s,
				  memDataOUT=>	memDataOUT_s,
				  memAddr	=>	memAddr_s
		);

		-- aftab_mem_ut: aftab_memory port map (
		-- 	clk				=> clk_s,
		-- 	readmem 		=> rst_s,
 		-- 	writemem 		=> memWrite_s,
		-- 	addressBus 		=> memAddr_s, 
		-- 	dataBus     	=> memDataBUS_s,
		-- 	memdataready  	=> memReady_s       
		-- );

		
		aftab_mem_ut: aftab_mem port map ( 
					rst => rst_s,
					clk=> clk_s,
					input_data => memDataOUT_s,
					input_address => memAddr_s,
					read_enable=> memRead_s,
					write_enable=> memWrite_s,
					output_data => memDataIN_s);



        PCLOCK : process(clk_s)
	begin
		clk_s <= not(clk_s) after 1 ns;	
	end process;
	
	rst_s <= '0', '1' after 6 ns, '0' after 30 ns;
       

end TEST;



