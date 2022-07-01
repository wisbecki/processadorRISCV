library ieee;
use ieee.std_logic_1164.all;

entity banco_reg32bit is
	port(	i_CLK			: 	in std_logic;
			i_CLR			: 	in std_logic;
			i_end_rs1	:  in std_logic_vector(4 downto 0); --rs1	leitura 
			i_end_rs2	:  in std_logic_vector(4 downto 0); --rs2
			i_end_rd		:  in std_logic_vector(4 downto 0); --rd registrador de escrita destino
			i_reg_wrt   :  in std_logic;								-- load para escrever nos registradores 
			i_D   		:  in std_logic_vector(31 downto 0);  -- entrada  32 bits
			o_rs1   		: out std_logic_vector(31 downto 0); 	-- saida  32 bits rs1
			o_rs2   		: out std_logic_vector(31 downto 0));	-- saida  32 bits rs2
end banco_reg32bit;


architecture arqui_bancoreg of banco_reg32bit is

	component reg_32bit is
		port( i_CLK	: in std_logic;
				i_CLR	: in std_logic;
				i_LD  : in std_logic;
				i_D  	: in std_logic_vector(31 downto 0);  
				o_Q   : out std_logic_vector(31 downto 0));
	end component;
	
	component demux1_32 is
		port (i_end : in std_logic_vector(4 downto 0); 
				o_S	: out std_logic_vector(31 downto 0)); 
	end component;
	
	component mux32_1 is
		port (i_end : in std_logic_vector(4 downto 0);  
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
	end component;
	
	
	--sinal de saída dos registradores 
	signal w_Sreg_0, w_Sreg_1, w_Sreg_2, w_Sreg_3, w_Sreg_4, w_Sreg_5, w_Sreg_6, w_Sreg_7, w_Sreg_8, w_Sreg_9, w_Sreg_10, w_Sreg_11, w_Sreg_12, w_Sreg_13, w_Sreg_14, w_Sreg_15, w_Sreg_16, w_Sreg_17, w_Sreg_18, w_Sreg_19, w_Sreg_20, w_Sreg_21, w_Sreg_22, w_Sreg_23, w_Sreg_24, w_Sreg_25, w_Sreg_26, w_Sreg_27, w_Sreg_28, w_Sreg_29, w_Sreg_30, w_Sreg_31	: std_logic_vector(31 downto 0);
	
	-- sinal saída do demux
	signal w_S_demux 	: std_logic_vector(31 downto 0);

	--sinal para and com o write reg
	signal w_S1, w_S2, w_S3, w_S4, w_S5, w_S6, w_S7, w_S8, w_S9, w_S10, w_S11, w_S12, w_S13, w_S14, w_S15, w_S16, w_S17, w_S18, w_S19, w_S20, w_S21, w_S22, w_S23, w_S24, w_S25, w_S26, w_S27, w_S28, w_S29, w_S30, w_S31	:	std_logic;
	
	--sinal para criar os ands
	signal w_or0, w_or1, w_or2, w_or3, w_or4, w_or5, w_or6, w_or7, w_or8, w_or9, w_or10, w_or11, w_or12, w_or13, w_or14, w_or15, w_or16, w_or17, w_or18, w_or19, w_or20, w_or21, w_or22, w_or23, w_or24, w_or25, w_or26, w_or27, w_or28, w_or29, w_or30, w_or31 : std_logic;
	
	begin 
	
		-- demux do endereço de destino rd
		u_demux_b :  demux1_32 	port map(i_end => i_end_rd, 
													o_S	=>	w_S_demux);
		
		
		
		u_mux_rs1	:	mux32_1		port map(i_end => i_end_rs1,  
														i_E0	=>	w_Sreg_0,
														i_E1	=>	w_Sreg_1,
														i_E2	=>	w_Sreg_2,
														i_E3	=>	w_Sreg_3,
														i_E4	=>	w_Sreg_4,
														i_E5	=>	w_Sreg_5,
														i_E6	=>	w_Sreg_6,
														i_E7	=>	w_Sreg_7,
														i_E8	=>	w_Sreg_8,
														i_E9	=>	w_Sreg_9,
														i_E10	=>	w_Sreg_10,
														i_E11	=>	w_Sreg_11,
														i_E12	=>	w_Sreg_12,
														i_E13	=>	w_Sreg_13,
														i_E14	=>	w_Sreg_14,
														i_E15	=>	w_Sreg_15,
														i_E16	=>	w_Sreg_16,
														i_E17	=>	w_Sreg_17,
														i_E18	=>	w_Sreg_18,
														i_E19	=>	w_Sreg_19,
														i_E20	=>	w_Sreg_20,
														i_E21	=>	w_Sreg_21,
														i_E22	=>	w_Sreg_22,
														i_E23	=>	w_Sreg_23,
														i_E24	=>	w_Sreg_24,
														i_E25	=>	w_Sreg_25,
														i_E26	=>	w_Sreg_26,
														i_E27	=>	w_Sreg_27,
														i_E28	=>	w_Sreg_28,
														i_E29	=>	w_Sreg_29,
														i_E30	=>	w_Sreg_30,
														i_E31	=>	w_Sreg_31,
														o_S  	=> o_rs1); 
														
			u_mux_rs2	:	mux32_1		port map(i_end => i_end_rs2,  
														i_E0	=>	w_Sreg_0,
														i_E1	=>	w_Sreg_1,
														i_E2	=>	w_Sreg_2,
														i_E3	=>	w_Sreg_3,
														i_E4	=>	w_Sreg_4,
														i_E5	=>	w_Sreg_5,
														i_E6	=>	w_Sreg_6,
														i_E7	=>	w_Sreg_7,
														i_E8	=>	w_Sreg_8,
														i_E9	=>	w_Sreg_9,
														i_E10	=>	w_Sreg_10,
														i_E11	=>	w_Sreg_11,
														i_E12	=>	w_Sreg_12,
														i_E13	=>	w_Sreg_13,
														i_E14	=>	w_Sreg_14,
														i_E15	=>	w_Sreg_15,
														i_E16	=>	w_Sreg_16,
														i_E17	=>	w_Sreg_17,
														i_E18	=>	w_Sreg_18,
														i_E19	=>	w_Sreg_19,
														i_E20	=>	w_Sreg_20,
														i_E21	=>	w_Sreg_21,
														i_E22	=>	w_Sreg_22,
														i_E23	=>	w_Sreg_23,
														i_E24	=>	w_Sreg_24,
														i_E25	=>	w_Sreg_25,
														i_E26	=>	w_Sreg_26,
														i_E27	=>	w_Sreg_27,
														i_E28	=>	w_Sreg_28,
														i_E29	=>	w_Sreg_29,
														i_E30	=>	w_Sreg_30,
														i_E31	=>	w_Sreg_31,
														o_S  	=> o_rs2); 
		
		
			
			
			-- and entre write reg e saida do demux
		--w_S0	<=	w_S_demux(0)	and 	i_reg_wrt;
		w_S1	<=	w_S_demux(1)	and 	i_reg_wrt;
		w_S2	<=	w_S_demux(2)	and 	i_reg_wrt;
		w_S3	<=	w_S_demux(3)	and 	i_reg_wrt;
		w_S4	<=	w_S_demux(4)	and 	i_reg_wrt;
		w_S5	<=	w_S_demux(5)	and 	i_reg_wrt;
		w_S6	<=	w_S_demux(6)	and 	i_reg_wrt;
		w_S7	<=	w_S_demux(7)	and 	i_reg_wrt;
		w_S8	<=	w_S_demux(8)	and 	i_reg_wrt;
		w_S9	<=	w_S_demux(9)	and 	i_reg_wrt;
		w_S10	<=	w_S_demux(10)	and 	i_reg_wrt;
		w_S11	<=	w_S_demux(11)	and 	i_reg_wrt;
		w_S12	<=	w_S_demux(12)	and 	i_reg_wrt;
		w_S13	<=	w_S_demux(13)	and 	i_reg_wrt;
		w_S14	<=	w_S_demux(14)	and 	i_reg_wrt;
		w_S15	<=	w_S_demux(15)	and 	i_reg_wrt;
		w_S16	<=	w_S_demux(16)	and 	i_reg_wrt;
		w_S17	<=	w_S_demux(17)	and 	i_reg_wrt;
		w_S18	<=	w_S_demux(18)	and 	i_reg_wrt;
		w_S19	<=	w_S_demux(19)	and 	i_reg_wrt;
		w_S20	<=	w_S_demux(20)	and 	i_reg_wrt;
		w_S21	<=	w_S_demux(21)	and 	i_reg_wrt;
		w_S22	<=	w_S_demux(22)	and 	i_reg_wrt;
		w_S23	<=	w_S_demux(23)	and 	i_reg_wrt;
		w_S24	<=	w_S_demux(24)	and 	i_reg_wrt;
		w_S25	<=	w_S_demux(25)	and 	i_reg_wrt;
		w_S26	<=	w_S_demux(26)	and 	i_reg_wrt;
		w_S27	<=	w_S_demux(27)	and 	i_reg_wrt;
		w_S28	<=	w_S_demux(28)	and 	i_reg_wrt;
		w_S29	<=	w_S_demux(29)	and 	i_reg_wrt;
		w_S30	<=	w_S_demux(30)	and 	i_reg_wrt;
		w_S31	<=	w_S_demux(31)	and 	i_reg_wrt;



			
		--retirar clear de todos os regs
		u_reg32_0	:	reg_32bit 	port map(i_CLK => i_CLK,
														i_CLR => i_CLR,
														i_LD  => '1',
														i_D   => "00000000000000000000000000000000",
														o_Q   => w_Sreg_0);
		
		u_reg32_1	:	reg_32bit 	port map(i_CLK => i_CLK,
														i_CLR => i_CLR,
														i_LD  => w_S1,
														i_D   => i_D,
														o_Q   => w_Sreg_1);
		
		u_reg32_2	:	reg_32bit 	port map(i_CLK => i_CLK,
														i_CLR => i_CLR,
														i_LD  => w_S2,
														i_D   => i_D,
														o_Q   => w_Sreg_2);
		
		u_reg32_3	:	reg_32bit 	port map(i_CLK => i_CLK,
														i_CLR => i_CLR,
														i_LD  => w_S3,
														i_D   => i_D,
														o_Q   => w_Sreg_3);
		
		u_reg32_4	:	reg_32bit 	port map(i_CLK => i_CLK,
														i_CLR => i_CLR,
														i_LD  => w_S4,
														i_D   => i_D,
														o_Q   => w_Sreg_4);
		
		u_reg32_5	:	reg_32bit 	port map(i_CLK => i_CLK,
														i_CLR => i_CLR,
														i_LD  => w_S5,
														i_D   => i_D,
														o_Q   => w_Sreg_5);
		
		u_reg32_6	:	reg_32bit 	port map(i_CLK => i_CLK,
														i_CLR => i_CLR,
														i_LD  => w_S6,
														i_D   => i_D,
														o_Q   => w_Sreg_6);
		
		u_reg32_7	:	reg_32bit 	port map(i_CLK => i_CLK,
														i_CLR => i_CLR,
														i_LD  => w_S7,
														i_D   => i_D,
														o_Q   => w_Sreg_7);
		
		u_reg32_8	:	reg_32bit 	port map(i_CLK => i_CLK,
														i_CLR => i_CLR,
														i_LD  => w_S8,
														i_D   => i_D,
														o_Q   => w_Sreg_8);
		
		u_reg32_9	:	reg_32bit 	port map(i_CLK => i_CLK,
														i_CLR => i_CLR,
														i_LD  => w_S9,
														i_D   => i_D,
														o_Q   => w_Sreg_9);
		
		u_reg32_10	:	reg_32bit 	port map(i_CLK => i_CLK,
														i_CLR => i_CLR,
														i_LD  => w_S10,
														i_D   => i_D,
														o_Q   => w_Sreg_10);
		
		u_reg32_11	:	reg_32bit 	port map(i_CLK => i_CLK,
														i_CLR => i_CLR,
														i_LD  => w_S11,
														i_D   => i_D,
														o_Q   => w_Sreg_11);
		
		u_reg32_12	:	reg_32bit 	port map(i_CLK => i_CLK,
														i_CLR => i_CLR,
														i_LD  => w_S12,
														i_D   => i_D,
														o_Q   => w_Sreg_12);
		
		u_reg32_13	:	reg_32bit 	port map(i_CLK => i_CLK,
														i_CLR => i_CLR,
														i_LD  => w_S13,
														i_D   => i_D,
														o_Q   => w_Sreg_13);
														
		u_reg32_14	:	reg_32bit 	port map(i_CLK => i_CLK,
														i_CLR => i_CLR,
														i_LD  => w_S14,
														i_D   => i_D,
														o_Q   => w_Sreg_14);
		
		u_reg32_15	:	reg_32bit 	port map(i_CLK => i_CLK,
														i_CLR => i_CLR,
														i_LD  => w_S15,
														i_D   => i_D,
														o_Q   => w_Sreg_15);
		
		u_reg32_16	:	reg_32bit 	port map(i_CLK => i_CLK,
														i_CLR => i_CLR,
														i_LD  => w_S16,
														i_D   => i_D,
														o_Q   => w_Sreg_16);
		
		u_reg32_17	:	reg_32bit 	port map(i_CLK => i_CLK,
														i_CLR => i_CLR,
														i_LD  => w_S17,
														i_D   => i_D,
														o_Q   => w_Sreg_17);
		
		u_reg32_18	:	reg_32bit 	port map(i_CLK => i_CLK,
														i_CLR => i_CLR,
														i_LD  => w_S18,
														i_D   => i_D,
														o_Q   => w_Sreg_18);
		
		u_reg32_19	:	reg_32bit 	port map(i_CLK => i_CLK,
														i_CLR => i_CLR,
														i_LD  => w_S19,
														i_D   => i_D,
														o_Q   => w_Sreg_19);
		
		u_reg32_20	:	reg_32bit 	port map(i_CLK => i_CLK,
														i_CLR => i_CLR,
														i_LD  => w_S20,
														i_D   => i_D,
														o_Q   => w_Sreg_20);
		
		u_reg32_21	:	reg_32bit 	port map(i_CLK => i_CLK,
														i_CLR => i_CLR,
														i_LD  => w_S21,
														i_D   => i_D,
														o_Q   => w_Sreg_21);
		
		u_reg32_22	:	reg_32bit 	port map(i_CLK => i_CLK,
														i_CLR => i_CLR,
														i_LD  => w_S22,
														i_D   => i_D,
														o_Q   => w_Sreg_22);
		
		u_reg32_23	:	reg_32bit 	port map(i_CLK => i_CLK,
														i_CLR => i_CLR,
														i_LD  => w_S23,
														i_D   => i_D,
														o_Q   => w_Sreg_23);
		
		u_reg32_24	:	reg_32bit 	port map(i_CLK => i_CLK,
														i_CLR => i_CLR,
														i_LD  => w_S24,
														i_D   => i_D,
														o_Q   => w_Sreg_24);
		
		u_reg32_25	:	reg_32bit 	port map(i_CLK => i_CLK,
														i_CLR => i_CLR,
														i_LD  => w_S25,
														i_D   => i_D,
														o_Q   => w_Sreg_25);
		
		u_reg32_26	:	reg_32bit 	port map(i_CLK => i_CLK,
														i_CLR => i_CLR,
														i_LD  => w_S26,
														i_D   => i_D,
														o_Q   => w_Sreg_26);
		
		u_reg32_27	:	reg_32bit 	port map(i_CLK => i_CLK,
														i_CLR => i_CLR,
														i_LD  => w_S27,
														i_D   => i_D,
														o_Q   => w_Sreg_27);
		
		u_reg32_28	:	reg_32bit 	port map(i_CLK => i_CLK,
														i_CLR => i_CLR,
														i_LD  => w_S28,
														i_D   => i_D,
														o_Q   => w_Sreg_28);
		
		u_reg32_29	:	reg_32bit 	port map(i_CLK => i_CLK,
														i_CLR => i_CLR,
														i_LD  => w_S29,
														i_D   => i_D,
														o_Q   => w_Sreg_29);
		
		u_reg32_30	:	reg_32bit 	port map(i_CLK => i_CLK,
														i_CLR => i_CLR,
														i_LD  => w_S30,
														i_D   => i_D,
														o_Q   => w_Sreg_30);
		
		u_reg32_31	:	reg_32bit 	port map(i_CLK => i_CLK,
														i_CLR => i_CLR,
														i_LD  => w_S31,
														i_D   => i_D,
														o_Q   => w_Sreg_31);


		
end arqui_bancoreg;