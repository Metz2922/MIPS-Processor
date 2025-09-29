library IEEE;
use IEEE.std_logic_1164.all;

entity onesComp is
	generic(N : integer := 32);
	port(i_D0	: in std_logic_vector(N-1 downto 0);
	o_F		: out std_logic_vector(N-1 downto 0));

end onesComp;

architecture structural of onesComp is

component invg is
	port(i_A          : in std_logic;
	o_F          : out std_logic);
end component;

begin

G_NBit_ONESCOMP: for i in 0 to N-1 generate
ONESI: invg port map(
	i_A => i_D0(i),
	o_F => o_F(i));
end generate G_NBit_ONESCOMP;

end structural;
