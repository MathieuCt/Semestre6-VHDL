library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;


entity mainTB is 
end;

architecture mainTB_arch of mainTB is
    component main
        port(
            Clock : in std_logic;
            RESET : in std_logic;
            SR_IN_L : in std_logic;
            SR_IN_R : in std_logic;
            A_IN : in std_logic_vector(3 downto 0);
            B_IN : in std_logic_vector(3 downto 0);
            SR_OUT_L : out std_logic;
            SR_OUT_R : out std_logic;
            RES_OUT : out std_logic_vector(7 downto 0)
        );
    end component;
    signal clock_sim : std_logic := '1';
    signal RESET_sim : std_logic;
    signal SR_IN_L_sim : std_logic;
    signal SR_IN_R_sim : std_logic;
    signal A_IN_sim : std_logic_vector(3 downto 0);
    signal B_IN_sim : std_logic_vector(3 downto 0);
    signal SR_OUT_L_sim : std_logic;
    signal SR_OUT_R_sim : std_logic;
    signal RES_OUT_sim : std_logic_vector(7 downto 0);
    signal cpt : integer := 1;
    begin 
        mainComponent : main
            port map(
                Clock => clock_sim,
                RESET => RESET_sim,
                SR_IN_L => SR_IN_L_sim,
                SR_IN_R => SR_IN_R_sim,
                A_IN => A_IN_sim,
                B_IN => B_IN_sim,
                SR_OUT_L => SR_OUT_L_sim,
                SR_OUT_R => SR_OUT_R_sim,
                RES_OUT => RES_OUT_sim
            );
        clock_proc: process
        begin
            report "cpt :" & integer'image(cpt);
            clock_sim <= '1';
            wait for 100 us;
            clock_sim <= '0';
            wait for 100 us;
            if now = 200*128 us then
                wait;
            end if;
        end process;
        set_proc : process(clock_sim)
        begin 
            if(falling_edge(clock_sim)) then
                case cpt is 
                    when 1 => 
                        A_IN_sim <= "0011";
                        B_IN_sim <= "0000";
                        SR_IN_L_sim <= '0';
                        SR_IN_R_sim <= '0';
                        RESET_sim <= '0';
                    when 2 => 
                        A_IN_sim <= "0000";
                        B_IN_sim <= "0011";
                        SR_IN_L_sim <= '0';
                        SR_IN_R_sim <= '0';
                        RESET_sim <= '0';
                    when 3 => 
                        A_IN_sim <= "0000";
                        B_IN_sim <= "0000";
                        SR_IN_L_sim <= '0';
                        SR_IN_R_sim <= '0';
                        RESET_sim <= '0';
                    when 4 => 
                        A_IN_sim <= "0000";
                        B_IN_sim <= "0000";
                        SR_IN_L_sim <= '0';
                        SR_IN_R_sim <= '0';
                        RESET_sim <= '0';
                    when 5 => 
                        A_IN_sim <= "0000";
                        B_IN_sim <= "0000";
                        SR_IN_L_sim <= '0';
                        SR_IN_R_sim <= '0';
                        RESET_sim <= '0';
                    when others => 
                        A_IN_sim <= "0000";
                        B_IN_sim <= "0000";
                        SR_IN_L_sim <= '0';
                        SR_IN_R_sim <= '0';
                        RESET_sim <= '0';
                end case;
                cpt <= cpt + 1;
            end if;
        end process;
    end mainTB_arch;
