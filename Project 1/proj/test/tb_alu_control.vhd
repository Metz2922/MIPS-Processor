library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_alu_control is
end tb_alu_control;

architecture mixed of tb_alu_control is

component alu_control is
port 	(ALUOp: in std_logic_vector(3 downto 0);
	funct	: in std_logic_vector(5 downto 0);
	jrbit	: out std_logic;
	o_signed: out std_logic;
	o	: out std_logic_vector(6 downto 0));
end component;

signal s_ALUCIN : std_logic_vector(3 downto 0);
signal s_funct : std_logic_vector(5 downto 0);
signal s_o : std_logic_vector(6 downto 0);
signal s_jr : std_logic;
signal s_signed: std_logic;

begin

DUT0: alu_control
port MAP(ALUOp => s_ALUCIN,
	funct => s_funct,
	jrbit => s_jr,
	o_signed => s_signed,
	o => s_o);

P_TESTS: process
begin

	s_ALUCIN <= "0000";
	s_funct <= "000000";
	wait for 10 ns;

	s_ALUCIN <= "0001";
	wait for 10 ns;

	s_ALUCIN <= "0010";
	wait for 10 ns;

	s_ALUCIN <= "0011";
	wait for 10 ns;

	s_ALUCIN <= "0100";
	wait for 10 ns;

	s_ALUCIN <= "0101";
	wait for 10 ns;

	s_ALUCIN <= "0110";
	wait for 10 ns;

	s_ALUCIN <= "0111";
	wait for 10 ns;

	s_ALUCIN <= "1000";
	wait for 10 ns;
	
	s_ALUCIN <= "1111";
	wait for 10 ns;
	
	s_ALUCIN <= "0000";
	s_funct <= "000000";
	wait for 10 ns;

	s_funct <= "000010";
	wait for 10 ns;

	s_funct <= "000011";
	wait for 10 ns;

	s_funct <= "001000";
	wait for 10 ns;

	s_funct <= "100000";
	wait for 10 ns;

	s_funct <= "100001";
	wait for 10 ns;

	s_funct <= "100010";
	wait for 10 ns;

	s_funct <= "100011";
	wait for 10 ns;

	s_funct <= "100100";
	wait for 10 ns;

	s_funct <= "100101";
	wait for 10 ns;

	s_funct <= "100110";
	wait for 10 ns;

	s_funct <= "100111";
	wait for 10 ns;

	s_funct <= "101010";
	wait for 10 ns;
end process;
end architecture;
