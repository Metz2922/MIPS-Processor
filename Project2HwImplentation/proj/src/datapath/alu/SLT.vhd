library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity SLT is
port(i_D: in std_logic;
	o_D: out std_logic_vector(31 downto 0));
end SLT;

architecture dataflow of SLT is
begin
process(i_D)
begin
	o_D <= "0000000000000000000000000000000"&i_D;
end process;
end dataflow;