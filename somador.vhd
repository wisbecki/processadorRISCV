library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;  

entity somador is
	port( i_E1	: in std_logic_vector(31 downto 0); 
			i_E2	: in std_logic_vector(31 downto 0); 
			o_s	: out std_logic_vector(31 downto 0));
end somador;

architecture arqui_somador of somador is
	begin
		process(i_E1, i_E2)   
		begin
			o_s <= i_E1 + i_E2;
		end process;
end arqui_somador;