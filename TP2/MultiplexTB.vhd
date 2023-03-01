library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mymuxNbits2vers1testbench is
end mymuxNbits2vers1testbench;

architecture mymuxNbits2vers1testbench_Arch of mymuxNbits2vers1testbench is
    component muxNbits2vers1
    generic (
        N : integer
    );
    port (
        e1, e2 : in STD_LOGIC_VECTOR(N-1 downto 0);
        sel : in STD_LOGIC;
        s1 : out STD_LOGIC_VECTOR(N-1 downto 0)
    );
    end component;

    constant N : integer := 4;

    signal e1_sim, e2_sim : STD_LOGIC_VECTOR(N-1 downto 0) := (others => '0');
    signal s1_sim, s1_calc : STD_LOGIC_vector(N-1 downto 0) := (others => '0');
    signal sel_sim : STD_LOGIC := '0';

    begin
        MyComponentmuxNbits2vers1underTest : muxNbits2vers1
        generic map (
            N => N
            )
        port map (
            e1 => e1_sim,
            e2 => e2_sim,
            sel => sel_sim,
            s1 => s1_sim
        );

        s1_calc <= e1_sim when sel_sim = '0' else e2_sim;

        MystimulusProc2 : process
        begin
            for i in 0 to (2**N)-1 loop
                for j in 0 to (2**N)-1 loop
                    for k in 0 to 1 loop
                        e1_sim <= std_logic_vector(to_unsigned(i, N));
                        e2_sim <= std_logic_vector(to_unsigned(j, N));
                        sel_sim <= to_unsigned(k, 1)(0);
                        wait for 100 us;
                        report "sel_in=" & integer 'image(k) & " | el=" & integer 'image(i) & " | e2=" & integer 'image(j) & " || s1 = " & integer 'image(to_integer (unsigned (s1_sim)));
                        assert s1_sim = s1_calc report "Failure" severity failure;
                    end loop;
                end loop;
            end loop;
            report "Simulation complete";
            wait;
        end process;
    end mymuxNbits2vers1testbench_Arch;


