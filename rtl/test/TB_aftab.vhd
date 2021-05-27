library IEEE;
use IEEE.std_logic_1164.all;
use WORK.all;

entity tb_aftab is
end tb_aftab;

architecture TEST of tb_aftab is


    constant SIZE_IR      : integer := 32;       -- Instruction Register Size
    constant SIZE_PC      : integer := 32;       -- Program Counter Size
    constant SIZE_ALU_OPC : integer := 6;        -- ALU Op Code Word Size in case explicit coding is used
	constant DATA_SIZE : integer:= 8;
    signal clk_s: std_logic := '0';
    signal rst_s: std_logic := '1';
	signal memReady_s: std_logic:= '1';
	signal memRead_s: std_logic;
	signal memWrite_s: std_logic;
	signal memDataIN_s: std_logic_vector(DATA_SIZE-1 downto 0);
	signal memDataOUT_s: std_logic_vector(DATA_SIZE-1 downto 0);
	signal memAddr_s: std_logic_vector(SIZE_IR-1 downto 0);
	

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

	component aftab_iram  is
		generic (
		  RAM_DEPTH : integer := 512;
		  I_SIZE : integer := 32;
		  D_SIZE : integer := 8);
		port (
		  Rst  : in  std_logic;
		  Addr : in  std_logic_vector(I_SIZE - 1 downto 0);
		  Dout : out std_logic_vector(D_SIZE - 1 downto 0)
		  );
	  
	  end component;
begin

        aftab_ut: aftab_core 
        Generic map (len=>32)
        Port map (clk=>clk_s,rst=>rst_s,memReady=>memReady_s,memRead=>memRead_s,memWrite=>memWrite_s,memDataIN=>memDataIN_s,memDataOUT=>memDataOUT_s,memAddr=>memAddr_s);

		iram_cmp:  aftab_iram 
		Port map (Rst=>rst_s,Addr=>memAddr_s,Dout=>memDataIN_s);
	

        PCLOCK : process(clk_s)
	begin
		clk_s <= not(clk_s) after 1 ns;	
	end process;
	
	rst_s <= '0', '1' after 6 ns, '0' after 30 ns;
       

end TEST;



