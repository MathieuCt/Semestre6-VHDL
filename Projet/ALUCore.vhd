library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;

entity ALUCore is
    generic (N: integer := 4);
    port (
        a, b: in signed(N-1 downto 0);
        sel: in std_logic_vector(3 downto 0);
        s : out signed(2*N-1 downto 0) := (others => '0');
        SR_IN_R : in std_logic;
        SR_IN_L : in std_logic;
        SR_OUT_R : out std_logic := '0';
        SR_OUT_L : out std_logic := '0'
    );
end ALUCore;
architecture ALUCore_dataFlow of ALUCore is
begin
    main : process (a, b, sel)
    variable My_a, My_b : signed(N-1 downto 0);
    variable My_c : signed(N-1 downto 0);
    variable My_N : integer := N;
    begin
        case sel is
            when "0000" => 
                s(2*N-1 downto 0) <= (others => '0');
            when "0011" => 
                SR_OUT_R <= a(0);
                My_a := a(2 downto 0) & '0';
                My_a(My_N-1) := SR_IN_L;
                s <= "0000" & My_a;
            when "0100" =>
                SR_OUT_L <= a(My_N-1);
                My_a := a(2 downto 0) & '0';
                My_a(0) := SR_IN_R;
                s <= "0000" & My_a;
            when "0101" =>
                SR_OUT_R <= b(0);
                My_b := b(2 downto 0) & '0';
                My_b(My_N-1) := SR_IN_L;
                s <= "0000" & My_b;
            when "0110" =>
                SR_OUT_L <= b(My_N-1);
                My_b := b(2 downto 0) & '0';
                My_b(0) := SR_IN_R;
                s <=  "0000" & My_b;
            when "0111" => 
                s <= resize(a, 2*N);
            when "1000" =>
                s <= resize(b, 2*N);
            when "1001" =>
                s <= not resize(a, 2*N);
            when "1010" =>
                s <= not resize(b, 2*N);
            when "1011" =>
                s <= resize(a and b, 2*N);
            when "1100" =>
                s <= resize(a or b, 2*N);
            when "1101" => 
                s <= resize(a xor b, 2*N);
            when "1110" => 
                if SR_IN_R = '1' then
                    s <= resize(a + b, 2*N);
                else
                    s <= resize(a + b, 2*N);
                end if;
            when "1111" =>
                s <= resize(a + b, 2*N);
            when "0001" =>
                s <= resize(a - b, 2*N);
            when "0010" =>
                s <= resize(a * b, 2*N);
            when others => 
                s <= (others => '0');
        end case;
    end process main;

end ALUCore_dataFlow;