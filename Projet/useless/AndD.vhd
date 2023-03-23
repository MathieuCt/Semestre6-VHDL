--code your design here
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AND2 is
    Port (e1,e2: in STD_LOGIC;
          s1: out STD_LOGIC);
end AND2;

architecture AND2_DataFlow of AND2 is
begin
    MyAND2ProcessFlag : process (e1,e2)
    begin
        s1 <= e1 and e2;
    end process;

end AND2_DataFlow;
