library ieee;
use ieee.std_logic_1164.all;

entity demux1_32 is
port (i_end :  in std_logic_vector(4 downto 0); 
      o_S	: out std_logic_vector(31 downto 0)); 
end demux1_32;

architecture arqui_demux1_32 of demux1_32 is
begin
			o_S(0) <= '1' when (i_end = "00000") else '0';
			o_S(1) <= '1' when (i_end = "00001") else '0';
			o_S(2) <= '1' when (i_end = "00010") else '0';
			o_S(3) <= '1' when (i_end = "00011") else '0';
			o_S(4) <= '1' when (i_end = "00100") else '0';
			o_S(5) <= '1' when (i_end = "00101") else '0';
			o_S(6) <= '1' when (i_end = "00110") else '0';
			o_S(7) <= '1' when (i_end = "00111") else '0';
			o_S(8) <= '1' when (i_end = "01000") else '0';
			o_S(9) <= '1' when (i_end = "01001") else '0';
			o_S(10) <= '1' when (i_end = "01010") else '0';
			o_S(11) <= '1' when (i_end = "01011") else '0';
			o_S(12) <= '1' when (i_end = "01100") else '0';
			o_S(13) <= '1' when (i_end = "01101") else '0';
			o_S(14) <= '1' when (i_end = "01110") else '0';
			o_S(15) <= '1' when (i_end = "01111") else '0';
			o_S(16) <= '1' when (i_end = "10000") else '0';
			o_S(17) <= '1' when (i_end = "10001") else '0';
			o_S(18) <= '1' when (i_end = "10010") else '0';
			o_S(19) <= '1' when (i_end = "10011") else '0';
			o_S(20) <= '1' when (i_end = "10100") else '0';
			o_S(21) <= '1' when (i_end = "10101") else '0';
			o_S(22) <= '1' when (i_end = "10110") else '0';
			o_S(23) <= '1' when (i_end = "10111") else '0';
			o_S(24) <= '1' when (i_end = "11000") else '0';
			o_S(25) <= '1' when (i_end = "11001") else '0';
			o_S(26) <= '1' when (i_end = "11010") else '0';
			o_S(27) <= '1' when (i_end = "11011") else '0';
			o_S(28) <= '1' when (i_end = "11100") else '0';
			o_S(29) <= '1' when (i_end = "11101") else '0';
			o_S(30) <= '1' when (i_end = "11110") else '0';
			o_S(31) <= '1' when (i_end = "11111") else '0';
end arqui_demux1_32;

