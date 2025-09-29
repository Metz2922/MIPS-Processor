library IEEE;
use IEEE.std_logic_1164.all;

entity mux2t1d is
	port(
	i_S, i_D0, i_D1: in std_logic;
	o_O: out std_logic);
end mux2t1d;

architecture dataflow of mux2t1d is
begin
	o_O <= i_D1 when i_S = '1' else i_D0;
end dataflow;