library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mysynthcomb01TB is
end mysynthcomb01TB;

architecture mysynthcomb01TB_arch of mysynthcomb01TB is
    component mysynthcomb01 is
        generic(
            N: integer
        );
        port(
            e1 : in std_logic_vector (N-1 downto 0);
            e2 : in std_logic_vector (N-1 downto 0);
            c_in : in std_logic;
            sel : in std_logic;
            s1 : out std_logic_vector (2*N-1 downto 0)
        );
        end component;

        constant N : integer := 2;
        signal e1_sim, e2_sim : std_logic_vector (N-1 downto 0) := (others => '0');
        signal e1_calc , e2_calc, c_in_calc : std_logic_vector (N downto 0) := (others => '0');
        signal s1_sim, s1_calc : std_logic_vector (2*N-1 downto 0) := (others => '0');
        signal sel_sim, c_in_sim : std_logic := '0';
begin

    MyComponentmysynthcomb01undertest : mysynthcomb01
    generic map(
        N => N
    )
    port map(
        e1 => e1_sim,
        e2 => e2_sim,
        c_in => c_in_sim,
        sel => sel_sim,
        s1 => s1_sim
    );

    c_in_calc(0) <= c_in_sim;
    c_in_calc(N downto 1) <= (others => '0');

    e1_calc(N) <= '0';
    e1_calc(N-1 downto 0) <= e1_sim;

    e2_calc(N) <= '0';
    e2_calc(N-1 downto 0) <= e2_sim;

    MyCalculate_Proc1: process (sel_sim, e1_calc, e2_calc, c_in_calc, e1_sim, e2_sim)
    begin
        if sel_sim = '0' then
            s1_calc(N downto 0) <= e1_calc + e2_calc + c_in_calc;
            s1_calc(2*N-1 downto N+1) <= (others => '0');
        else
            s1_calc <= e1_calc(N-1 downto 0) * e2_calc(N-1 downto 0);
        end if;
    end process;
    MyStimulus_Proc2: process
    begin
        for i in 0 to (2**N)-1 loop
            for j in 0 to (2**N)-1 loop
                for k in 0 to 1 loop
                    for l in 0 to 1 loop
                        e1_sim <= std_logic_vector(to_unsigned(i, N));
                        e2_sim <= std_logic_vector(to_unsigned(j, N));
                        c_in_sim <= to_unsigned(k, 1)(0);
                        sel_sim <= to_unsigned(l, 1)(0);
                        wait for 100 us;
                        report "sel_in=" & integer'image (1) & " | c_in=" & integer'image (k) & " | e1=" & integer'image(i) & " | e2  =" & integer'image (j) & " || s1 = " & integer'image(to_integer (unsigned (s1_sim)));
                    end loop;
                end loop;
            end loop;
        end loop;
        report "Simulation finished";
        wait;
    end process;
end mysynthcomb01TB_arch;