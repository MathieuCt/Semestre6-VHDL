--code your design here
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity OR2 is
    Port (e1,e2: in STD_LOGIC;
          s1: out STD_LOGIC);
end OR2;

architecture OR2_DataFlow of OR2 is
begin
    MyOR2ProcessFlag : process (e1,e2)
    begin
        s1 <= e1 or e2;
    end process;

end OR2_DataFlow;
