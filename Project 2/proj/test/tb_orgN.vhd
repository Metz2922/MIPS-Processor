library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O

entity tb_orgN is
end tb_orgN;

architecture mixed of tb_orgN is

component orgN is
	generic(N : integer := 32);
	port(i_D0	: in std_logic_vector(N-1 downto 0);
	i_D1		: in std_logic_vector(N-1 downto 0);
	o_F		: out std_logic_vector(N-1 downto 0));
end component;

signal s_D0, s_D1, s_O : std_logic_vector(31 downto 0);

begin

DUT0: orgN
generic MAP(N => 32)
port MAP(i_D0 => s_D0,
	i_D1 => s_D1,
	o_F => s_O);

P_TESTS: process
begin

	s_D0 <= x"00000000";
	s_D1 <= x"00000000";
	wait for 10 ns;

	s_D0 <= x"FFFFFFFF";
	s_D1 <= x"00000000";
	wait for 10 ns;

	s_D0 <= x"FFFFFFFF";
	s_D1 <= x"00000001";
	wait for 10 ns;

	s_D0 <= x"FFFFFFFF";
	s_D1 <= x"FFFFFFFF";
	wait for 10 ns;
end process;
end mixed;