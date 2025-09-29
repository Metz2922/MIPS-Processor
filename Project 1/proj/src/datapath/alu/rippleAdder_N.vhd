library IEEE;
use IEEE.std_logic_1164.all;

entity rippleAdder_N is
	generic(N : integer := 32);
	port(i_C	: in std_logic;
		i_A	: in std_logic_vector(N-1 downto 0);
		i_B	: in std_logic_vector(N-1 downto 0);
		o_O	: out std_logic_vector(N-1 downto 0);
		o_C	: out std_logic);

end rippleAdder_N;

architecture structural of rippleAdder_N is

component fullAdder is
	port(
	i_A, i_B, i_C: in std_logic;
	o_S, o_C: out std_logic);
end component;

signal s_C : std_logic_vector(N-1 downto 1);

begin

rAdder_0: fullAdder
port MAP(i_A => i_A(0),
	i_B => i_B(0),
	i_C => i_C,
	o_S => o_O(0),
	o_C => s_C(1));

G_rAdder_N:for i in 1 to n-2 generate
rAdder_N: fullAdder
port MAP(i_A => i_A(i),
	i_B => i_B(i),
	i_C => s_C(i),
	o_S => o_O(i),
	o_C => s_C(i+1));
end generate G_rAdder_N;

r_Adder_N: fullAdder
port MAP(i_A => i_A(N-1),
	i_B => i_B(N-1),
	i_C => s_C(N-1),
	o_S => o_O(N-1),
	o_C => o_C);

end structural;
