library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O

entity tb_MIPS_Processor is
end tb_MIPS_Processor;

architecture mixed of tb_MIPS_Processor is

component MIPS_Processor is
  generic(N : integer := DATA_WIDTH);
  port(iCLK            : in std_logic;
       iRST            : in std_logic;
       iInstLd         : in std_logic;
       iInstAddr       : in std_logic_vector(N-1 downto 0);
       iInstExt        : in std_logic_vector(N-1 downto 0);
       oALUOut         : out std_logic_vector(N-1 downto 0)); -- TODO: Hook this up to the output of the ALU. It is important for synthesis that you have this output that can effectively be impacted by all other components so they are not optimized away.
end component;

  signal s_CLK, s_RST, s_InstLd : std_logic;
  signal s_InstAddr, s_InstExt, s_ALUOut : std_logic_vector(31 downto 0);

  begin

  DUT0: MIPS_Processor
  generic MAP(N => 
