library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O

entity tb_slt is
end tb_slt;

architecture mixed of tb_slt is

component SLT is
port(i_D: in std_logic;
	o_D: out std_logic_vector(31 downto 0));
end component;

signal s_D : std_logic;
signal s_O : std_logic_vector(31 downto 0);

begin

DUT0: SLT
port MAP(i_D => s_D,
	o_D => s_O);

P_TEST: process
begin

	s_D <= '0';
	wait for 10 ns;

	s_D <= '1';
	wait for 10 ns;
end process;
end mixed;
