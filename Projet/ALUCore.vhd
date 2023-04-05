library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;

entity ALUCore is
    port (
        a, b: in std_logic_vector(3 downto 0);
        sel: in std_logic_vector(3 downto 0);
        s : out std_logic_vector (7 downto 0) := (others => '0');
        SR_IN_R : in std_logic;
        SR_IN_L : in std_logic;
        SR_OUT_R : out std_logic := '0';
        SR_OUT_L : out std_logic := '0'
    );
end ALUCore;
architecture ALUCore_dataFlow of ALUCore is
    signal My_a: unsigned(3 downto 0);
    signal My_b: unsigned(3 downto 0);
    signal My_s : unsigned(7 downto 0);
begin
    My_a <= unsigned(a);
    My_b <= unsigned(b);
    s <= std_logic_vector(My_s);
    main : process (My_a, My_b, sel)
    variable i: unsigned(3 downto 0);
    begin
        case sel is
            when "0000" => 
                My_s(7 downto 0) <= (others => '0');
            when "0001" =>
                My_s <= resize(My_a - My_b, 2*4);
            when "0010" =>
                My_s <= resize(My_a * My_b, 2*4);
            when "0011" => 
                SR_OUT_R <= My_a(0);
                i := My_a(2 downto 0) & '0';
                i(3) := SR_IN_L;
                My_s <= "0000" & i;
            when "0100" =>
                SR_OUT_L <= My_a(3);
                i := My_a(2 downto 0) & '0';
                i(0) := SR_IN_R;
                My_s <= "0000" & My_a;
            when "0101" =>
                SR_OUT_R <= My_b(0);
                i := My_b(2 downto 0) & '0';
                i(3) := SR_IN_L;
                My_s <= "0000" & My_b;
            when "0110" =>
                SR_OUT_L <= My_b(3);
                i := My_b(2 downto 0) & '0';
                i(0) := SR_IN_R;
                My_s <=  "0000" & My_b;
            when "0111" => 
                My_s <= resize(My_a, 8);
            when "1000" =>
                My_s <= resize(My_b, 8);
            when "1001" =>
                My_s <= not resize(My_a, 8);
            when "1010" =>
                My_s <= not resize(My_b, 8);
            when "1011" =>
                My_s <= resize(My_a and My_b, 8);
            when "1100" =>
                My_s <= resize(My_a or My_b, 8);
            when "1101" => 
                My_s <= resize(My_a xor My_b, 8);
            when "1110" => 
                if SR_IN_R = '1' then
                    My_s <= resize(My_a + My_b, 8);
                else
                    My_s <= resize(My_a + My_b, 8);
                end if;
            when "1111" =>
                My_s <= resize(My_a + My_b, 8);
            when others => 
                My_s <= (others => '0');
        end case;
    end process main;

end ALUCore_dataFlow;
