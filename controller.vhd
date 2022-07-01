library ieee;
use ieee.std_logic_1164.all;

entity controller is
	port( i_inst		: in std_logic_vector(31 downto 0); -- instrução
			o_branch   	: out std_logic;	
			o_MemRead   : out std_logic;
			o_MemToReg  : out std_logic;
			o_ALUop   	: out std_logic;	
			o_MemWrt 	: out std_logic;
			o_ALuScr   	: out std_logic;
			o_RegWrt		: out std_logic;
			o_J			: out std_logic);
end controller;

architecture arqui_controller of controller is
	begin
		process(i_inst)   
		begin
		
			if (i_inst(6 downto 0) = "0010011" ) then	-- opcode para I								
				o_branch   	<= '0';
				o_MemRead   <= '0';
				o_MemToReg  <= '0';	-- tem que ser 0 
				o_ALUop		<= '1';	-- temos uma operação
				o_MemWrt 	<= '0';
				o_ALuScr   	<= '1';  -- tem que ler do imediato extendido
				o_RegWrt		<= '1';	-- manda escrever no registrado do end rd
				o_J			<= '0';
				
			elsif (i_inst(6 downto 0) = "0110011") then -- opcode para instrução R
				o_branch   	<= '0';	
				o_MemRead   <= '0';
				o_MemToReg  <= '0';	
				o_ALUop		<= '1';	-- tem um oepração 
				o_MemWrt 	<= '0';
				o_ALuScr   	<= '0';	-- tem que ser 0 para pegar o rs2
				o_RegWrt		<= '1';	-- escreve o resultado nos registradores 
				o_J			<= '0';
				
			elsif (i_inst(6 downto 0) = "1100011") then -- opcode para instrução B
				o_branch   	<= '1';	
				o_MemRead   <= '0';
				o_MemToReg  <= '0';	
				o_ALUop		<= '1';	-- tem um oepração 
				o_MemWrt 	<= '0';
				o_ALuScr   	<= '0';	-- tem que ser 0 para pegar o rs2
				o_RegWrt		<= '0';
				o_J			<= '0';
				
			elsif (i_inst(6 downto 0) = "1101111") then -- opcode para instrução J
				o_branch   	<= '0';	
				o_MemRead   <= '0';
				o_MemToReg  <= '0';	
				o_ALUop		<= '0';	
				o_MemWrt 	<= '0';
				o_ALuScr   	<= '0';	
				o_RegWrt		<= '0';
				o_J			<= '1';	-- jump
				
			elsif (i_inst(6 downto 0) = "0000011") then -- opcode para instrução LW
				o_branch   	<= '0';	
				o_MemRead   <= '1';	--load word le da memória 
				o_MemToReg  <= '1';	
				o_ALUop		<= '0';	
				o_MemWrt 	<= '0';
				o_ALuScr   	<= '1';	
				o_RegWrt		<= '1';
				o_J			<= '0';		
				
			elsif (i_inst(6 downto 0) = "0100011") then -- opcode para instrução SW
				o_branch   	<= '0';	
				o_MemRead   <= '0';
				o_MemToReg  <= '0';	
				o_ALUop		<= '0';
				o_MemWrt 	<= '1';	--escrita na memória store word
				o_ALuScr   	<= '1';
				o_RegWrt		<= '0';
				o_J			<= '0';
				
			else 
				o_branch   	<= '0';	
				o_MemRead   <= '0';
				o_MemToReg  <= '0';	
				o_ALUop		<= '0';
				o_MemWrt 	<= '0';
				o_ALuScr   	<= '0';
				o_RegWrt		<= '0';
				o_J			<= '0';
			
			end if;
		end process;
end arqui_controller;