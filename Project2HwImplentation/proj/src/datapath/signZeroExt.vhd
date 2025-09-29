library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity signZeroExt is
port(i_D: in std_logic_vector(15 downto 0);
	i_C: in std_logic;
	o_D: out std_logic_vector(31 downto 0));
end signZeroExt;

architecture dataflow of signZeroExt is
begin
process(i_D, i_C)
begin
	if i_C = '1' then
		if i_D(15) = '1' then
			o_D <= "1111111111111111"&i_D;
		else
			o_D <= "0000000000000000"&i_D;
		end if;
	else
		o_D <= "0000000000000000"&i_D;
	end if;
end process;
end dataflow;
