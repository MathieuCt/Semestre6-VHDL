library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity mysynthsequ01testbench is
end mysynthsequ01testbench;

architecture mysynthsequ01testbench_arch of mysynthsequ01testbench is
    component synthsequ01 is
        generic (N : integer);
        port(
            clock : in std_logic;
            reset : in std_logic;
            s1 : out std_logic_vector (2*N-1 downto 0)
        );
    end component;

    constant N : integer := 3;
    constant PERIOD : time := 100 us;
    
    signal s1_sim : std_logic_vector (2*N-1 downto 0) := (others => '0');
    signal reset_sim, clock_sim : std_logic := '0';

    begin
        MyComponentsynthsequ01underTest : synthsequ01
        generic map( N => N )
        port map(
            clock => clock_sim,
            reset => reset_sim,
            s1 => s1_sim
        );

        My_clock_Proc : process
        begin
            clock_sim <= '0';
            wait for PERIOD/2;
            clock_sim <= '1';
            wait for PERIOD/2;
            if now = PERIOD*(4+(2**(2*N+2))) then
                wait;
            end if;
        end process;

        MyStimulus_Proc2 : process
        begin
            reset_sim <= '1';
            wait for PERIOD;
            reset_sim <= '0';
            wait;
        end process;

end mysynthsequ01testbench_arch;