library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity myaddNbitsTB is

end myaddNbitsTB;

architecture myaddNbitsTB_arch of myaddNbitsTB is

    component addNbits
    generic (
        N : integer := 4
    );
    port (
        e1, e2 : in std_logic_vector(N-1 downto 0);
        c_in : in std_logic;
        s1 : out std_logic_vector(N-1 downto 0);
        c_out : out std_logic
    );
    end component;

    constant N : integer := 6;

    signal e1_sim, e2_sim : std_logic_vector(N-1 downto 0) := (others => '0');
    signal s1_sim : std_logic_vector(N-1 downto 0) := (others => '0');
    signal c_in_sim, c_out_sim : std_logic := '0';

begin
    MyComponentAddNbitsunderTest : addNbits
    generic map (
        N => N
    )
    port map (
        e1 => e1_sim,
        e2 => e2_sim,
        c_in => c_in_sim,
        s1 => s1_sim,
        c_out => c_out_sim
    );
    MyStimulusProcess : process
    begin 
        for i in 0 to (2**N)-1 loop
            for j in 0 to (2**N)-1 loop
                for k in 0 to 1 loop
                    c_in_sim <= to_unsigned(k,1)(0);
                    e1_sim <= std_logic_vector(to_unsigned(i,N));
                    e2_sim <= std_logic_vector(to_unsigned(j,N));
                    wait for 100 us;
                    report "c_in = " & integer'image(k) & " | e1 = " & integer'image(i) & " | e2 = " & integer'image(j) & " | s1 = " & integer'image(to_integer(unsigned(s1_sim))) & " | c_out = " & std_logic'image(c_out_sim);
                    assert s1_sim = (e1_sim + e2_sim + c_in_sim) report "Failure" severity failure;
                end loop;
            end loop;
        end loop;
        report "Test ok (no assert...)";
        wait;
    end process;
end myaddNbitsTB_arch;