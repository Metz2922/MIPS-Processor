library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity HazardCtrl is
port(BranchTaken : in std_logic;
	 Branch : in std_logic;
     BranchEX : in std_logic;
	 Jump	: in std_logic;
     JR     : in std_logic;
     Flush  : out std_logic_vector(3 downto 0);
     Stall  : out std_logic_vector(3 downto 0));
end HazardCtrl;


architecture mixed of HazardCtrl is
signal branchInPipeline : std_logic;

begin
branchInPipeline <= Branch OR BranchEX;
    

    Flush(3) <= branchInPipeline OR Jump OR JR;
    Flush(2) <= '0';
    Flush(1) <= '0';
    Flush(0) <= '0';
    
    Stall(3) <= '0';
    Stall(2) <= '0';
    Stall(1) <= '0';
    Stall(0) <= '0';
    

    
    
end mixed;