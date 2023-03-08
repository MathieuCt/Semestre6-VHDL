library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

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

    begin
        MyComponentsynthcomb01underTest : comptdecompNbits
        generic map(N => N)
        port map(
            reset => reset_sim,
            clock => clock_sim,
            cpt => cpt_sim,
            s1 => s1_sim
        );

        My_clock_Proc : process
        begin
            clock_sim <= '0';
            wait for PERIOD/2;
            clock_sim <= '1';
            wait for PERIOD/2;
            if now = 12*PERIOD then
                reset_sim <= '1';
                else
                reset_sim <= '0';
            end if;
            if now = (N+2*(2**N))*PERIOD then
                wait;
            end if;
        end process;
end mycomptdecompNbitstestbench_arch;