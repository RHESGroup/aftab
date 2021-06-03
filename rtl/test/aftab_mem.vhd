LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
use ieee.numeric_std.all;


entity aftab_mem is 
	GENERIC (len : INTEGER := 32;
			 N_bits : integer := 8);
	PORT (
		clk        : IN  STD_LOGIC;
		rst        : IN  STD_LOGIC;
		memReady   : OUT  STD_LOGIC;
		memRead    : IN STD_LOGIC;
		memWrite   : IN STD_LOGIC;
		memDataIN : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		memAddr    : IN STD_LOGIC_VECTOR (len - 1 DOWNTO 0);
		memDataOUT  : OUT  STD_LOGIC_VECTOR (7 DOWNTO 0)
	);
end aftab_mem;



architecture behv of aftab_mem is

		constant BASE_IRAM :  integer := 0;
		constant SIZE_IRAM :  integer := 64;
		constant BASE_DRAM :  integer := 1024;
		constant SIZE_DRAM :  integer := 64;



		component aftab_dram  is
			generic(Address_bits :integer := 32; 
					N_bits: integer := 8;
					N_lines: integer := 64);
			port ( 
					rst: IN std_logic;
					clk: IN std_logic;
					input_data: IN std_logic_vector(N_bits-1 downto 0);
					input_address: 	IN std_logic_vector(31 downto 0);
					read_enable: In std_logic;
					write_enable: in std_logic;
					enable: In  std_logic;
					output_data: out std_logic_vector(N_bits-1 downto 0));
		end component;


		component aftab_iram  is
			generic (
			  RAM_DEPTH : integer := 512;
			  I_SIZE : integer := 32;
			  D_SIZE : integer := 8);
			port (
			  Rst  : in  std_logic;
			  Addr : in  std_logic_vector(I_SIZE - 1 downto 0);
			  Dout : out std_logic_vector(31 downto 0)
			  );
		  end component;


		  signal doutIRAM_s, doutDRAM_s: std_logic_vector(N_bits-1 downto 0);
		  signal addrDRAM_s: std_logic_vector(31 downto 0);

		  begin



			iram_c : aftab_iram port map (Rst=>rst,Addr=>memAddr,Dout=>doutIRAM_s);

			dram_c : aftab_dram port map (rst=>rst,clk=>clk,input_data=>memDataIN,input_address=>addrDRAM_s,read_enable=>memRead,write_enable=>memWrite,enable=>'1',output_data=>doutDRAM_s);


			mux_proc: process(doutIRAM_s,doutDRAM_s,memAddr)

			begin 

				if ( to_integer(unsigned(memAddr)) >= BASE_IRAM and  to_integer(unsigned(memAddr)) < BASE_IRAM + SIZE_IRAM  ) then
					memDataOUT <= doutIRAM_s;
				elsif ( to_integer(unsigned(memAddr)) >= BASE_DRAM and  to_integer(unsigned(memAddr)) < BASE_DRAM + SIZE_DRAM  ) then
					memDataOUT <= doutDRAM_s;
					addrDRAM_s <=  std_logic_vector(unsigned(memAddr) - 1024); 
				end if;
			end process;

end architecture;