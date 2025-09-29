library IEEE;
use IEEE.std_logic_1164.all;

entity MEMWBReg is
	port(i_CLK  	 : in std_logic;
	     i_RST       : in std_logic;
	     i_WE        : in std_logic;
	     JALIn       : in std_logic;
	     MemtoRegIn  : in std_logic;
	     RegWrIn     : in std_logic;
	     HaltIn      : in std_logic;
	     JALOut      : Out std_logic;
	     MemtoRegOut : out std_logic;
	     RegWrOut    : out std_logic;
	     Haltout     : out std_logic;
	     RegDstIn    : in std_logic;
	     RegDstOut   : out std_logic;
		 OvfIn		 : in std_logic;
		 OvfOut		 : out std_logic;
	     FromALU     : in std_logic_vector(31 downto 0);
	     FromMem     : in std_logic_vector(31 downto 0);
	     MemToWB     : out std_logic_vector(31 downto 0);
	     ALUToWB     : out std_logic_vector(31 downto 0);
   	     WBAddrIn    : in std_logic_vector(4 downto 0);
		 PCADDER1_IN	: IN STD_LOGIC_VECTOR(31 downto 0);
			PCADDER1_OUT	: OUT STD_LOGIC_VECTOR(31 downto 0);
	     WBAddrOut   : out std_logic_vector(4 downto 0));
end MEMWBReg;

architecture structural of MEMWBReg is

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

	RegDst : dffg
	port map(i_CLK  => i_CLK,
		i_RST	=> i_RST,
		i_WE	=> i_WE,
		i_D	=> RegDstIn,
		o_Q	=> RegDstOut);

	ALUSignal : nRegister
	generic map(N  => 32)
	port map(i_CLK  => i_CLK,
		i_RST	=> i_RST,
		i_WE	=> i_WE,
		i_D	=> FromALU,
		o_Q	=> ALUToWB);

	MEMSignal : nRegister
	generic map(N  => 32)
	port map(i_CLK  => i_CLK,
		i_RST	=> i_RST,
		i_WE	=> i_WE,
		i_D	=> FromMem,
		o_Q	=> MemToWB);

	WBAddr : nRegister
	generic map(N  => 5)
	port map(i_CLK  => i_CLK,
		i_RST	=> i_RST,
		i_WE	=> i_WE,
		i_D	=> WBAddrIn,
		o_Q	=> WBAddrOut);

	Ovf : dffg
	port map(i_CLK  => i_CLK,
		i_RST	=> i_RST,
		i_WE	=> i_WE,
		i_D	=> OvfIn,
		o_Q	=> OvfOut);

		PCADDER : nRegister
	generic map(N  => 32)
	port map(i_CLK  => i_CLK,
		i_RST	=> i_RST,
		i_WE	=> i_WE,
		i_D	=> PCADDER1_IN,
		o_Q	=> PCADDER1_OUT);

end architecture structural;
