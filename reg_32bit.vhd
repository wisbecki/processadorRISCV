library ieee;
use ieee.std_logic_1164.all;

entity reg_32bit is
	port(	i_CLK	: in std_logic;
			i_CLR	: in std_logic;
			i_LD  : in std_logic;											--load do reg]
			i_D   : in std_logic_vector(31 downto 0);  				-- entrada  32 bits
			o_Q   : out std_logic_vector(31 downto 0));				-- saida  32 bits
end reg_32bit;

architecture arqui_reg32bit of reg_32bit is
	begin
	process(i_LD, i_CLK,i_CLR, i_D) 
		begin
			if	(i_CLR = '1') then 
				o_Q <= "00000000000000000000000000000000";            -- clear 
			elsif(rising_edge(i_CLK)) then 
				if (i_LD = '1') then 											--se tivermos uma subida de clock e o load estiver ativo, repassamos os sados 
					o_Q <= i_D;														--repassa os dados 
				end if;
			end if;
	end process;
end arqui_reg32bit;