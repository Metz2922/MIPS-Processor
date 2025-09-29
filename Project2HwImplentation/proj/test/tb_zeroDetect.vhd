library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O

entity tb_zeroDetect is
end tb_zeroDetect;

architecture mixed of tb_zeroDetect is

component zeroDetect is
port(i_D	: in std_logic_vector(31 downto 0);
	o_Z	: out std_logic);
end component;

signal s_O : std_logic;
signal s_D : std_logic_vector(31 downto 0);

begin

DUT0: zeroDetect
port MAP(i_D => s_D,
	o_Z => s_O);

P_TEST: process
begin

	s_D <= x"00000000";
	wait for 10 ns;

	s_D <= x"00000001";
	wait for 10 ns;

	s_D <= x"FFFFFFFE";
	wait for 10 ns;
end process;
end mixed;