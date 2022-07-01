library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity memoria is
	generic (addr_width 	: integer := 10; 	-- quantidade de locais na memória 
				addr_bits 	: integer := 32;	-- numero de bits necessario para endereçar os
				data_width 	: integer := 32); -- cada dado tem uma largura de 32bits
				
				
	port(	i_end  		: in std_logic_vector(addr_bits - 1 downto 0);
			i_D			: in std_logic_vector(31 downto 0);  			-- dado
			i_MemRead	: in std_logic;
			i_MemWrt		: in std_logic;
			o_Q   		: out std_logic_vector(data_width - 1 downto 0));
end memoria;

architecture arqui_memoria of memoria is

	type rom_type is array (0 to addr_width - 1) of std_logic_vector(data_width - 1 downto 0);
	
	signal instruction_rom : rom_type := (	"00000000000000000000000000000000",
														"00000000000000000000000000000000",
														"00000000000000000000000000000000",
														"00000000000000000000000000000000",
														"00000000000000000000000000000000",
														"00000000000000000000000000000000",
														"00000000000000000000000000000000",
														"00000000000000000000000000000000",
														"00000000000000000000000000000000",
														"00000000000000000000000000000000");
begin 
process(i_MemWrt, i_MemRead, i_D, i_end, instruction_rom)
begin

	if (i_MemRead = '1') then 
		o_Q <= instruction_rom(to_integer(unsigned(i_end)));
	elsif (i_MemWrt = '1') then 
		instruction_rom(to_integer(unsigned(i_end))) <= i_D;
		o_Q <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
	else
		o_Q <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
	end if;
	end process;
end arqui_memoria;