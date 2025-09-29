-------------------------------------------------------------------------
-- Kaden Berger
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- IFIDReg.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of the ID/Ex Register
--
--
-- NOTES:
-- 11/6/24 by Kaden::Design Created
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity IFIDReg is
	port(i_CLK  	 : in std_logic;
	     i_RST       : in std_logic;
	     i_WE        : in std_logic;
	     PCIn	 : in std_logic_vector(31 downto 0);
	     InstIn	 : in std_logic_vector(31 downto 0);
	     PCOut	 : out std_logic_vector(31 downto 0);
	     InstOut	 : out std_logic_vector(31 downto 0));
end IFIDReg;

architecture structural of IFIDReg is

component nRegister is
	generic(N: integer := 32);
	port(i_CLK	: in std_logic;
		i_RST	: in std_logic;
		i_WE	: in std_logic;
		i_D	: in std_logic_vector(N-1 downto 0);
		o_Q	: out std_logic_vector(N-1 downto 0));
end component;

begin

	PC: nRegister
	generic map(N => 32)
	port map(i_CLK  => i_CLK,
		i_RST	=> i_RST,
		i_WE	=> i_WE,
		i_D	=> PCIn,
		o_Q	=> PCOut);

	Instruction: nRegister
	generic map(N => 32)
	port map(i_CLK  => i_CLK,
		i_RST	=> i_RST,
		i_WE	=> i_WE,
		i_D	=> InstIn,
		o_Q	=> InstOut);

end architecture structural;