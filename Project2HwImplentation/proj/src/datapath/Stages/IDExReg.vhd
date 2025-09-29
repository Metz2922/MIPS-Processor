-------------------------------------------------------------------------
-- Kaden Berger
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- IDExReg.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of the ID/Ex Register
--
--
-- NOTES:
-- 11/6/24 by Kaden::Design Created
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity IDExReg is
	port(i_CLK  	 : in std_logic;
	     i_RST       : in std_logic;
	     i_WE        : in std_logic;

	     i_Sign 	 : in std_logic;
	     o_sign      : out std_logic;
	     i_RS 	 : in std_logic_vector(31 downto 0);
	     i_RT 	 : in std_logic_vector(31 downto 0);
	     o_RS 	 : out std_logic_vector(31 downto 0);
	     o_RT	 : out std_logic_vector(31 downto 0);
	     i_Instr     : in std_logic_vector(31 downto 0);
	     o_Instr  	 : out std_logic_vector(31 downto 0);
	     i_jrbit 	 : in std_logic;
	     o_jrbit     : out std_logic;
	     i_EXTIMM	 : in std_logic_vector(31 downto 0);
	     o_EXTIMM	 : out std_logic_vector(31 downto 0);
	     ALUSrcIn	 : in std_logic;
	     ALUCTRLIn	 : in std_logic_vector(6 downto 0);
	     RegDstIn    : in std_logic;
	     MemWrIn     : in std_logic;
	     MemReadIn   : in std_logic;
	     BranchIn    : in std_logic;
	     BNEIn       : in std_logic;
	     JumpIn      : in std_logic;
	     JALIn       : in std_logic;
	     MemtoRegIn  : in std_logic;
	     RegWrIn     : in std_logic;
	     HaltIn      : in std_logic;
	     ALUSrcOut   : out std_logic;
	     ALUCTRLOut  : out std_logic_vector(6 downto 0);
	     RegDstOut   : out std_logic;
	     MemWrOut    : out std_logic;
	     MemReadOut  : out std_logic;
	     BranchOut   : out std_logic;
	     BNEOut      : out std_logic;
	     JumpOut     : out std_logic;
	     JALOut      : Out std_logic;
	     MemtoRegOut : out std_logic;
	     RegWrOut    : out std_logic;
	     Haltout     : out std_logic;
		 PCADDER1_IN	: IN STD_LOGIC_VECTOR(31 downto 0);
		 PCADDER1_OUT	: OUT STD_LOGIC_VECTOR(31 downto 0);
	     WBAddrIn    : in std_logic_vector(4 downto 0);
	     WBAddrOut   : out std_logic_vector(4 downto 0));
end IDExReg;

architecture structural of IDExReg is

component nRegister is
	generic(N: integer := 32);
	port(i_CLK	: in std_logic;
		i_RST	: in std_logic;
		i_WE	: in std_logic;
		i_D	: in std_logic_vector(N-1 downto 0);
		o_Q	: out std_logic_vector(N-1 downto 0));
end component;

component dffg is
port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE         : in std_logic;     -- Write enable input
       i_D          : in std_logic;     -- Data value input
       o_Q          : out std_logic);   -- Data value output
end component;

begin

	ALUSrc: dffg
	port map(i_CLK  => i_CLK,
		i_RST	=> i_RST,
		i_WE	=> i_WE,
		i_D	=> ALUSrcIn,
		o_Q	=> AluSrcOut);

	ALUCTRL : nRegister
	generic map(N  => 7)
	port map(i_CLK  => i_CLK,
		i_RST	=> i_RST,
		i_WE	=> i_WE,
		i_D	=> ALUCTRLin,
		o_Q	=> ALUCTRLOut);

	RegDst : dffg
	port map(i_CLK  => i_CLK,
		i_RST	=> i_RST,
		i_WE	=> i_WE,
		i_D	=> RegDstIn,
		o_Q	=> RegDstOut);

	MemWr : dffg
	port map(i_CLK  => i_CLK,
		i_RST	=> i_RST,
		i_WE	=> i_WE,
		i_D	=> MemWrIn,
		o_Q	=> MemWrOut);

	MemRead : dffg
	port map(i_CLK  => i_CLK,
		i_RST	=> i_RST,
		i_WE	=> i_WE,
		i_D	=> MemReadIn,
		o_Q	=> MemReadOut);

	Branch : dffg
	port map(i_CLK  => i_CLK,
		i_RST	=> i_RST,
		i_WE	=> i_WE,
		i_D	=> BranchIn,
		o_Q	=> BranchOut);

	BNE : dffg
	port map(i_CLK  => i_CLK,
		i_RST	=> i_RST,
		i_WE	=> i_WE,
		i_D	=> BNEIn,
		o_Q	=> BNEOut);

	Jump : dffg
	port map(i_CLK  => i_CLK,
		i_RST	=> i_RST,
		i_WE	=> i_WE,
		i_D	=> JumpIn,
		o_Q	=> JumpOut);

	JAL : dffg
	port map(i_CLK  => i_CLK,
		i_RST	=> i_RST,
		i_WE	=> i_WE,
		i_D	=> JALIn,
		o_Q	=> JALOut);

	MemtoReg : dffg
	port map(i_CLK  => i_CLK,
		i_RST	=> i_RST,
		i_WE	=> i_WE,
		i_D	=> MemtoRegIn,
		o_Q	=> MemtoRegOut);

	RegWr : dffg
	port map(i_CLK  => i_CLK,
		i_RST	=> i_RST,
		i_WE	=> i_WE,
		i_D	=> RegWrIn,
		o_Q	=> RegWrOut);

	Halt : dffg
	port map(i_CLK  => i_CLK,
		i_RST	=> i_RST,
		i_WE	=> i_WE,
		i_D	=> HaltIn,
		o_Q	=> HaltOut);

	Sign : dffg
	port map(i_CLK  => i_CLK,
		i_RST	=> i_RST,
		i_WE	=> i_WE,
		i_D	=> i_Sign,
		o_Q	=> o_Sign);

	RS : nRegister
	generic map(N  => 32)
	port map(i_CLK  => i_CLK,
		i_RST	=> i_RST,
		i_WE	=> i_WE,
		i_D	=> i_RS,
		o_Q	=> o_RS);

	RT : nRegister
	generic map(N  => 32)
	port map(i_CLK  => i_CLK,
		i_RST	=> i_RST,
		i_WE	=> i_WE,
		i_D	=> i_RT,
		o_Q	=> o_RT);

	Instr : nRegister
	generic map(N  => 32)
	port map(i_CLK  => i_CLK,
		i_RST	=> i_RST,
		i_WE	=> i_WE,
		i_D	=> i_Instr,
		o_Q	=> o_Instr);

	jrbit : dffg
	port map(i_CLK  => i_CLK,
		i_RST	=> i_RST,
		i_WE	=> i_WE,
		i_D	=> i_jrbit,
		o_Q	=> o_jrbit);

	EXTIMM : nRegister
	generic map(N  => 32)
	port map(i_CLK  => i_CLK,
		i_RST	=> i_RST,
		i_WE	=> i_WE,
		i_D	=> i_EXTIMM,
		o_Q	=> o_EXTIMM);

	WBAddr : nRegister
	generic map(N  => 5)
	port map(i_CLK  => i_CLK,
		i_RST	=> i_RST,
		i_WE	=> i_WE,
		i_D	=> WbAddrIn,
		o_Q	=> WbAddrOut);

	PCADDER1 : nRegister
	generic map(N  => 32)
	port map(i_CLK  => i_CLK,
		i_RST	=> i_RST,
		i_WE	=> i_WE,
		i_D	=> PCADDER1_IN,
		o_Q	=> PCADDER1_OUT);


end architecture structural;