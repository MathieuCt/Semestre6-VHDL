library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
    port(
        SEL_ROUTE : in std_logic_vector(3 downto 0);
        SEL_OUT : in std_logic_vector(1 downto 0);
        SEL_FCT : in std_logic_vector(3 downto 0);
        Clock : in std_logic;
        reset : in std_logic;
        SR_IN_L : in std_logic;
        SR_IN_R : in std_logic;
        A_IN : in std_logic_vector(3 downto 0);
        B_IN : in std_logic_vector(3 downto 0);
        SR_OUT_L : out std_logic;
        SR_OUT_R : out std_logic;
        RES_OUT : out std_logic_vector(7 downto 0)
    );
end ALU;

architecture ALU_arch of ALU is
    component bufferNBits is
        generic(N: integer);
        port(
            e : in std_logic_vector (N-1 downto 0);
            reset : in std_logic;
            Clock : in std_logic;
            s : out std_logic_vector (N-1 downto 0)
        );
    end component;
    component ALUCore is
        port(
            a, b: in std_logic_vector(3 downto 0);
            sel: in std_logic_vector(3 downto 0);
            s : out std_logic_vector(7 downto 0) := (others => '0');
            SR_IN_R : in std_logic;
            SR_IN_L : in std_logic;
            SR_OUT_R : out std_logic := '0';
            SR_OUT_L : out std_logic := '0'
        );
    end component;
type bufferPortType is record
    e : std_logic_vector;
    reset : std_logic;
    s : std_logic_vector;
end record;
signal Buffer_A_P, Buffer_B_P : bufferPortType(e(3 downto 0),s(3 downto 0));
signal MEM_CACHE1_P, MEM_CACHE2_P : bufferPortType(e(7 downto 0), s(7 downto 0));
signal SR_IN_R_BUFFER_P, SR_IN_L_BUFFER_P : bufferPortType(e(0 downto 0), s(0 downto 0));
signal mya, myb : std_logic_vector(3 downto 0);
signal mysel : std_logic_vector(3 downto 0);
signal myres : std_logic_vector(7 downto 0);
signal mySR_IN_R, mySR_IN_L : std_logic;
signal mySR_OUT_R, mySR_OUT_L : std_logic;
begin
    MyALUCore : ALUCore
        generic map(N => 4)
        port map(
            a => mya,
            b => myb,
            sel => SEL_FCT,
            s => myres,
            SR_IN_R => mySR_IN_R,
            SR_IN_L => mySR_IN_L,
            SR_OUT_R => mySR_OUT_R,
            SR_OUT_L => mySR_OUT_L
    );

    Buffer_A : bufferNBits
        generic map(N => 4)
        port map(
            e => Buffer_A_P.e,
            reset => Buffer_A_P.reset,
            clock => clock,
            s => Buffer_A_P.s
        );
    Buffer_B : bufferNBits
        generic map(N => 4)
        port map(
            e => Buffer_B_P.e,
            reset => Buffer_B_P.reset,
            clock => clock,
            s => Buffer_B_P.s
        );
    MEM_CACHE1 : bufferNBits
        generic map(N => 8)
        port map(
            e => MEM_CACHE1_P.e,
            reset => MEM_CACHE1_P.reset,
            clock => clock,
            s => MEM_CACHE1_P.s
        );
    MEM_CACHE2 : bufferNBits
        generic map(N => 8)
        port map(
            e => MEM_CACHE2_P.e,
            reset => MEM_CACHE2_P.reset,
            clock => clock,
            s => MEM_CACHE2_P.s
        );
    SR_IN_R_BUFFER : bufferNBits
        generic map(N => 1)
        port map(
            e => SR_IN_R_BUFFER_P.e,
            reset => SR_IN_R_BUFFER_P.reset,
            clock => clock,
            s => SR_IN_R_BUFFER_P.s
        );
    SR_IN_L_BUFFER : bufferNBits
        generic map(N => 1)
        port map(
            e => SR_IN_L_BUFFER_P.e,
            reset => SR_IN_L_BUFFER_P.reset,
            clock => clock,
            s => SR_IN_L_BUFFER_P.s
        );
    mya <= Buffer_A_P.s;
    myb <= Buffer_B_P.s;
    mySR_IN_R <= SR_IN_R_BUFFER_P.s;
    mySR_IN_L <= SR_IN_L_BUFFER_P.s;
    process(Clock)
    begin
        if rising_edge(Clock) then
            case SEL_ROUTE is 
                when "0000" =>
                    MEM_CACHE2_P.e <= std_logic_vector(myres);
                when "0001" =>
                    Buffer_A_P.e <= MEM_CACHE1_P.s(3 downto 0);
                when "0010" =>
                    Buffer_A_P.e <= MEM_CACHE1_P.s(7 downto 4);
                when "0011" =>
                    Buffer_A_P.e <= MEM_CACHE2_P.s(3 downto 0);
                when "0100" =>
                    Buffer_A_P.e <= MEM_CACHE2_P.s(7 downto 4);
                when "0101" =>
                    Buffer_A_P.e <= std_logic_vector(myres(3 downto 0));
                when "0110" =>
                    Buffer_A_P.e <= std_logic_vector(myres(7 downto 4));
                when "0111" =>
                    buffer_B_P.e <= std_logic_vector(B_IN);
                when "1000" =>
                    MEM_CACHE1_P.e <= std_logic_vector(myres);
                when "1001" =>
                    Buffer_B_P.e <= MEM_CACHE1_P.s(3 downto 0);
                when "1010" =>
                    Buffer_B_P.e <= MEM_CACHE1_P.s(7 downto 4);
                when "1011" =>
                    Buffer_B_P.e <= MEM_CACHE2_P.s(3 downto 0);
                when "1100" =>
                    Buffer_B_P.e <= MEM_CACHE2_P.s(7 downto 4);
                when "1101" =>
                    Buffer_B_P.e <= std_logic_vector(myres(3 downto 0));
                when "1110" =>
                    Buffer_B_P.e <= std_logic_vector(myres(7 downto 4));
                when "1111" =>
                    Buffer_A_P.e <= A_IN;
                when others =>
                    null;
            end case;
        end if;
        if falling_edge(Clock) then
            case SEL_OUT is
                when "00" =>
                    RES_OUT <= (others => '0');
                when "01" =>
                    RES_OUT <= MEM_CACHE1_P.s;
                when "10" =>
                    RES_OUT <= MEM_CACHE2_P.s;
                when "11" =>
                    RES_OUT <= myres;
                when others =>
                    null;
            end case;
        end if;
    end process;
end ALU_arch;