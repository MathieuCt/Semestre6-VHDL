library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALUCoreTB is
end ALUCoreTB;

architecture ALUCoreTB_Arch of ALUCoreTB is
    component ALUCore is
        port(
            a, b: in std_logic_vector(3 downto 0);
            sel: in std_logic_vector(3 downto 0);
            s : out std_logic_vector(7 downto 0) := (others => '0');
            SR_IN_R : in std_logic;
            SR_IN_L : in std_logic;
            SR_OUT_R : out std_logic := '0';
            SR_OUT_L : out std_logic := '0'
        );
    end component ALUCore;
    signal a_sim, b_sim : std_logic_vector(3 downto 0);
    signal s_sim : std_logic_vector(7 downto 0);
    signal sel_sim : std_logic_vector(3 downto 0);
    signal SR_IN_R_sim, SR_IN_L_sim, SR_OUT_R_sim, SR_OUT_L_sim : std_logic;
begin
    
    ALU1: ALUCore
        port map(
        a => a_sim,
        b => b_sim,
        sel => sel_sim,
        s => s_sim,
        SR_IN_R => SR_IN_R_sim,
        SR_IN_L => SR_IN_L_sim,
        SR_OUT_R => SR_OUT_R_sim,
        SR_OUT_L => SR_OUT_L_sim
    );
    test : process
    begin
        report "ALU Testbench" severity note;
        a_sim <= "0111";
        b_sim <= "0111";
        sel_sim <= "0010";
        SR_IN_R_sim <= '0';
        SR_IN_L_sim <= '0';
        wait for 100 us;
        a_sim <= "0110";
        b_sim <= "0111";
        sel_sim <= "1011";
        SR_IN_R_sim <= '0';
        SR_IN_L_sim <= '0';
        wait for 100 us;
        a_sim <= "0000";
        b_sim <= "0110";
        sel_sim <= "0110";
        SR_IN_R_sim <= '1';
        SR_IN_L_sim <= '0';
        wait for 100 us;
        a_sim <= "0011";
        b_sim <= "0111";
        sel_sim <= "1110";
        SR_IN_R_sim <= '1';
        SR_IN_L_sim <= '0';
        wait for 100 us;
        wait;
    end process test;
end ALUCoreTB_Arch;
