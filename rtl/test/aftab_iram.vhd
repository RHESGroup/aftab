library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use ieee.numeric_std.all;


-- Instruction memory for DLX
-- Memory filled by a process which reads from a file
-- file name is "test.asm.mem"
entity aftab_iram  is
  generic (
    RAM_DEPTH : integer := 48;
    I_SIZE : integer := 32;
    D_SIZE : integer := 8);
  port (
    Rst  : in  std_logic;
    Addr : in  std_logic_vector(I_SIZE - 1 downto 0);
    Dout : out std_logic_vector(D_SIZE - 1 downto 0)
    );
end aftab_iram;

architecture IRam_Bhe of aftab_iram is

  constant file_name : string := "mem/test_hazard.asm.mem";
  
  type RAMtype is array (0 to RAM_DEPTH - 1) of std_logic_vector(D_SIZE - 1 downto 0);
  signal IRAM_mem : RAMtype;
  

begin  -- IRam_Bhe

  Dout <= IRAM_mem(to_integer(unsigned(Addr)));

  FILL_MEM_P: process( Rst)

  begin

    for i in 0 to RAM_DEPTH-1  loop
      IRAM_mem(i) <= std_logic_vector(to_unsigned(i, D_SIZE));
    end loop; -- <name>

  end process;

  -- FILL_MEM_P: process (Rst)
  --   file mem_fp: text;
  --   variable file_line : line;
  --   variable index : integer := 0;
  --   variable tmp_data_u : std_logic_vector(I_SIZE-1 downto 0);
  -- begin  -- process FILL_MEM_P
  --   if (Rst = '0') then
  --     file_open(mem_fp,file_name,READ_MODE);
  --     while (not endfile(mem_fp)) loop
  --       readline(mem_fp,file_line);
  --       hread(file_line,tmp_data_u); -- This reads an hexadecimal value into a std_logic_vector
  --       IRAM_mem(index) <= tmp_data_u;       
  --       index := index + 1;
  --     end loop;
      
  --     file_close(mem_fp);
      
  --    while (index < RAM_DEPTH) loop 
	-- 	IRAM_mem(index) <= x"00000000";
  --    	index := index + 1;
  --     end loop;
  --     index := 0;
      
  --   end if;
  -- end process FILL_MEM_P;

end IRam_Bhe;
