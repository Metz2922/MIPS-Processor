library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity FetchLogic is 
	port(   pc_OUT : in std_logic_vector(31 downto 0);
		i_JADD	: in std_logic_vector(25 downto 0); -- 26 Bit jump
		i_Jump	: in std_logic;
		i_Mux1s	: in std_logic;
		i_immed : in std_logic_vector(31 downto 0);
		i_JUMPRET: in std_logic;
		i_JUMPRETVAL : in std_logic_vector(31 downto 0);
		o_PCADDER1	: out std_logic_vector(31 downto 0);
		i_PCADDER1	: in std_logic_vector(31 downto 0);
		o_JALVAL: out std_logic_vector(31 downto 0);
		o_PCWRITE	: out std_logic_vector(31 downto 0)); -- To read input of instruction mem
		
end FetchLogic;




architecture mixed of FetchLogic is
component mux2t1_N is
	generic(N : integer := 16);
	port(i_S          : in std_logic;
       		i_D0         : in std_logic_vector(N-1 downto 0);
       		i_D1         : in std_logic_vector(N-1 downto 0);
       		o_O          : out std_logic_vector(N-1 downto 0));
end component;

component rippleAdder_N is
	generic(N : integer := 32);
	port(i_C	: in std_logic;
		i_A	: in std_logic_vector(N-1 downto 0);
		i_B	: in std_logic_vector(N-1 downto 0);
		o_O	: out std_logic_vector(N-1 downto 0);
		o_C	: out std_logic);

end component;

signal Jump, pcadder1_cout, pcadder2_cout, s_BranchGO : std_logic;
signal immed_shifted, Jump_Address, pcadder1_OUT, pcadder2_OUT, pcmux1_OUT, pcmux2_OUT : std_logic_vector(31 downto 0);

begin


Jump_Address(27 downto 0) <= i_JADD(25 downto 0) & "00";
Jump_Address(31 downto 28) <= pcadder1_OUT(31 downto 28);

o_JALVAL <= pcadder1_OUT;
o_PCADDER1 <= pcadder1_OUT;
--o_JALVAL <= Jump_Address;

immed_shifted <= i_immed(29 downto 0) & "00";

PCMux1: mux2t1_N
generic MAP(N => 32)
port MAP(i_S => i_Mux1s,
	i_D0 => pcadder1_OUT,
	i_D1 => pcadder2_OUT,
	o_O => pcmux1_OUT);

PCMux2: mux2t1_N
generic MAP(N => 32)
port MAP(i_S => i_Jump,
	i_D0 => pcmux1_OUT,
	i_D1 => Jump_Address,
	o_O => pcmux2_OUT);

PCMux3: mux2t1_N
generic MAP(N => 32)
port MAP(i_S => i_JUMPRET,
	i_D0 => pcmux2_OUT,
	i_D1 => i_JUMPRETVAL,
	o_O => o_PCWRITE);

PCAdder1: rippleAdder_N
generic MAP(N => 32)
port MAP(i_C => '0',
	i_A => pc_OUT,
	i_B => x"00000004",
	o_O => pcadder1_OUT,
	o_C => pcadder1_cout);

PCAdder2: rippleAdder_N
generic MAP(N => 32)
port MAP(i_C => '0',
	i_A => i_PCADDER1,
	i_B => immed_shifted,
	o_O => pcadder2_OUT,
	o_C => pcadder2_cout);

--o_PCWRITE <= pcmux2_OUT;

end mixed;
