library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity alu_control is
port 	(ALUOp: in std_logic_vector(3 downto 0);
	funct	: in std_logic_vector(5 downto 0);
	jrbit	: out std_logic;
	o_signed: out std_logic;
	o	: out std_logic_vector(6 downto 0));
end alu_control;


architecture mixed of alu_control is

begin
-- "3210"
-- 0 bit, MUX2: 0: and 1: or, barrel shifter l/r bit
-- 1 bit, MUX1: 0: and 1: add, also barrel shifter logical bit
-- 2 bit: MUX0: 1 is barrel shifter and slt, 0 everything else
-- 3 bit: Control bit: ex: 0 is add/or 1 sub/nor, also MUX3 between 0(barrel shifter) and 1(slt)
process(ALUOp, funct)
begin
case ALUOp is
	when "0001" => o <= "0000001"; jrbit <= '0';--ori
	when "0010" => o <= "0100010"; jrbit <= '0';--add operations
	when "0011" => o <= "0000010"; jrbit <= '0';--addu
	when "0100" => o <= "0001010"; jrbit <= '0';--bne
	when "0101" => o <= "0000000"; jrbit <= '0';--and
	when "0110" => o <= "0001100"; jrbit <= '0';--slti
	when "0111" => o <= "0000011"; jrbit <= '0';--xori
	when "1000" => o <= "0010101"; jrbit <= '0';--lui
	when "1111" => o <= "1------"; jrbit <= '0';--repl
	when "0000" => case funct is   
		when "100000" => o <= "0100010"; jrbit <= '0';  --add
		when "100001" => o <= "0000010"; jrbit <= '0'; --addu
		when "100100" => o <= "0000000"; jrbit <= '0'; --and
		when "100111" => o <= "0001001"; jrbit <= '0'; --nor
		when "100110" => o <= "0000011"; jrbit <= '0'; --xor
		when "100101" => o <= "0000001"; jrbit <= '0'; --or
		when "101010" => o <= "0001100"; jrbit <= '0'; --slt
		when "000000" => o <= "0000101"; jrbit <= '0'; --sll
		when "000010" => o <= "0000100"; jrbit <= '0'; --srl
		when "000011" => o <= "0000110"; jrbit <= '0'; --sra
		when "100010" => o <= "0101010"; jrbit <= '0'; --sub
		when "100011" => o <= "0001010"; jrbit <= '0'; --subu
		when "001000" => o <= "-------"; jrbit <= '1'; --jr
		when others => o <= "0000000"; jrbit <= '0'; 
	end case;
	when others => o <= "0000000"; jrbit <= '0';
end case;
end process;

process(ALUOp, funct)
begin
case ALUOp is
	when "0010" => o_signed <= '1';
	when "0110" => o_signed <= '1';
	when "0011" => o_signed <= '1';
	when "0100" => o_signed <= '1';
	when others => o_signed <= '0';
end case;
end process;

end mixed;