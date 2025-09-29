LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY HazardCtrl IS
    PORT (
        BranchTaken : IN STD_LOGIC;
        Branch : IN STD_LOGIC;
        BranchEX : IN STD_LOGIC;
        Jump : IN STD_LOGIC;
        JR : IN STD_LOGIC;
        RS : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        RT : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        IDEXRd : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        EXMEMRd : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        ALUSrc : IN STD_LOGIC;
        Flush : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        Stall : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        RegDstIn : IN STD_LOGIC;
        Reset    : IN STD_LOGIC;
        RegisterFileWriteEnable : IN STD_LOGIC);
END HazardCtrl;
ARCHITECTURE mixed OF HazardCtrl IS
    SIGNAL branchInPipeline : STD_LOGIC;
    SIGNAL RSCheck, RSEXCheck, RSMEMCheck : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL RTCheck, RTEXCheck, RTMEMCheck : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL RegDestFlag : STD_LOGIC;
    SIGNAL detectFirstCycle : STD_LOGIC;
    SIGNAL StallResult      : STD_LOGIC;

BEGIN
    --branchInPipeline <= Branch OR BranchEX;
    RSEXCheck <= (IDEXRd XOR RS);
    RTEXCheck <= (IDEXRd XOR RT);

    RSMEMCheck <= (RS XOR EXMEMRd);
    RTMEMCheck <= (RT XOR EXMEMRd);
    
    StallResult <= '0' when (RegisterFileWriteEnable /= '0' AND 
    ((RSEXCheck = "00000" AND IDEXRd /= "00000") OR 
    (RTEXCheck = "00000" AND IDEXRd /= "00000" AND 
    (RegDstIn = '1' OR Branch = '1')) OR 
    (RSMEMCheck = "00000" AND EXMEMRd /= "00000") OR 
    (RTMEMCheck = "00000" AND (EXMEMRd /= "00000" OR BranchEX = '1') AND 
    RegDstIn = '1'))) else '1';

    Flush(3) <= BranchTaken OR Jump OR JR;
    Flush(2) <= BranchTaken OR NOT StallResult;
    Flush(1) <= '0';
    Flush(0) <= '0';

    Stall(3) <= StallResult;
    Stall(2) <= '1';
    Stall(1) <= '1';
    Stall(0) <= '1';


END mixed;