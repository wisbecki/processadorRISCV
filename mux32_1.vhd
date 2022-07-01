library ieee;
use ieee.std_logic_1164.all;

entity mux32_1 is
port (i_end : in std_logic_vector(4 downto 0); --seletor do mux   
      i_E0	: in std_logic_vector(31 downto 0);
		i_E1	: in std_logic_vector(31 downto 0);
		i_E2	: in std_logic_vector(31 downto 0);
		i_E3	: in std_logic_vector(31 downto 0);
		i_E4	: in std_logic_vector(31 downto 0);
		i_E5	: in std_logic_vector(31 downto 0);
		i_E6	: in std_logic_vector(31 downto 0);
		i_E7	: in std_logic_vector(31 downto 0);
		i_E8	: in std_logic_vector(31 downto 0);
		i_E9	: in std_logic_vector(31 downto 0);
		i_E10	: in std_logic_vector(31 downto 0);
		i_E11	: in std_logic_vector(31 downto 0);
		i_E12	: in std_logic_vector(31 downto 0);
		i_E13	: in std_logic_vector(31 downto 0);
		i_E14	: in std_logic_vector(31 downto 0);
		i_E15	: in std_logic_vector(31 downto 0);
		i_E16	: in std_logic_vector(31 downto 0);
		i_E17	: in std_logic_vector(31 downto 0);
		i_E18	: in std_logic_vector(31 downto 0);
		i_E19	: in std_logic_vector(31 downto 0);
		i_E20	: in std_logic_vector(31 downto 0);
		i_E21	: in std_logic_vector(31 downto 0);
		i_E22	: in std_logic_vector(31 downto 0);
		i_E23	: in std_logic_vector(31 downto 0);
		i_E24	: in std_logic_vector(31 downto 0);
		i_E25	: in std_logic_vector(31 downto 0);
		i_E26	: in std_logic_vector(31 downto 0);
		i_E27	: in std_logic_vector(31 downto 0);
		i_E28	: in std_logic_vector(31 downto 0);
		i_E29	: in std_logic_vector(31 downto 0);
		i_E30	: in std_logic_vector(31 downto 0);
		i_E31	: in std_logic_vector(31 downto 0);
      o_S   : out std_logic_vector(31 downto 0)); 
end mux32_1;

architecture arqui_mux32_1 of mux32_1 is 
begin
	process(i_end, i_E0, i_E1, i_E2, i_E3, i_E4, i_E5, i_E6, i_E7, i_E8, i_E9, i_E10, i_E11, i_E12, i_E13, i_E14, i_E15, i_E16, i_E17, i_E18, i_E19, i_E20, i_E21, i_E22, i_E23, i_E24, i_E25, i_E26, i_E27, i_E28, i_E29, i_E30, i_E31)
	begin
		case i_end is 
			when	"00000"	=>	o_S	<=	i_E0;
			when	"00001"	=>	o_S	<=	i_E1;
			when	"00010"	=>	o_S	<=	i_E2;
			when	"00011"	=>	o_S	<=	i_E3;
			when	"00100"	=>	o_S	<=	i_E4;
			when	"00101"	=>	o_S	<=	i_E5;
			when	"00110"	=>	o_S	<=	i_E6;
			when	"00111"	=>	o_S	<=	i_E7;
			when	"01000"	=>	o_S	<=	i_E8;
			when	"01001"	=>	o_S	<=	i_E9;
			when	"01010"	=>	o_S	<=	i_E10;
			when	"01011"	=>	o_S	<=	i_E11;
			when	"01100"	=>	o_S	<=	i_E12;
			when	"01101"	=>	o_S	<=	i_E13;
			when	"01110"	=>	o_S	<=	i_E14;
			when	"01111"	=>	o_S	<=	i_E15;
			when	"10000"	=>	o_S	<=	i_E16;
			when	"10001"	=>	o_S	<=	i_E17;
			when	"10010"	=>	o_S	<=	i_E18;
			when	"10011"	=>	o_S	<=	i_E19;
			when	"10100"	=>	o_S	<=	i_E20;
			when	"10101"	=>	o_S	<=	i_E21;
			when	"10110"	=>	o_S	<=	i_E22;
			when	"10111"	=>	o_S	<=	i_E23;
			when	"11000"	=>	o_S	<=	i_E24;
			when	"11001"	=>	o_S	<=	i_E25;
			when	"11010"	=>	o_S	<=	i_E26;
			when	"11011"	=>	o_S	<=	i_E27;
			when	"11100"	=>	o_S	<=	i_E28;
			when	"11101"	=>	o_S	<=	i_E29;
			when	"11110"	=>	o_S	<=	i_E30;
			when	"11111"	=>	o_S	<=	i_E31;
			when others => o_S	<=	i_E0;
		end case;
		
	end process;
end arqui_mux32_1;
