library ieee;
use ieee.std_logic_1164.all;

entity processador is
	port( i_CLK 		: 	in std_logic; 									
			i_CLR			: 	in std_logic;
			i_LD 			: 	in std_logic);				
end processador;


architecture arqui_processador of processador is
	
	-- memória de instrução
	component memoria_rom2 is 
		port (i_LD 		: 	in std_logic;
				ende 		: in std_logic_vector(31 downto 0);
				dado    	: out std_logic_vector(31 downto 0));	
	end component;
	
	-- pc
	component pc is
		port (i_CLK 	: in std_logic;
				i_D   	: in std_logic_vector(31 downto 0);  				
				o_Q  		 :	 out std_logic_vector(31 downto 0));	
	end component;
	
	-- somador pc
	component somador_pc is
		port (i_E1		: in std_logic_vector(31 downto 0);  		
				o_Q   	: out std_logic_vector(31 downto 0));			
	end component;
	
	-- banco de registradores 
	component banco_reg32bit is 
		port (i_CLK			: 	in std_logic;
				i_CLR			: 	in std_logic;
				i_end_rs1	:  in std_logic_vector(4 downto 0); 
				i_end_rs2	:  in std_logic_vector(4 downto 0); 
				i_end_rd		:  in std_logic_vector(4 downto 0); 
				i_reg_wrt   :  in std_logic;								
				i_D   		:  in std_logic_vector(31 downto 0);
				o_rs1   		: out std_logic_vector(31 downto 0); 	
				o_rs2   		: out std_logic_vector(31 downto 0));	
	end component;
	
	-- extensor de sinal 
	component ext is
		port (i_inst	: in std_logic_vector(31 downto 0); 
				o_s		: out std_logic_vector(31 downto 0));
	end component;
	
	-- multiplexador
	component mux2_1 is 
		port (i_sel : in std_logic;
				i_E0	: in std_logic_vector(31 downto 0);
				i_E1	: in std_logic_vector(31 downto 0);
				o_S   : out std_logic_vector(31 downto 0)); 
	end component;
	
	-- unidade lógica e aritmética 
	component ula is 
		port (i_op  	: in std_logic_vector(3 downto 0);				
				i_E1		: in std_logic_vector(31 downto 0);  			
				i_E2		: in std_logic_vector(31 downto 0);  		
				o_Q   	: out std_logic_vector(31 downto 0);			
				o_z		: out std_logic);										
	end component; 
	
	-- memória
	component memoria is
		generic (addr_width 	: integer := 10; 
					addr_bits 	: integer := 32;	
					data_width 	: integer := 32); 
					
		port(	i_end  		: in std_logic_vector(addr_bits - 1 downto 0);
				i_D			: in std_logic_vector(31 downto 0);  			-- dado
				i_MemRead	: in std_logic;
				i_MemWrt		: in std_logic;
				o_Q   		: out std_logic_vector(data_width - 1 downto 0));
	end component;
	
	-- somador para branch 
	component somador is 
		port( i_E1	: in std_logic_vector(31 downto 0); 
				i_E2	: in std_logic_vector(31 downto 0); 
				o_s	: out std_logic_vector(31 downto 0));
	end component;
	
	-- controlador 
	component controller is 
		port (i_inst		: in std_logic_vector(31 downto 0); 
				o_branch   	: out std_logic;	
				o_MemRead   : out std_logic;
				o_MemToReg  : out std_logic;
				o_ALUop   	: out std_logic;	
				o_MemWrt 	: out std_logic;
				o_ALuScr   	: out std_logic;
				o_RegWrt		: out std_logic;
				o_J			: out std_logic);
	end component;
	
	-- controlador da ula 
	component ula_control is 
		port (i_inst		: in std_logic_vector(31 downto 0); -- instrução
				i_ALUop   	: in std_logic;	
				o_control	: out std_logic_vector(3 downto 0));
	end component;
	
	-- shift right 2 -- divisão por 4 
	component shiftR is 
		port( i_E		: in std_logic_vector(31 downto 0); 
				o_s		: out std_logic_vector(31 downto 0));
	end component;
	
	-- sinais ----------------------------------------------------------
	signal w_RegWrt 	: std_logic; -- escreva nos registradores 
	signal w_ALUscr 	: std_logic; -- sinal de escolha entre imediato ou saída do registrador 
	signal w_ALUop		: std_logic;
	signal w_MemRead	: std_logic; -- flag de escrita na memoria 
	signal w_MemWrt	: std_logic; -- flag de leitura da memória 
	signal w_MemToReg	: std_logic; -- sinal de leitura da memória para o registrador
	signal w_Branch	: std_logic; -- sinal de controle para saltos
	signal w_J			: std_logic; -- jump
	signal w_sel_j		: std_logic; -- sinal de controle para mul do pc
	signal w_z		 	: std_logic; -- zero flag 
	
	-- endereço da memória de instrução vem do pc 
	signal w_s_pc, w_s_pc4 	: std_logic_vector(31 downto 0); 		-- saída do pc
	signal w_e_pc 			: std_logic_vector(31 downto 0);			-- entrada do pc
	signal w_inst 			: std_logic_vector(31 downto 0);			-- a propria instrução saindo da memória 
	signal w_s_ext 		: std_logic_vector(31 downto 0);			-- saida do extensor de sinal 
	signal w_rs1, w_rs2 	: std_logic_vector(31 downto 0);			-- reg rs1 e reg rs2
	signal w_e2ULA 		: std_logic_vector(31 downto 0);			-- saída do multiplexador entrada 2 da ula
	signal w_opULA 		: std_logic_vector(3 downto 0);			-- seletor de opção da operação da ula 
	signal w_s_ula			: std_logic_vector(31 downto 0);			-- saída do multiplexador entrada 2 da ula
	signal w_s_mem			: std_logic_vector(31 downto 0);			-- saida da memoria 
	signal w_WrtBck		: std_logic_vector(31 downto 0);			-- dado voltando para os registradores 
	signal w_s_soma		: std_logic_vector(31 downto 0);			-- saida da soma do branch 
	signal w_s_j			: std_logic_vector(31 downto 0);			-- saida somador do jump
	signal w_s_b			: std_logic_vector(31 downto 0);			-- saida mux branch
	signal w_s_sr			: std_logic_vector(31 downto 0);			-- saida do shift right 
	signal w_s_srJ			: std_logic_vector(31 downto 0);			-- saida do shift right dp jump
	
	begin 
	
	u1_rom			:	memoria_rom2	port map(i_LD			=> i_LD,
															ende			=>	w_s_pc,
															dado			=>	w_inst);		
		
	u2_pc				:	pc 				port map(i_CLK			=> i_CLK,
															i_D   		=> w_e_pc,  				
															o_Q  			=> w_s_pc);	
	
	u3_som_pc		:	somador_pc		port map(i_E1			=> w_s_pc,  	  		
															o_Q   		=> w_s_pc4);
	
	u4_banco 		: 	banco_reg32bit	port map(i_CLK			=> i_CLK,
															i_CLR			=> i_CLR,
															i_end_rs1	=>	w_inst(19 downto 15), 
															i_end_rs2	=>	w_inst(24 downto 20),
															i_end_rd		=>	w_inst(11 downto 7),  
															i_reg_wrt 	=> w_RegWrt, 
															i_D   		=>	w_WrtBck,
															o_rs1  		=> w_rs1,		
															o_rs2   		=> w_rs2);		
	
	u5_ext			: 	ext				port map(i_inst		=>	w_inst,
															o_s			=>	w_s_ext);
	
	u6_muxEula		:	mux2_1			port map(i_sel 		=> w_ALUscr,
															i_E0			=> w_rs2,
															i_E1			=> w_s_ext,
															o_S   		=> w_e2ULA);
															
	u7_ula			: ula 				port map(i_op 			=> w_opULA,
															i_E1			=> w_rs1,
															i_E2			=> w_e2ULA,
															o_Q   		=> w_s_ula, 
															o_z			=> w_z);	
															
	u8_mem			:  memoria	 		port map(i_end 		=>	w_s_ula, 
															i_D			=>	w_rs2, 
															i_MemRead   =>	w_MemRead,	
															i_MemWrt   	=>	w_MemWrt,
															o_Q   		=> w_s_mem);	
	
	u9_MUXsMEM		:	mux2_1			port map(i_sel 		=> w_MemToReg,
															i_E0			=> w_s_ula,
															i_E1			=> w_s_mem,
															o_S   		=> w_WrtBck);	
							
	u10_som			: somador			port map(i_E1			=> w_s_pc,
															i_E2			=> w_s_sr,
															o_s			=> w_s_soma);
															
	u11_mux_pc		:	mux2_1			port map(i_sel 		=> w_sel_j,
															i_E0			=> w_s_pc4,
															i_E1			=> w_s_soma,
															o_S   		=> w_s_b);
	
	u12_control		: controller 		port map(i_inst		=> w_inst,
															o_branch   	=> w_Branch,	
															o_MemRead  	=> w_MemRead,
															o_MemToReg  => w_MemToReg,
															o_ALUop   	=> w_ALUop,
															o_MemWrt 	=> w_MemWrt,
															o_ALuScr   	=> w_ALUscr,
															o_RegWrt		=> w_RegWrt,
															o_J			=> w_J);
															
	u13_ula_control	: ula_control	port map(i_inst		=> w_inst,
															i_ALUop  	=> w_ALUop,	
															o_control	=> w_opULA);													
															
	u14_som_jump		: somador		port map(i_E1			=> w_s_srJ,
															i_E2			=> w_s_pc,
															o_s			=> w_s_j);
															
	u15_mux_jump		:	mux2_1		port map(i_sel 		=> w_J,
															i_E0			=> w_s_b,
															i_E1			=> w_s_j,
															o_S   		=> w_e_pc);
	
	u16_srB				:	shiftR		port map(i_E			=> w_s_ext,
															o_s   		=> w_s_sr);

	u17_srJ				:	shiftR		port map(i_E			=> w_s_ext,
															o_s   		=> w_s_srJ);
	w_sel_j <= w_z and w_Branch;
	
end arqui_processador;