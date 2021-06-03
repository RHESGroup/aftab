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
    RAM_DEPTH : integer := 512;
    I_SIZE : integer := 32;
    D_SIZE : integer := 8);
  port (
    Rst  : in  std_logic;
    Addr : in  std_logic_vector(I_SIZE - 1 downto 0);
    Dout : out std_logic_vector(D_SIZE - 1 downto 0)
    );
end aftab_iram;

architecture IRam_Bhe of aftab_iram is

  -- constant app_name : string := "test_add";
  -- constant file_path : string := "../../sw/build/apps/user_apps/" & app_name & "/slm_files/I2_stim.slm";
  constant file_path : string := "./test/asm/test_all/test_all.s.mem";
  
  
  type RAMtype is array (0 to RAM_DEPTH - 1) of std_logic_vector(D_SIZE - 1 downto 0);
  signal IRAM_mem : RAMtype ;
  

begin  -- IRam_Bhe


      Dout <= IRAM_mem(to_integer(unsigned(Addr)));


   FILL_MEM_P: process (Rst)
     file mem_fp: text;
     variable file_line : line;
     variable addr: integer;
     variable index : integer := 0;
     variable tmp_data_u : std_logic_vector(4*D_SIZE-1 downto 0);
     variable good: boolean ;

   begin  -- process FILL_MEM_P
     if (Rst = '0') then
       file_open(mem_fp,file_path,READ_MODE);
       while (not endfile(mem_fp)) loop
         readline(mem_fp,file_line);
         hread(file_line,tmp_data_u);
         --hread(file_line,tmp_data_u); -- This reads an hexadecimal value into a std_logic_vector
         IRAM_mem(index) <= tmp_data_u(D_SIZE - 1 downto 0);       
         IRAM_mem(index+1) <= tmp_data_u(2*D_SIZE - 1 downto D_SIZE);     
         IRAM_mem(index+2) <= tmp_data_u(3*D_SIZE - 1 downto 2*D_SIZE);   
         IRAM_mem(index+3) <= tmp_data_u(4*D_SIZE - 1 downto 3*D_SIZE);   
         index := index + 4;
       end loop;
      
       file_close(mem_fp);
      
      while (index < RAM_DEPTH) loop 
	 	    IRAM_mem(index) <= x"00";
      	index := index + 1;
       end loop;
       index := 0;
      
     end if;
   end process FILL_MEM_P;

end IRam_Bhe;
