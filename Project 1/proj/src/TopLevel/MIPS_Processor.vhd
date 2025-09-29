library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library work;
use work.MIPS_types.all;

entity MIPS_Processor is
  generic(N : integer := DATA_WIDTH);
  port(iCLK            : in std_logic;
       iRST            : in std_logic;
       iInstLd         : in std_logic;
       iInstAddr       : in std_logic_vector(N-1 downto 0);
       iInstExt        : in std_logic_vector(N-1 downto 0);
       oALUOut         : out std_logic_vector(N-1 downto 0)); -- TODO: Hook this up to the output of the ALU. It is important for synthesis that you have this output that can effectively be impacted by all other components so they are not optimized away.

end  MIPS_Processor;

architecture structure of MIPS_Processor is

  -- Required data memory signals
  signal s_DMemWr       : std_logic; -- TODO: use this signal as the final active high data memory write enable signal
  signal s_DMemAddr     : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory address input
  signal s_DMemData     : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory data input
  signal s_DMemOut      : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the data memory output
 
  -- Required register file signals 
  signal s_RegWr        : std_logic; -- TODO: use this signal as the final active high write enable input to the register file
  signal s_RegWrAddr    : std_logic_vector(4 downto 0); -- TODO: use this signal as the final destination register address input
  signal s_RegWrData    : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory data input
  signal s_MuxIntoReg	: std_logic_vector(N-1 downto 0); -- Goes from the alu/mem mux into a mux that chooses between this signal and jal register 31

  -- Required instruction memory signals
  signal s_IMemAddr     : std_logic_vector(N-1 downto 0); -- Do not assign this signal, assign to s_NextInstAddr instead
  signal s_NextInstAddr : std_logic_vector(N-1 downto 0); -- TODO: use this signal as your intended final instruction memory address input.
  signal s_Inst         : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the instruction signal 

  -- Required halt signal -- for simulation
  signal s_Halt         : std_logic;  -- TODO: this signal indicates to the simulation that intended program execution has completed. (Opcode: 01 0100)

  -- Required overflow signal -- for overflow exception detection
  signal s_Ovfl         : std_logic;  -- TODO: this signal indicates an overflow exception would have been initiated

  -- Signals for fetch
  signal pcmux1_S : std_logic;
  signal s_EXTIMM, PCWRITE : std_logic_vector(31 downto 0);
  signal s_FetchIncremented: std_logic_vector(31 downto 0);

  -- Signals from CTRL Logic
  signal s_MemReadUnused : std_logic; -- TODO: Help I'm scared
  signal RegDst, ALUSrc, Branch, BNE, Jump, MemToReg, JAL : std_logic;
  signal ALUOp : std_logic_vector(3 downto 0);

  -- Signals from ALU_Control
  signal Sign : std_logic;
  signal ALUCTRL : std_logic_vector(6 downto 0);
  signal s_JRBIT : std_logic;

  -- Signals for Reg File
  signal s_oRS, s_oRT : std_logic_vector(31 downto 0);
  signal rdmux2out : std_logic_vector(4 downto 0);

  -- Signals for ALU
  signal s_MOUT, s_ALUOUT : std_logic_vector(31 downto 0); -- multiplexed input to alu, it certainly was named
  signal Zero, s_C : std_logic;  

  component mem is
    generic(ADDR_WIDTH : integer;
            DATA_WIDTH : integer);
    port(
          clk          : in std_logic;
          addr         : in std_logic_vector((ADDR_WIDTH-1) downto 0);
          data         : in std_logic_vector((DATA_WIDTH-1) downto 0);
          we           : in std_logic := '1';
          q            : out std_logic_vector((DATA_WIDTH -1) downto 0));
    end component;

component registerFile is
	port(i_D: in std_logic_vector(31 downto 0);
		i_CLK: in std_logic;
		i_RST: in std_logic;
		i_DS: in std_logic_vector(4 downto 0);
		i_RS: in std_logic_vector(4 downto 0);
		i_RT: in std_logic_vector(4 downto 0);
		o_RS: out std_logic_vector(31 downto 0);
		o_RT: out std_logic_vector(31 downto 0);
		i_WE: in std_logic);
end component;

component mux2t1_N is
	generic(N : integer := 16);
	port(i_S          : in std_logic;
       		i_D0         : in std_logic_vector(N-1 downto 0);
       		i_D1         : in std_logic_vector(N-1 downto 0);
       		o_O          : out std_logic_vector(N-1 downto 0));
end component;

component ALU is
port(	i_A	: in std_logic_vector(31 downto 0);
	i_B	: in std_logic_vector(31 downto 0);
	i_ALUc	: in std_logic_vector(6 downto 0);
	i_shamt	: in std_logic_vector(4 downto 0);
	o_Zero	: out std_logic;
	i_replimm: in std_logic_vector(7 downto 0);
	o_O	: out std_logic_vector(31 downto 0);
	o_C	: out std_logic;
	i_signed: in std_logic;
	o_Ovf	: out std_logic);
end component;

component signZeroExt is
port(i_D: in std_logic_vector(15 downto 0);
	i_C: in std_logic;
	o_D: out std_logic_vector(31 downto 0));
end component;

component PC is 
	port(i_CLK	: in std_logic;
		i_RST	: in std_logic;
		i_CHANGE: in std_logic_vector(31 downto 0); -- Drop in program counter
		o_PC	: out std_logic_vector(31 downto 0)); -- To read input of instruction mem
end component;


component rippleAdder_N is
	generic(N : integer := 32);
	port(i_C	: in std_logic;
		i_A	: in std_logic_vector(N-1 downto 0);
		i_B	: in std_logic_vector(N-1 downto 0);
		o_O	: out std_logic_vector(N-1 downto 0);
		o_C	: out std_logic);

end component;

component FetchLogic is 
	port(   pc_OUT : in std_logic_vector(31 downto 0);
		i_JADD	: in std_logic_vector(25 downto 0); -- 26 Bit jump
		i_Jump	: in std_logic;
		i_Mux1s : in std_logic;
		i_immed : in std_logic_vector(31 downto 0);
		i_JUMPRET: in std_logic;
		i_JUMPRETVAL : in std_logic_vector(31 downto 0);
		o_JALVAL: out std_logic_vector(31 downto 0);
		o_PCWRITE	: out std_logic_vector(31 downto 0)); -- To read input of instruction mem
		
end component;

component alu_control is
port 	(ALUOp: in std_logic_vector(3 downto 0);
	funct	: in std_logic_vector(5 downto 0);
	jrbit	: out std_logic;
	o_signed: out std_logic;
	o	: out std_logic_vector(6 downto 0));
end component;

component ctrl_logic is
port 	(opcode : in std_logic_vector(5 downto 0);
	 RegDst : out std_logic;
	 AluSrc : out std_logic;	
	 MemToReg : out std_logic;
	 RegWrite : out std_logic;
	 MemRead : out std_logic;
	 MemWrite : out std_logic;
	 Branch : out std_logic;
	 Jump	: out std_logic;
	 BNE	: out std_logic;
	 Halt	: out std_logic;
	 JAL	: out std_logic;
	 ALUOp : out std_logic_vector(3 downto 0));
end component;

begin

  -- TODO: This is required to be your final input to your instruction memory. This provides a feasible method to externally load the memory module which means that the synthesis tool must assume it knows nothing about the values stored in the instruction memory. If this is not included, much, if not all of the design is optimized out because the synthesis tool will believe the memory to be all zeros.
  with iInstLd select
    s_IMemAddr <= s_NextInstAddr when '0',
      iInstAddr when others;


  IMem: mem
    generic map(ADDR_WIDTH => ADDR_WIDTH,
                DATA_WIDTH => N)
    port map(clk  => iCLK,
             addr => s_IMemAddr(11 downto 2),
             data => iInstExt,
             we   => iInstLd,
             q    => s_Inst);
  
  DMem: mem
    generic map(ADDR_WIDTH => ADDR_WIDTH,
                DATA_WIDTH => N)
    port map(clk  => iCLK,
             addr => s_DMemAddr(11 downto 2),
             data => s_DMemData,
             we   => s_DMemWr,
             q    => s_DMemOut);

  -- TODO: Ensure that s_Halt is connected to an output control signal produced from decoding the Halt instruction (Opcode: 01 0100)
  -- TODO: Ensure that s_Ovfl is connected to the overflow output of your ALU

  -- TODO: Implement the rest of your processor below this comment! 
pcmux1_S <= Branch AND (Zero XOR BNE);

s_DMemAddr <= s_ALUOUT;

s_DMemData <= s_oRT;

oALUOUT <= s_ALUOUT;

CTRLLOGIC: ctrl_logic
port MAP(opcode => s_Inst(31 downto 26),
	 RegDst => RegDst,
	 AluSrc => ALUSrc,
	 MemToReg => MemToReg,
	 RegWrite => s_RegWr,
	 MemRead => s_MemReadUnused,
	 MemWrite => s_DMemWr,
	 Branch => Branch,
	 BNE => BNE,
	 Halt => s_Halt,
	 Jump => Jump,
	 JAL => JAL,
	 ALUOp => ALUOp);
-------------------------

ALULOGIC: alu_control 
port MAP(ALUOp => ALUOp,
	funct => s_Inst(5 downto 0),
	jrbit => s_JRBIT,
	o_signed => Sign,
	o => ALUCTRL);
----------------------------------

FetchLog: FetchLogic
port MAP(pc_OUT => s_NextInstAddr,
	i_JADD	=> s_Inst(25 downto 0), 
	i_Jump	=> Jump,
	i_Mux1s => pcmux1_S,
	i_immed => s_EXTIMM,
	i_JUMPRET => s_JRBIT,
	i_JUMPRETVAL => s_oRS,
	o_JALVAL => s_FetchIncremented,
	o_PCWRITE => PCWRITE);
--------------

PCounter: PC
port MAP(i_CLK 	=> iCLK,
	i_RST	=> iRST,
	i_CHANGE => PCWRITE,
	o_PC => s_NextInstAddr);
-----------------------------

rdmux: mux2t1_N
generic MAP(N => 5)
port MAP(i_S => RegDst,
	i_D0 => rdmux2out,
	i_D1 => s_Inst(15 downto 11),
	o_O => s_RegWrAddr);

rdmux2: mux2t1_N
generic MAP(N => 5)
port MAP(i_S => JAL,
	i_D0 => s_Inst(20 downto 16),
	i_D1 => "11111",
	o_O => rdmux2out);
--------------------------- 

linkmux: mux2t1_N
generic MAP(N => 32)
port MAP(i_S => JAL,
	i_D0 => s_MuxIntoReg,
	i_D1 => s_FetchIncremented,
	o_O => s_RegWrData);
--------------------------- 

REGFILE: registerFile
port MAP(i_D => s_RegWrData,
	i_CLK => iCLK,
	i_RST => iRST,
	i_DS => s_RegWrAddr,
	i_RS => s_Inst(25 downto 21),
	i_RT => s_Inst(20 downto 16),
	o_RS => s_oRS,
	o_RT => s_oRT,
	i_WE => s_RegWr);
-----------------------------

SIGNEXT: signZeroExt
port MAP(i_D => s_Inst(15 downto 0),
	i_C => Sign,
	o_D => s_EXTIMM);
---------------------------------

ALUMUX: mux2t1_N
generic MAP(N => 32)
port MAP(i_S => ALUSrc,
	i_D0 => s_oRT,
	i_D1 => s_EXTIMM,
	o_O => s_MOUT);
------------------------------------

ALU32b: ALU
port MAP(i_A => s_oRS,
	i_B => s_MOUT,
	i_ALUc => ALUCTRL,
	i_shamt => s_Inst(10 downto 6),
	o_Zero => Zero,
	o_O => s_ALUOUT,
	o_C => s_C,
	i_replimm => s_Inst(23 downto 16),
	i_signed => Sign,
	o_Ovf => s_Ovfl);
--------------------------------------------------------

MUXINREG: mux2t1_N
generic MAP(N => 32)
port MAP(i_S => MemToReg,
	i_D0 => s_ALUOUT,
	i_D1 => s_DMemOut,
	o_O => s_MuxIntoReg);

end structure;
