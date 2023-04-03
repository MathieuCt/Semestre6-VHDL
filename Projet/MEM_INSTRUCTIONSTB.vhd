library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MEM_INSTRUCTIONSTB is
end MEM_INSTRUCTIONSTB;

architecture MEM_INSTRUCTIONSTB_Arch of MEM_INSTRUCTIONSTB is
    component MEM_INSTRUCTIONS is
        port(
            Clock: in std_logic;
            reset: in std_logic;
            SEL_ROUTE : out std_logic_vector(3 downto 0);
            SEL_FCT : out std_logic_vector(3 downto 0);
            SEL_OUT : out std_logic_vector(1 downto 0)
        );
    end component MEM_INSTRUCTIONS;
    signal reset_sim, clock_sim : std_logic;
    signal SEL_ROUTE_sim, SEL_FCT_sim : std_logic_vector(3 downto 0);
    signal SEL_OUT_sim : std_logic_vector(1 downto 0);
begin
    
    MEM: MEM_INSTRUCTIONS 
        port map(
            Clock => clock_sim,
            reset => reset_sim,
            SEL_ROUTE => SEL_ROUTE_sim,
            SEL_FCT => SEL_FCT_sim,
            SEL_OUT => SEL_OUT_sim
        );
    clock_poc: process
    begin
        clock_sim <= '1';
        report "(TB)SEL_FCT = " & integer'image(to_integer(unsigned(SEL_FCT_sim)));
        report "(TB)SEL_ROUTE = " & integer'image(to_integer(unsigned(SEL_ROUTE_sim)));
        report "(TB)SEL_OUT = " & integer'image(to_integer(unsigned(SEL_OUT_sim)));
        wait for 100 us;
        clock_sim <= '0';
        wait for 100 us;
        if now = 20000 us then
            wait;
        end if;
    end process;
end MEM_INSTRUCTIONSTB_Arch;
