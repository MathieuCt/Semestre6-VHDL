--code your design here
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity NOP2 is
    Port (s1: out STD_LOGIC);
end NOP2;

architecture NOP2_DataFlow of NOP2 is
begin
    MyNOP2ProcessFlag : process (s1)
    begin
        s1 <= 0;
    end process;

end NOP2_DataFlow;
