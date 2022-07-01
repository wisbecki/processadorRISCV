library ieee;
use ieee.std_logic_1164.all;

entity ext is
	port( i_inst	: in std_logic_vector(31 downto 0); -- instrução
			o_s		: out std_logic_vector(31 downto 0));
end ext;

architecture arqui_ext of ext is
	begin
		process(i_inst)   
		begin
		
			if (i_inst(6 downto 0) = "0010011") then 		-- tipo I
				o_s(11 downto 0) <= i_inst(31 downto 20);
				if(i_inst(31) = '1') then 
					o_s(31 downto 12) <= "11111111111111111111";
				else
					o_s(31 downto 12) <= "00000000000000000000";
				end if;
				
			elsif (i_inst(6 downto 0) = "1100011") then 	-- tipo B
				o_s(0) <= '0';
				o_s(4 downto 1) <= i_inst(11 downto 8);  	-- pirmeira parte do imediato 
				o_s(10 downto 5) <= i_inst(30 downto 25);	-- segunda parte do imediato 
				o_s(11) <= i_inst(31);
				if(i_inst(31) = '1') then 
					o_s(31 downto 12) <= "11111111111111111111";
				else
					o_s(31 downto 12) <= "00000000000000000000";
				end if;
				
				
			elsif (i_inst(6 downto 0) = "1101111") then 	-- tipo J
				o_s(0) <= '0'; --chute
				o_s(10 downto 1) <= i_inst(30 downto 21);  	 
				o_s(11) <= i_inst(20); 
				o_s(19 downto 12) <= i_inst(19 downto 12);  	
				o_s(20) <= i_inst(31);
				
				if(i_inst(31) = '1') then 
					o_s(31 downto 21) <= "11111111111";
				else
					o_s(31 downto 21) <= "00000000000";
				end if;
				
				
				
			elsif (i_inst(6 downto 0) = "0100011") then 	-- tipo S store word 
				o_s(4 downto 0) <= i_inst(11 downto 7);  
				o_s(11 downto 5) <= i_inst(31 downto 25);
				
				if(i_inst(31) = '1') then 
					o_s(31 downto 12) <= "11111111111111111111";
				else
					o_s(31 downto 12) <= "00000000000000000000";
				end if;
			else
				o_s <= "00000000000000000000000000000000";
			end if;
		end process;
end arqui_ext;