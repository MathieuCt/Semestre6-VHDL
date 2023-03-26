library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALUTB is
end ALUTB;

architecture ALUTB_Arch of ALUTB is
    component ALU is
        generic(N : integer);
        port(
            a, b: in signed(N-1 downto 0);
            sel: in std_logic_vector(3 downto 0);
            s : out signed(2*N-1 downto 0) := (others => '0');
            SR_IN_R : in std_logic;
            SR_IN_L : in std_logic;
            SR_OUT_R : out std_logic := '0';
            SR_OUT_L : out std_logic := '0'
        );
    end component ALU;
    signal a_sim, b_sim : signed(3 downto 0);
    signal s_sim : signed(7 downto 0);
    signal sel_sim : std_logic_vector(3 downto 0);
    signal SR_IN_R_sim, SR_IN_L_sim, SR_OUT_R_sim, SR_OUT_L_sim : std_logic;
begin
    
    ALU1: ALU 
        generic map(N => 4) port map(
        a => a_sim,
        b => b_sim,
        sel => sel_sim,
        s => s_sim,
        SR_IN_R => SR_IN_R_sim,
        SR_IN_L => SR_IN_L_sim,
        SR_OUT_R => SR_OUT_R_sim,
        SR_OUT_L => SR_OUT_L_sim
    );
    main : process
    begin
        a_sim <= "0011";
        b_sim <= "0001";
        sel_sim <= "1101";
        SR_IN_R_sim <= '0';
        SR_IN_L_sim <= '0';
        wait for 100 us;
        a_sim <= "0001";
        b_sim <= "0001";
        sel_sim <= "1001";
        SR_IN_R_sim <= '0';
        SR_IN_L_sim <= '0';
        wait;
    end process main;
end ALUTB_Arch;
