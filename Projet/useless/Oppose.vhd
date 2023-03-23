library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Oppose is
    Port (e: in signed(4 downto 0);
          s: out signed(4 downto 0));
end Oppose;

architecture Oppose_DataFlow of Oppose is
begin
    OpposeProc : process (e)
    begin
        s <= -e ;
    end process;

end Oppose_DataFlow;
