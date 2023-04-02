library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity bufferNbits  is
    generic(
        N : integer := 4
        );
    port(
        e : in std_logic_vector (N-1 downto 0);
        reset : in std_logic;
        clock : in std_logic;
        s : out std_logic_vector (N-1 downto 0)
    );
end bufferNbits;

architecture buffer_Arch of bufferNbits is
    begin
        MyBufferNbitsProc : process (reset, clock)
        begin
            if (reset = '1') then
                s <= (others => '0');
            elsif (rising_edge(clock)) then
                s <= e;
            end if;
        end process;
end buffer_Arch;