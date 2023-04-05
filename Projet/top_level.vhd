

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MCU_PRJ_2022_TopLevel is
    Port (
        CLK100MHZ : in STD_LOGIC;
        sw : in STD_LOGIC_VECTOR(3 downto 0);
        btn : in STD_LOGIC_VECTOR(3 downto 0);
        led : out STD_LOGIC_VECTOR(3 downto 0);
        led0_r : out STD_LOGIC; led0_g : out STD_LOGIC; led0_b : out STD_LOGIC;                
        led1_r : out STD_LOGIC; led1_g : out STD_LOGIC; led1_b : out STD_LOGIC;
        led2_r : out STD_LOGIC; led2_g : out STD_LOGIC; led2_b : out STD_LOGIC;                
        led3_r : out STD_LOGIC; led3_g : out STD_LOGIC; led3_b : out STD_LOGIC
    );
end MCU_PRJ_2022_TopLevel;

architecture Behavioral of MCU_PRJ_2022_TopLevel is
    component ALUCore is
        generic(N : integer);
        port(
            a, b: in signed(N-1 downto 0);
            sel: in std_logic_vector(3 downto 0);
            s : out signed(2*N-1 downto 0) := (others => '0');
            SR_IN_R : in std_logic;
            SR_IN_L : in std_logic;
            SR_OUT_R : out std_logic := '0';
            SR_OUT_L : out std_logic := '0'
        );
    end component ALUCore;
    
    signal my_led_out : std_logic_vector (7 downto 0);
begin

    MyUalCoreInst : ALUCore
    Port Map ( a => sw,
            b => sw,
            SR_IN_L => sw(3),
            SR_IN_R => sw(0),
            s => my_led_out,
            SR_OUT_L => led3_r,
            SR_OUT_R => led0_r,
            sel => btn
    );
    
    --Traitement de mes leds vertes pour rS
    led (3 downto 0) <= my_led_out(7 downto 4);
    led3_g <= my_led_out(3);
    led2_g <= my_led_out(2);
    led1_g <= my_led_out(1);
    led0_g <= my_led_out(0);
    
    --Traitement des leds non utilisées
    led0_b <= '0';
    led1_r <= '0'; led1_b <= '0';
    led2_r <= '0'; led2_b <= '0';
    led3_r <= '0'; led3_b <= '0';

end Behavioral;
