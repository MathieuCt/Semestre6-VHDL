library IEEE;
use IEEE.std_logic_1164.all;

entity synthcomb01 is
generic (N : integer := 4);
port (
    e1: in std_logic_vector (N-1 downto 0);
    e2: in std_logic_vector (N-1 downto 0);
    c_in: in std_logic;
    sel: in std_logic;
    s1: out std_logic_vector (2*N-1 downto 0)
);
end synthcomb01;

architecture synthcomb01_arch of synthcomb01 is
    component MultNbits is
        generic (N : integer);
        port ( e1: in std_logic_vector (N-1 downto 0);
               e2: in std_logic_vector (N-1 downto 0);
               s1: out std_logic_vector (2*N-1 downto 0) 
        );
    end component;

    signal My_mult_s1 : std_logic_vector (2*N-1 downto 0);

    component addNbits is
    generic (N : integer);
        port (
            e1: in std_logic_vector (N-1 downto 0);
            e2: in std_logic_vector (N-1 downto 0);
            c_in: in std_logic;
            s1: out std_logic_vector (2*N-1 downto 0);
            c_out: out std_logic
        );
    end component;

    signal My_c_out : std_logic;
    signal My_add_s1 : std_logic_vector (N-1 downto 0);

    component muxNbits2vers1 is
        generic (N : integer);
        port (
            e1: in std_logic_vector (N-1 downto 0);
            e2: in std_logic_vector (N-1 downto 0);
            sel: in std_logic;
            s1: out std_logic_vector (N-1 downto 0)
        );
    end component;

    signal my_mux_e1 : std_logic_vector (2*N-1 downto 0) := (others => '0');
    signal my_mux_e2 : std_logic_vector (2*N-1 downto 0) := (others => '0');

begin

    MyComponentAddNbit : AddNbits
    generic map (N => N)
    port map (
        e1 => e1,
        e2 => e2,
        c_in => c_in,
        s1 => My_add_s1,
        c_out => My_c_out
    );

    MycomponentMulNbits : MultNbits
    generic map (N => N)
    port map (
        e1 => e1,
        e2 => e2,
        s1 => My_add_s1
    );

    MyComponentmuxNbits2vers1 : muxNbits2vers1
    generic map (N => 2*N)
    port map (
        e1 => My_mux_e1,
        e2 => My_mux_e2,
        sel => sel,
        s1 => s1
    );

    My_mux_e2 <= My_mult_s1;

    My_mux_e1(N-1 downto 0) <= My_add_s1;
    My_mux_e1(N) <= My_c_out;
    My_mux_e1(2*N-1 downto N+1) <= (others => '0');

end synthcomb01_arch;