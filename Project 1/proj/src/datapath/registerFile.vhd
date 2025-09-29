library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.MIPS_types.all;

entity registerFile is
	port(i_D: in std_logic_vector(31 downto 0);
		i_CLK: in std_logic;
		i_RST: in std_logic;
		i_DS: in std_logic_vector(4 downto 0);
		i_RS: in std_logic_vector(4 downto 0);
		i_RT: in std_logic_vector(4 downto 0);
		o_RS: out std_logic_vector(31 downto 0);
		o_RT: out std_logic_vector(31 downto 0);
		i_WE: in std_logic);
end registerFile;

architecture structural of registerFile is

component mux32t1 is 
port(i_S: in std_logic_vector(4 downto 0);
	i_D: in bus_mux(31 downto 0);
	o_D: out std_logic_vector(31 downto 0));
end component;

component decoder5t32 is
port(i_S : IN std_logic_vector(4 downto 0);
	o_D : OUT std_logic_vector(31 downto 0));
end component;

component nRegister is
	generic(N: integer := 32);
	port(i_CLK	: in std_logic;
		i_RST	: in std_logic;
		i_WE	: in std_logic;
		i_D	: in std_logic_vector(N-1 downto 0);
		o_Q	: out std_logic_vector(N-1 downto 0));
end component;

component andg2 is
  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);
end component;

signal s_DO, s_WEPER: std_logic_vector(31 downto 0);
signal s_QO: bus_mux(31 downto 0);
constant c_RESET: std_logic:= '1';

begin

DECWRITE: decoder5t32
port MAP(i_S => i_DS,
	o_D => s_DO);

ANDR0: andg2
port MAP(i_A => s_DO(0),
	i_B => i_WE,
	o_F => s_WEPER(0));

REG0: nRegister
port MAP(i_CLK => i_CLK,
	i_RST => c_RESET,--constant 1 to keep reg at 0
	i_WE => s_WEPER(0),
	i_D => i_D,
	o_Q => s_QO(0));

G_REGS: for i in 1 to 31 generate

ANDRN: andg2
port MAP(i_A => s_DO(i),
	i_B => i_WE,
	o_F => s_WEPER(i));

REGN: nRegister
port MAP(i_CLK => i_CLK,
	i_RST => i_RST,
	i_WE => s_WEPER(i),
	i_D => i_D,
	o_Q => s_QO(i));
end generate G_REGS;

RSMUX: mux32t1
port MAP(i_S => i_RS,
	i_D => s_QO,
	o_D => o_RS);

RTMUX: mux32t1
port MAP(i_S => i_RT,
	i_D => s_QO,
	o_D => o_RT);

end structural;
