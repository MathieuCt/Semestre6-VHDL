library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;

entity main is
    port(
        Clock : in std_logic;
        RESET : in std_logic;
        SR_IN_L : in std_logic;
        SR_IN_R : in std_logic;
        A_IN : in std_logic_vector(3 downto 0);
        B_IN : in std_logic_vector(3 downto 0);
        SR_OUT_L : out std_logic;
        SR_OUT_R : out std_logic;
        RES_OUT : out std_logic_vector(7 downto 0)
    );
end main;

architecture main_arch of main is 
    component bufferNbits is
        generic(N : integer);
        port(
            Clock : in std_logic;
            RESET : in std_logic;
            e : in std_logic_vector;
            s : out std_logic_vector
        );
    end component;
    component ALU is
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
    end component;
    component MEM_INSTRUCTIONS is
        port(
            Clock: in std_logic;
            reset: in std_logic;
            SEL_ROUTE : out std_logic_vector(3 downto 0);
            SEL_FCT : out std_logic_vector(3 downto 0);
            SEL_OUT : out std_logic_vector(1 downto 0)
        );
    end component;
    type bufferPortType is record
        e : std_logic_vector;
        reset : std_logic;
        s : std_logic_vector;
    end record;
    signal MEM_SEL_FCT_P : bufferPortType(e(3 downto 0),s(3 downto 0));
    signal MEM_SEL_OUT_P : bufferPortType(e(1 downto 0),s(1 downto 0));
    signal mySEL_ROUTE : std_logic_vector(3 downto 0);
    begin
        MEM_INSTRUCTIONS1 : MEM_INSTRUCTIONS
        port map(
            Clock => Clock,
            reset => RESET,
            SEL_ROUTE => mySEL_ROUTE,
            SEL_FCT => MEM_SEL_FCT_P.e,
            SEL_OUT => MEM_SEL_OUT_P.e
        );

        ALU1 : ALU
        port map(
            SEL_ROUTE => MySEL_ROUTE,
            SEL_FCT => MEM_SEL_FCT_P.s,
            SEL_OUT => MEM_SEL_OUT_P.s,
            Clock => Clock,
            SR_IN_L => SR_IN_L,
            SR_IN_R => SR_IN_R,
            A_IN => A_IN,
            B_IN => B_IN,
            SR_OUT_L => SR_OUT_L,
            SR_OUT_R => SR_OUT_R,
            RES_OUT => RES_OUT,
            reset => RESET
        );
        MEM_SEL_FCT : bufferNBits
        generic map(N => 4)
        port map(
            e => MEM_SEL_FCT_P.e,
            reset => MEM_SEL_FCT_P.reset,
            clock => Clock,
            s => MEM_SEL_FCT_P.s
        );
        MEM_SEL_OUT : bufferNBits
        generic map(N => 2)
        port map(
            e => MEM_SEL_OUT_P.e,
            reset => MEM_SEL_OUT_P.reset,
            clock => Clock,
            s => MEM_SEL_OUT_P.s
        );

    end main_arch;
