library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;  

entity somador_pc is
	port(	i_E1		: in std_logic_vector(31 downto 0);  		
			o_Q   	: out std_logic_vector(31 downto 0));			
end somador_pc;

architecture arqui_somador_pc of somador_pc is
	begin
		process(i_E1)
		begin 
			if(i_E1 = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX") then
				o_Q	<=	"00000000000000000000000000000000";
			else
				o_Q	<=	i_E1 + "00000000000000000000000000000001"; 	-- memória não é indexada em nivel de byte 
			end if;
		end process;
end arqui_somador_pc;