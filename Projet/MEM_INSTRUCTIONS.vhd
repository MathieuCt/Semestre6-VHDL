library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;


entity MEM_INSTRUCTIONS is
    port(
        Clock: in std_logic;
        reset: in std_logic;
        SEL_ROUTE : out std_logic_vector(3 downto 0);
        SEL_FCT : out std_logic_vector(3 downto 0);
        SEL_OUT : out std_logic_vector(1 downto 0)
    );
end MEM_INSTRUCTIONS;

architecture MEM_INSTRUCTIONS_Arch of MEM_INSTRUCTIONS is
    type mem is array (0 to 127) of std_logic_vector(9 downto 0);
    signal pt : integer range 0 to 127 := 0 ;
    constant MEM_INSTRUCTIONS: mem := (
        ("0000000000"),
        ("0000111100"),
        ("0000011100"),
        ("1011000011"),
        ("0000100000"),
        ("0000111100"),
        ("0000011100"),
        ("1011000011"),
        ("0000010100"),
        ("0000100100"),
        ("1100000011"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000000000")
    );
begin
    process(Clock)
    begin
        if falling_edge(Clock) then
            if reset = '1' then
                pt <= 0;
            else
                pt <= pt + 1;
            end if;
        end if;
    end process;

    SEL_FCT <= MEM_INSTRUCTIONS(pt)(9 downto 6);
    SEL_ROUTE <= MEM_INSTRUCTIONS(pt)(5 downto 2);
    SEL_OUT <= MEM_INSTRUCTIONS(pt)(1 downto 0);
end MEM_INSTRUCTIONS_Arch;



