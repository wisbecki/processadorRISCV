library ieee;
use ieee.std_logic_1164.all;

entity shiftR is
	port( i_E		: in std_logic_vector(31 downto 0); 
			o_s		: out std_logic_vector(31 downto 0));
end shiftR;

architecture arqui_shiftR of shiftR is
	begin
		process(i_E)   
		begin
			o_s(29 downto 0) <= i_E(31 downto 2);
			o_s(31 downto 30) <= "00";	
		end process;
end arqui_shiftR;