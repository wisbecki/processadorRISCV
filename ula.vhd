library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;  -- biblioteca para facilitar as operações

entity ula is
	port(	i_op  	: in std_logic_vector(3 downto 0);				--	code da operação desejada
			i_E1		: in std_logic_vector(31 downto 0);  			-- entrada1  32 bits
			i_E2		: in std_logic_vector(31 downto 0);  			-- entrada2  32 bits
			o_Q   	: out std_logic_vector(31 downto 0);			-- saida  32 bits
			o_z		: out std_logic);										-- falg zero
end ula;

architecture arqui_ula of ula is
	signal w_s		: std_logic_vector(31 downto 0);
	begin
		process(w_s, i_op, i_E1, i_E2)
		begin 
		o_z <= '0';
			if (i_op = "0000") then 	--and					
				w_s <= i_E1 and i_E2;
				o_Q <= w_s; 
				if(w_s = "00000000000000000000000000000000") then 
					o_z <= '1';
				end if;
		
			elsif (i_op = "0001") then --or						
				w_s <= i_E1 or i_E2;	
				o_Q <= w_s;
				if(w_s = "00000000000000000000000000000000") then 
					o_z <= '1';
				end if;
			
			elsif (i_op = "0010") then --add						
				w_s <= i_E1 + i_E2;	
				o_Q <= w_s;
				if(w_s = "00000000000000000000000000000000") then 
					o_z <= '1';
				end if;
			
			elsif (i_op = "0110") then --sub					
				w_s <= i_E1 - i_E2;	
				o_Q <= w_s;
				if(w_s = "00000000000000000000000000000000") then 
					o_z <= '1';
				end if;
			
			else
				w_s <= "00000000000000000000000000000000";
				o_Q <= "00000000000000000000000000000000";
				o_z <= '0';
			end if;
	end process;
end arqui_ula;