library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;


entity comptdecompNbits is
    generic(
        N : integer := 4
    );
    port(
        reset : in std_logic;
        cpt : in std_logic;
        clock : in std_logic;
        s1 : out std_logic_vector (N-1 downto 0)
    );
end comptdecompNbits;

architecture comptdecompNbits_arch of comptdecompNbits is
    signal mycompteur : std_logic_vector (N-1 downto 0):= (others => '0');

    begin
        MycompteurNbitsProc : process(reset,clock)
        begin
            if (reset = '1') then
                mycompteur <= (others => '0');
                report "Reset";
            elsif (rising_edge(clock)) then
                mycompteur <= mycompteur + 1;
                report "Compteur : " & integer'image(to_integer(unsigned(mycompteur)));
            end if;
        end process;

        s1 <= mycompteur when reset = '1' or cpt = '1'else not mycompteur;

end comptdecompNbits_arch;