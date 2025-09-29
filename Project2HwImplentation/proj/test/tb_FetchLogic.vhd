library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_FetchLogic is
end entity;

architecture mixed of tb_FetchLogic is

component FetchLogic is
	port(   pc_OUT : in std_logic_vector(31 downto 0);
		i_JADD	: in std_logic_vector(25 downto 0); -- 26 Bit jump
		i_Jump	: in std_logic;
		i_Mux1s	: in std_logic;
		i_immed : in std_logic_vector(31 downto 0);
		i_JUMPRET: in std_logic;
		i_JUMPRETVAL : in std_logic_vector(31 downto 0);
		o_JALVAL: out std_logic_vector(31 downto 0);
		o_PCWRITE	: out std_logic_vector(31 downto 0)); -- To read input of instruction mem
end component;

signal s_pcOUT, s_immed, s_pcWRITE, s_JUMPRETVAL, s_JALVAL: std_logic_vector(31 downto 0);
signal s_JADD : std_logic_vector(25 downto 0);
signal s_Jump, s_Mux1s, s_JUMPRET: std_logic := '0';

begin

DUT0: FetchLogic
port MAP(pc_OUT => s_pcOUT,
	i_JADD => s_JADD,
	i_Jump => s_Jump,
	i_Mux1s => s_Mux1s,
	i_immed => s_immed,
	i_JUMPRET => s_JUMPRET,
	i_JUMPRETVAL => s_JUMPRETVAL,
	o_JALVAL => s_JALVAL,
	o_PCWRITE => s_pcWRITE);

P_TESTS: process
begin
	s_pcOUT <= x"00400000";
	s_immed <= x"00000000";
	s_JADD <= "00000000000000000000000000";
	wait for 10 ns;
	
	s_pcOUT <= x"00400604";
	s_JADD <= "10000000000000000000000001";
	s_Jump <= '1';
	wait for 10 ns;

	s_Jump <= '0';
	s_immed <= x"af321604";
	s_Mux1s <= '1';
	wait for 10 ns;

	s_JUMPRETVAL <= x"00403400";
	s_JUMPRET <= '1';
	wait for 10 ns;

end process;
end mixed;
