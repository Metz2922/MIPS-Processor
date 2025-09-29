library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity zeroDetect is
port(i_D	: in std_logic_vector(31 downto 0);
	o_Z	: out std_logic);
end zeroDetect;

architecture dataflow of zeroDetect is

signal s_Z : std_logic := '0';

begin

process(i_D)
begin
if(i_D = "00000000000000000000000000000000") then
	o_Z <= '1';
else
	o_Z <= '0';
end if;

end process;

end dataflow;
