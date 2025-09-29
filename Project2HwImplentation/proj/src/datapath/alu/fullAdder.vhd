library IEEE;
use IEEE.std_logic_1164.all;

entity fullAdder is
	port(
	i_A, i_B, i_C: in std_logic;
	o_S, o_C: out std_logic);
end fullAdder;

architecture structural of fullAdder is

	component andg2
		port(i_A          : in std_logic;
       		i_B          : in std_logic;
  	        o_F          : out std_logic);
	end component;

	component org2
		port(i_A          : in std_logic;
       		i_B          : in std_logic;
       		o_F          : out std_logic);
	end component;

	component xorg2
		port(i_A	: in std_logic;
		i_B		: in std_logic;
		o_F		: out std_logic);
	end component;

	signal s_AB, s_AxoB, s_CAxoB: std_logic;

begin
	axob: xorg2
	port MAP(i_A => i_A,
		i_B => i_B,
		o_F => s_AxoB);

	ab: andg2
	port MAP(i_A => i_A,
		i_B => i_B,
		o_F => s_AB);

	axobxoc: xorg2
	port MAP(i_A => s_AxoB,
		i_B => i_C,
		o_F => o_S);
	
	caxob: andg2
	port MAP(i_A => s_AxoB,
		i_B => i_C,
		o_F => s_CAxoB);

	cout: org2
	port MAP(i_A => s_AB,
		i_B => s_CAxoB,
		o_F => o_C);

end structural;
