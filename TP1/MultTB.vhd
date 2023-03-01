library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity mymultNbitsTB is

end mymultNbitsTB;

architecture mymultNbitsTB_arch of mymultNbitsTB is

    component multNbits
    generic (
        N : integer := 4
    );
    port (
        e1, e2 : in std_logic_vector(N-1 downto 0);
        s1 : out std_logic_vector(2*N-1 downto 0)
    );
    end component;

    constant N : integer := 6;

    signal e1_sim, e2_sim : std_logic_vector(N-1 downto 0) := (others => '0');
    signal s1_sim : std_logic_vector(N*2-1 downto 0) := (others => '0');

begin
    MyComponentmultNbitsunderTest : multNbits
    generic map (
        N => N
    )
    port map (
        e1 => e1_sim,
        e2 => e2_sim,
        s1 => s1_sim
    );
    MyStimulusProcess : process
    begin 
        for i in 0 to (2**N)-1 loop
            for j in 0 to (2**N)-1 loop
                e1_sim <= std_logic_vector(to_unsigned(i,N));
                e2_sim <= std_logic_vector(to_unsigned(j,N));
                wait for 100 us;
                report " e1 = " & integer'image(i) & " | e2 = " & integer'image(j) & " | s1 = " & integer'image(to_integer(unsigned(s1_sim)));
                assert s1_sim = (e1_sim * e2_sim) report "Failure" severity failure;
            end loop;
        end loop;
        report "Test ok (no assert...)";
        wait;
    end process;
end mymultNbitsTB_arch;