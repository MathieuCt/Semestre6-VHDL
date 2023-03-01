library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity muxNbits2vers1 is
    generic (N: integer := 4);
    port (e1, e2: in STD_LOGIC_VECTOR (N-1 downto 0);
          sel: in STD_LOGIC;
          s1: out STD_LOGIC_VECTOR (N-1 downto 0)
        );
end;

architecture muxNbits2vers1_Dataflow of muxNbits2vers1 is

    begin 
    MyMux2vers1Proc : process (e1, e2, sel)
        begin
            if sel = '0' then
                s1 <= e1;
            else
                s1 <= e2;
            end if;
        end process;
end muxNbits2vers1_Dataflow;
