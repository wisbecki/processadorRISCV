library ieee;
use ieee.std_logic_1164.all;

entity ula_control is
	port( i_inst		: in std_logic_vector(31 downto 0); -- instrução
			i_ALUop   	: in std_logic;	
			o_control	: out std_logic_vector(3 downto 0));
end ula_control;

architecture arqui_ula_control of ula_control is
	begin
		process(i_inst, i_ALUop)   
		begin
			if (i_ALUop = '1') then -- se temos uma operação na ula 					
				
				if (i_inst(6 downto 0) = "0010011") then  --- I type
				
					if ( i_inst(14 downto 12) = "111") then 	--and ou andi					
						o_control <= "0000";
			
					elsif (i_inst(14 downto 12) = "110") then --or ou ori				
						o_control <= "0001";
					
					elsif (i_inst(14 downto 12) = "000") then --add	ou addi				
						o_control <= "0010";
				
					else
						o_control <= "1111";  --teste 
					end if;
				
				elsif(i_inst(6 downto 0) = "0110011") then -- R type
				
					if ( i_inst(14 downto 12) = "111") then 	--and 					
						o_control <= "0000";
			
					elsif (i_inst(14 downto 12) = "110") then --or 			
						o_control <= "0001";
					
					elsif (i_inst(31 downto 25) = "0100000" and i_inst(14 downto 12) = "000") then --sub não tem subi					
						o_control <= "0110";
						
					elsif (i_inst(14 downto 12) = "000") then --add				
						o_control <= "0010";
				
					else
						o_control <= "1111";  --teste 
					end if;
					
				elsif (i_inst(6 downto 0) = "0000011") then  -- LW
					if (i_inst(14 downto 12) = "010") then --add	do load 			
						o_control <= "0010";
					else
						o_control <= "1111";
					end if;
				else
					o_control <= "1111";
				end if;
				
			else
				o_control <= "1111";
			end if;

		end process;
end arqui_ula_control;