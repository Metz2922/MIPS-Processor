library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O


entity tb_ALU is
  generic(gCLK_HPER   : time := 10 ns);   -- Generic for half of the clock cycle period
end tb_ALU;



architecture mixed of tb_ALU is

constant cCLK_PER  : time := gCLK_HPER * 2;


component ALU is
port(	i_A	: in std_logic_vector(31 downto 0);
	i_B	: in std_logic_vector(31 downto 0);
	i_ALUc	: in std_logic_vector(6 downto 0);
	i_shamt	: in std_logic_vector(4 downto 0);
	i_replimm: in std_logic_vector(7 downto 0);
	i_signed: in std_logic;
	o_Zero	: out std_logic;
	o_O	: out std_logic_vector(31 downto 0);
	o_C	: out std_logic);--carry bit? idk about this but it's here for thought
end component;


signal s_A   : std_logic_vector(31 downto 0);
signal s_B	: std_logic_vector(31 downto 0);
signal s_ALUc	: std_logic_vector(6 downto 0);
signal s_shamt	: std_logic_vector(4 downto 0);
signal s_zero	: std_logic;
signal s_c	: std_logic;
signal s_o	: std_logic_vector(31 downto 0);
signal s_replimmed : std_logic_vector (7 downto 0);
signal s_sign 	: std_logic;



begin


DUT0: ALU
port MAP(i_A => s_A,
	i_B => s_B,
	i_ALUc => s_ALUc,
	i_shamt => s_shamt,
	i_replimm => s_replimmed,
	i_signed => s_sign, 
	o_Zero => s_zero,
	o_O => s_o,
	o_C => s_c);


P_TEST_CASES: process
  begin
s_sign <= '1';
 s_B <=x"12345678";  
 s_A <=x"00000000";
 s_shamt <= "00010";
 s_ALUc <= "0000101";   --SLL
    wait for gCLK_HPER*2;

 s_B <=x"12345678"; 
 s_A <=x"00000000";
 s_shamt <= "00010";
 s_ALUc <= "0000100";    --SRL
    wait for gCLK_HPER*2;

  s_B <=x"12345678"; 
 s_A <=x"00000001";
 s_shamt <= "00010";
 s_ALUc <= "0000010";   --add
    wait for gCLK_HPER*2;  

 
  s_A <=x"12345678"; 
 s_B <=x"00000001";
 s_shamt <= "00010";
 s_ALUc <= "0001010";   --sub
    wait for gCLK_HPER*2;   

  s_B <=x"80000000"; 
 s_A <=x"80000000";
 s_shamt <= "00010";
 s_ALUc <= "0000010";   --add, overflow test
    wait for gCLK_HPER*2;   

  s_A <= x"00000004";
  s_B <= x"00000005";
  s_ALUc <= "0001010";
  wait for gCLK_HPER*2;

  s_A <= x"00000000";
  s_B <= x"00001234";
  s_ALUc <= "0000001";
  wait for gCLK_HPER*2;

  s_B <= x"00001234";
  s_ALUc <= "0000101";
  s_shamt <= "10000";
  wait for gCLK_HPER*2;

  s_ALUc <= "0000100";
  s_shamt <= "10000";
  wait for gCLK_HPER*2;

  s_ALUc <= "0000110";
  s_shamt <= "10000";
  wait for gCLK_HPER*2;

  s_ALUc <= "0010101";
  s_shamt <= "00000";
  wait for gCLK_HPER*2;

  s_ALUc <= "1000000";
  s_replimmed <= "01010101";
  wait for gCLK_HPER*2;

 end process;

end mixed;