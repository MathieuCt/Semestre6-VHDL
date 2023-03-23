--code your design here
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity NOT2 is
    Port (e1: in STD_LOGIC;
          s1: out STD_LOGIC);
end NOT2;

architecture NOT2_DataFlow of NOT2 is
begin
    MyNOT2ProcessFlag : process (e1)
    begin
        s1 <= not e1;
    end process;

end NOT2_DataFlow;
