library IEEE;
use IEEE.std_logic_1164.all;

entity decoder5t32 is
	port(i_S : IN std_logic_vector(4 downto 0);
		o_D : OUT std_logic_vector(31 downto 0));
end decoder5t32;

architecture dataflow of decoder5t32 is
begin
	-- not happy about this and I might as well have just figured out a way to do this with fewer lines of code with how long it took to debug this
	o_D(0) <= (not i_S(4)) and (not i_S(3)) and (not i_S(2)) and (not i_S(1)) and (not i_S(0));
	o_D(1) <= (not i_S(4)) and (not i_S(3)) and (not i_S(2)) and (not i_S(1)) and (i_S(0));
	o_D(2) <= (not i_S(4)) and (not i_S(3)) and (not i_S(2)) and (i_S(1)) and (not i_S(0));
	o_D(3) <= (not i_S(4)) and (not i_S(3)) and (not i_S(2)) and (i_S(1)) and (i_S(0));
	o_D(4) <= (not i_S(4)) and (not i_S(3)) and (i_S(2)) and (not i_S(1)) and (not i_S(0));
	o_D(5) <= (not i_S(4)) and (not i_S(3)) and (i_S(2)) and (not i_S(1)) and (i_S(0));
	o_D(6) <= (not i_S(4)) and (not i_S(3)) and (i_S(2)) and (i_S(1)) and (not i_S(0));
	o_D(7) <= (not i_S(4)) and (not i_S(3)) and (i_S(2)) and (i_S(1)) and (i_S(0));
	o_D(8) <= (not i_S(4)) and (i_S(3)) and (not i_S(2)) and (not i_S(1)) and (not i_S(0));
	o_D(9) <= (not i_S(4)) and (i_S(3)) and (not i_S(2)) and (not i_S(1)) and (i_S(0));
	o_D(10) <= (not i_S(4)) and (i_S(3)) and (not i_S(2)) and (i_S(1)) and (not i_S(0));
	o_D(11) <= (not i_S(4)) and (i_S(3)) and (not i_S(2)) and (i_S(1)) and (i_S(0));
	o_D(12) <= (not i_S(4)) and (i_S(3)) and (i_S(2)) and (not i_S(1)) and (not i_S(0));
	o_D(13) <= (not i_S(4)) and (i_S(3)) and (i_S(2)) and (not i_S(1)) and (i_S(0));
	o_D(14) <= (not i_S(4)) and (i_S(3)) and (i_S(2)) and (i_S(1)) and (not i_S(0));
	o_D(15) <= (not i_S(4)) and (i_S(3)) and (i_S(2)) and (i_S(1)) and (i_S(0));
	o_D(16) <= (i_S(4)) and (not i_S(3)) and (not i_S(2)) and (not i_S(1)) and (not i_S(0));
	o_D(17) <= (i_S(4)) and (not i_S(3)) and (not i_S(2)) and (not i_S(1)) and (i_S(0));
	o_D(18) <= (i_S(4)) and (not i_S(3)) and (not i_S(2)) and (i_S(1)) and (not i_S(0));
	o_D(19) <= (i_S(4)) and (not i_S(3)) and (not i_S(2)) and (i_S(1)) and (i_S(0));
	o_D(20) <= (i_S(4)) and (not i_S(3)) and (i_S(2)) and (not i_S(1)) and (not i_S(0));
	o_D(21) <= (i_S(4)) and (not i_S(3)) and (i_S(2)) and (not i_S(1)) and (i_S(0));
	o_D(22) <= (i_S(4)) and (not i_S(3)) and (i_S(2)) and (i_S(1)) and (not i_S(0));
	o_D(23) <= (i_S(4)) and (not i_S(3)) and (i_S(2)) and (i_S(1)) and (i_S(0));
	o_D(24) <= (i_S(4)) and (i_S(3)) and (not i_S(2)) and (not i_S(1)) and (not i_S(0));
	o_D(25) <= (i_S(4)) and (i_S(3)) and (not i_S(2)) and (not i_S(1)) and (i_S(0));
	o_D(26) <= (i_S(4)) and (i_S(3)) and (not i_S(2)) and (i_S(1)) and (not i_S(0));
	o_D(27) <= (i_S(4)) and (i_S(3)) and (not i_S(2)) and (i_S(1)) and (i_S(0));
	o_D(28) <= (i_S(4)) and (i_S(3)) and (i_S(2)) and (not i_S(1)) and (not i_S(0));
	o_D(29) <= (i_S(4)) and (i_S(3)) and (i_S(2)) and (not i_S(1)) and (i_S(0));
	o_D(30) <= (i_S(4)) and (i_S(3)) and (i_S(2)) and (i_S(1)) and (not i_S(0));
	o_D(31) <= (i_S(4)) and (i_S(3)) and (i_S(2)) and (i_S(1)) and (i_S(0));
end dataflow;
