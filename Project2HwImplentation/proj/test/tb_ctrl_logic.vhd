
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O


entity tb_ctrl_logic is
  generic(gCLK_HPER   : time := 10 ns);   -- Generic for half of the clock cycle period
end tb_ctrl_logic;



architecture mixed of tb_ctrl_logic is

constant cCLK_PER  : time := gCLK_HPER * 2;


component ctrl_logic is
port 	(opcode : in std_logic_vector(5 downto 0);
	 RegDst : out std_logic;
	 AluSrc : out std_logic;	
	 MemToReg : out std_logic;
	 RegWrite : out std_logic;
	 MemWrite : out std_logic;
	 Branch : out std_logic;
	 Jump	: out std_logic;
	 ALUOp : out std_logic_vector(3 downto 0));
end component;



signal s_opcode   : std_logic_vector(5 downto 0);
signal s_RegDst	: std_logic;
signal s_AluSrc	: std_logic;
signal s_MemToReg	: std_logic;
signal s_RegWrite	: std_logic;
signal s_MemWrite	: std_logic;
signal s_Branch	: std_logic;
signal s_Jump : std_logic;

signal s_ALUOp   : std_logic_vector(3 downto 0);



begin


DUT0: ctrl_logic
port MAP(opcode => s_opcode,
	 RegDst => s_RegDst,
	 AluSrc => s_ALUSrc,
	 MemToReg => s_MemToReg,
	 RegWrite => s_RegWrite,
	 MemWrite => s_MemWrite,
	 Branch => s_Branch,
	 Jump => s_Jump,
	 ALUOp => s_ALUOp);


P_TEST_CASES: process
  begin
 s_opcode <="000000"; 

    wait for gCLK_HPER*2;

 s_opcode <="100011"; 

    wait for gCLK_HPER*2;
 s_opcode <="101011"; 

    wait for gCLK_HPER*2;
 s_opcode <="000100"; 

    wait for gCLK_HPER*2;
 s_opcode <="000010"; 

    wait for gCLK_HPER*2;
 s_opcode <="001000"; 

    wait for gCLK_HPER*2;
 s_opcode <="001001"; 

    wait for gCLK_HPER*2;
 s_opcode <="001110"; 

    wait for gCLK_HPER*2;
 s_opcode <="001100"; 

    wait for gCLK_HPER*2;
 s_opcode <="001010"; 

    wait for gCLK_HPER*2;
 s_opcode <="001101"; 

    wait for gCLK_HPER*2;
 s_opcode <="000011"; 

    wait for gCLK_HPER*2;
 s_opcode <="000101"; 

    wait for gCLK_HPER*2;
 s_opcode <="001111"; 

    wait for gCLK_HPER*2;

    
 
 end process;

end mixed;