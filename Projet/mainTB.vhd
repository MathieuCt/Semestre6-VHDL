library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;


entity mainTB is 
end;

architecture mainTB_arch of mainTB is
    component main
        port(
            Clock : in std_logic;
            RESET : in std_logic;
            SR_IN_L : in std_logic;
            SR_IN_R : in std_logic;
            A_IN : in signed(3 downto 0);
            B_IN : in signed(3 downto 0);
            SR_OUT_L : out std_logic;
            SR_OUT_R : out std_logic;
            RES_OUT : out signed(7 downto 0)
        );
    end component;
    begin 
        mainComponent : main
            port map(
                Clock => Clock,
                RESET => RESET,
                SR_IN_L => SR_IN_L,
                SR_IN_R => SR_IN_R,
                A_IN => A_IN,
                B_IN => B_IN,
                SR_OUT_L => SR_OUT_L,
                SR_OUT_R => SR_OUT_R,
                RES_OUT => RES_OUT
            );
        clock_proc: process
            begin
                clock_sim <= '1';
                wait for 100 us;
                clock_sim <= '0';
                wait for 100 us;
                if now = 20000 us then
                    wait;
                end if;
            end process;
        mainprocess :process
