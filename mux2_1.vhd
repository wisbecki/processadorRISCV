library ieee;
use ieee.std_logic_1164.all;

entity mux2_1 is
port (i_sel : in std_logic;
      i_E0	: in std_logic_vector(31 downto 0);
		i_E1	: in std_logic_vector(31 downto 0);
      o_S   : out std_logic_vector(31 downto 0)); 
end mux2_1;

architecture arqui_mux2_1 of mux2_1 is 
begin
	process(i_sel, i_E0, i_E1)
	begin
		case i_sel is 
			when	'0'	=>	o_S	<=	i_E0;   -- talvez tenha que trocar
			when	'1'	=>	o_S	<=	i_E1;
			when others => o_S	<=	i_E0;
		end case;
		
	end process;
end arqui_mux2_1;
