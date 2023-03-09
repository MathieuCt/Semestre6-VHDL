library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;

entity mycomptdecompNbitstestbench is
end mycomptdecompNbitstestbench;

architecture mycomptdecompNbitstestbench_arch of mycomptdecompNbitstestbench is
    component comptdecompNbits is
        generic( N : integer);
        port(
            reset : in std_logic;
            clock : in std_logic;
            cpt : in std_logic;
            s1 : out std_logic_vector (N-1 downto 0)
        );
    end component;

    constant N : integer := 3;
    constant PERIOD : time := 100 us;
    
    signal s1_sim : std_logic_vector (N-1 downto 0) := (others => '0');
    signal reset_sim, cpt_sim, clock_sim : std_logic := '0';

    type t_SM_Test is (S0_INITCPT, S1_CPT, S2_INITDCPT, S3_DCPT, S4_END);
    signal r_SM_Test : t_SM_Test := S0_INITCPT;
    signal reset_automate : std_logic := '0';


    
    begin


        MyComponentsynthcomb01underTest : comptdecompNbits
        generic map(N => N)
        port map(
            reset => reset_sim,
            clock => clock_sim,
            cpt => cpt_sim,
            s1 => s1_sim
            
        );
        --Définition du process d'évolution de l'automate
        MyAutomatProc : process (reset_automate, clock_sim)
        begin

            if reset_automate = '1' then
                r_SM_Test <= S0_INITCPT;
            elsif falling_edge(clock_sim) then
                case r_SM_Test is
                    when S0_INITCPT =>
                        r_SM_Test <= S1_CPT;
                    when S1_CPT =>
                        if(s1_sim = (2**N)-1) then
                            r_sm_test <= S2_INITDCPT;
                        else   
                            r_SM_Test <= S1_CPT;
                        end if;
                    when S2_INITDCPT =>
                        r_SM_Test <= S3_DCPT;
                    when S3_DCPT =>
                        if (s1_sim = 0) then
                            r_SM_Test <= S4_END;
                        else
                            r_SM_Test <= S3_DCPT;
                        end if;
                    when S4_END =>
                        r_SM_Test <= S4_END;
                    when others =>
                        r_SM_Test <= S0_INITCPT;
                end case;
            end if;

        end process;

        MystimulusProc : process
        begin
            reset_automate <= '1';
            wait for PERIOD;
            reset_automate <= '0';
            wait;
        end process;


        My_clock_Proc : process
        begin
            clock_sim <= '0';
            wait for PERIOD/2;
            clock_sim <= '1';
            wait for PERIOD/2;
            --if now = 12*PERIOD then
            --    reset_sim <= '1';
            --    else
            --    reset_sim <= '0';
                
            --end if;
            report "reset_sim = " & std_logic'image(reset_sim) severity note;
            report "cpt_sim = " & std_logic'image(cpt_sim) severity note;
            
            if now = (N+2*(2**N))*PERIOD then
                wait;
            end if;
        end process;
        reset_sim <= '1' when r_SM_Test = S0_INITCPT or r_SM_Test = S2_INITDCPT or r_SM_Test = S4_END  else '0';
        cpt_sim <= '1' when r_SM_Test = S0_INITCPT or r_SM_Test = S1_CPT or r_SM_Test = S4_END else '0';
end mycomptdecompNbitstestbench_arch;