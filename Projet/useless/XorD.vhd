--code your design here
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity XOR2 is
    Port (e1,e2: in STD_LOGIC;
          s1: out STD_LOGIC);
end XOR2;

architecture XOR2_DataFlow of XOR2 is
begin
    MyXOR2ProcessFlag : process (e1,e2)
    begin
        s1 <= e1 xor e2;
    end process;

end XOR2_DataFlow;
