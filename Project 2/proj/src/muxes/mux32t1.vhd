library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

package bus_mux_input is
	type bus_mux is array(natural range <>) of std_logic_vector(31 downto 0);
end package;

library IEEE;
use IEEE.std_logic_1164.all;
use work.bus_mux_input.all;
use IEEE.numeric_std.all;

entity mux32t1 is
	port(i_S: in std_logic_vector(4 downto 0);
	i_D: in bus_mux(31 downto 0);
	o_D: out std_logic_vector(31 downto 0));
end mux32t1;

architecture dataflow of mux32t1 is

begin
	o_D <= i_D(to_integer(unsigned(i_S)));
end dataflow;
