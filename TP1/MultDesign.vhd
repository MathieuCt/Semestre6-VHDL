library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity multNbits is
    generic (N: integer := 4);
    port (
        e1, e2: in std_logic_vector(N-1 downto 0);
        s1 : out std_logic_vector(2*N-1 downto 0)
    );
end multNbits;

architecture multNbits_dataFlow of multNbits is
    signal My_e1 : std_logic_vector(N-1 downto 0);
    signal My_e2 : std_logic_vector(N-1 downto 0);
    signal My_s1 : std_logic_vector(2*N-1 downto 0);

begin
    My_e1 <= e1;
    My_e2 <= e2;
    s1 <= My_s1;
    My_s1 <= My_e1 * My_e2;
end multNbits_dataFlow;
