library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memoria_rom is
	generic (addr_width 	: integer := 8; 	-- armazenar instruçoes
				addr_bits 	: integer := 32;	-- numero de bits necessario para endereçar as instruçoes
				data_width 	: integer := 32); -- cada instrução tem uma largura de 32bits
 
	port (i_LD 	: 	in std_logic;
			ende 	:  in std_logic_vector(addr_bits - 1 downto 0);
			dado 	: out std_logic_vector(data_width - 1 downto 0));
 
end memoria_rom;

architecture arch of memoria_rom is
	
	type rom_type is array (0 to addr_width - 1) of std_logic_vector(data_width - 1 downto 0);
	
	signal instruction_rom : rom_type := (	"00000000000000000000010000010011",
														"00000000000100000000010010010011",
														"00000000001000000000100100010011",
														"00000000001100000000100110010011",
														"00000000010000000000101000010011",
														"00000001010010011000010001100011",
														"00000001001001001000010000110011", 
														"01000001001101000000010000110011");
begin					
process(i_LD)
begin
	if (i_LD = '1') then
		dado <= instruction_rom(to_integer(unsigned(ende)));
	end if;
	end process;
end arch;