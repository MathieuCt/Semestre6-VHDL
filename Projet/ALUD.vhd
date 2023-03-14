library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
    generic (N: integer := 4);
    port (
        a, b: in signed(N-1 downto 0);
        sel: in std_logic_vector(N-1 downto 0);
        s : out signed(2*N-1 downto 0);
        SR_IN_R : in std_logic;
        SR_IN_L : in std_logic;
        SR_OUT_R : out std_logic := '0';
        SR_OUT_L : out std_logic := '0'
    );
end ALU;
architecture ALU_dataFlow of ALU is
Signal selSeg : unsigned(N-1 downto 0);
begin
    main : process(a, b, sel)
    begin
        selSeg <= unsigned(sel); 
        case selSeg is
            when "0000" =>
                s <= (others:=0);
            when "0001" => 
                SR_OUT_R <= a[0];
                a2 = a/2;
                a2[N-1] <= SR_IN_L;
                s <= a2;
            when "0010" =>
                SR_OUT_L <= a[N-1];
                a2 = a*2;
                a2[0] <= SR_IN_R;
                s <= a2;
            when "0011" =>
                SR_OUT_R <= a[0];
                a2 = a/2;
                a2[N-1] <= SR_IN_L;
                s <= a2;
            when "0100" =>
                SR_OUT_L <= b[N-1];
                b2 = b*2;
                b2[0] <= SR_IN_R;
                s <= b2;
            when "0101" => 
                s <= a;
            when "0110" =>
                s <= b;
            when "0111" =>
                s <= not a;
            when "1000" =>
                s <= not b;
            when "1001" =>
                s <= a and b;
            when "1010" =>
                s <= a or b;
            when "1011" => 
                s <= a xor b;
            when "1100" => 
                s <= a + b + SR_IN_R;
            when "1101" =>
                s <= a + b;
            when "1110" =>
                s <= a - b;
            when "1111" =>
                s <= a * b;
            when others => s <= (others => '0');
        end case;
    end process main;

end ALU_dataFlow;
