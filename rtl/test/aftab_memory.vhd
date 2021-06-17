LIBRARY IEEE;
LIBRARY STD;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;


ENTITY aftab_memory IS
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
END aftab_memory;


ARCHITECTURE behavioral OF aftab_memory IS
	TYPE mem_type IS ARRAY (0 TO blocksize - 1) OF STD_LOGIC_VECTOR (dataWidth-1 DOWNTO 0);

	--Data TYPE for a seqment OF memory
	--Load a segment from a file
	PROCEDURE MemLoad (buffermem : OUT mem_type; fileno : IN  INTEGER) IS
	VARIABLE memline             : LINE;
	VARIABLE offset              : INTEGER := 0;
	VARIABLE err_check           : file_open_status;
	VARIABLE hexcode_v           : STD_LOGIC_VECTOR (dataWidth-1 DOWNTO 0);
    
	FILE f                       : TEXT;
	BEGIN
		buffermem := (OTHERS => (OTHERS => '0'));
		FILE_OPEN (err_check, f,("./test/asm/test_all/test0.hex"),READ_MODE);
		IF err_check = open_ok THEN
			WHILE NOT ENDFILE (f) LOOP
				readline (f, memline);
				HREAD (memline, hexcode_v);
				buffermem (offset) := hexcode_v;
				offset             := offset + 1;
			END LOOP;
			file_close (f);
		END IF;
	END memload;


--Write memory data of a segment to its corresponding file
	PROCEDURE updateFILE (buffermem : IN mem_type; fileno : IN INTEGER) IS
	VARIABLE memline                : line;
	FILE f                          : TEXT OPEN WRITE_MODE IS
	("./test/asm/test_all/mem0.hex");
	BEGIN
	FOR i IN 0 TO blocksize - 1 LOOP
		HWRITE (memline, buffermem (i));
		WRITELINE (f, memline);
	END LOOP;
	FILE_CLOSE (f);
	END updatefile;

signal adr : integer;

BEGIN


RW : PROCESS 
	VARIABLE buffermem   : mem_type := (OTHERS => (OTHERS => '0'));
	VARIABLE ad          : INTEGER;
	VARIABLE memloadedno : INTEGER := 1;
	VARIABLE changemem   : BOOLEAN := false;
	VARIABLE init        : BOOLEAN := true;
BEGIN

	IF (init = true) THEN
		MemLoad (buffermem, 1);
		memloadedno := 1;
		init        := false;
	END IF;

		dataBus <= (OTHERS => 'Z');
        WAIT FOR 1 ns;
		
		IF (readmem = '1') THEN
			memdataready <= '0';
			ad := conv_integer(addressBus);
			IF (ad >= (segmentsno * blocksize)) THEN
				dataBus <= (OTHERS => 'Z');
			ELSE
				IF (memloadedno /= ((ad/blocksize) + 1)) THEN
					MemLoad (buffermem, ((ad/blocksize) + 1));
					changemem   := false;
					memloadedno := (ad/blocksize) + 1;
					dataBus <= buffermem (ad MOD blocksize);
				ELSE
					dataBus <= buffermem (ad MOD blocksize);
				END IF;
			END IF;
		 	WAIT FOR timer;
			memdataready <= '1';
			WAIT FOR cycle;		
			memdataready <= '0';
		ELSIF (writemem = '1') THEN
			memdataready <= '0';
			ad := conv_integer(addressBus);
                       
			IF (ad <= (segmentsno * blocksize)) THEN
				IF (memloadedno = ((ad/blocksize) + 1)) THEN
					changemem := false;
					IF buffermem (ad MOD blocksize) /= dataBus THEN
						changemem := true;
					END IF;
					buffermem (ad MOD blocksize) := dataBus;
					IF changemem = true THEN
						UpdateFILE (buffermem, memloadedno);
						changemem := false;
					END IF;
				ELSE
						memloadedno := (ad/blocksize) + 1;
						MemLoad (buffermem, memloadedno);
						changemem := false;
						IF buffermem (ad MOD blocksize) /= dataBus THEN
							changemem := true;
						END IF;
						buffermem (ad MOD blocksize) := dataBus;
						IF changemem = true THEN
							UpdateFILE (buffermem, memloadedno);
							changemem := false;
						END IF;
					END IF;
				END IF;
		 	WAIT FOR timer;
			memdataready <= '1';
			WAIT FOR cycle;		
			memdataready <= '0';
			END IF;
	WAIT ON writemem, readmem, addressBus;
	END PROCESS;
END behavioral;