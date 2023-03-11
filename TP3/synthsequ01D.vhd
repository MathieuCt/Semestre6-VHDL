library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity synthsequ01 is
    generic(
        N : integer:= 3
    );
    port(
        clock : in std_logic;
        reset : in std_logic;
        s1 : out std_logic_vector (2*N-1 downto 0)
    );
end synthsequ01;

architecture synthsequ01_arch of synthsequ01 is

    component mysynthcomb01
    generic (N : integer);
    port(
        e1 : in std_logic_vector (N-1 downto 0);
        e2 : in std_logic_vector (N-1 downto 0);
        c_in : in std_logic;
        sel : in std_logic;
        s1 : out std_logic_vector(2*N-1 downto 0)
    );
    end component;
    signal My_synthcomb01_s1 : std_logic_vector (2*N-1 downto 0);

    component bufferNbits is
        generic (N : integer);
        port(
            e1 : in std_logic_vector (N-1 downto 0);
            reset : in std_logic;
            preset : in std_logic;
            clock : in std_logic;
            s1 : out std_logic_vector (N-1 downto 0)
        );
    end component;
    signal My_bufferNbits_s1 : std_logic_vector (2*N-1 downto 0);

    component comptdecompNbits is
        generic( N : integer);
        port(
            reset : in std_logic;
            cpt : in std_logic;
            clock : in std_logic;
            s1 : out std_logic_vector (N-1 downto 0)
        );
    end component;
    signal My_comptdecompNbits_s1 : std_logic_vector (2*N+1 downto 0);
    signal My_cpt, my_reset : std_logic;

    type t_SM_Test is (S0_INITCPT, S1_CPT, S2_INITDCPT, S3_DCPT, S4_END);
    signal r_SM_Test : t_SM_Test := S0_INITCPT;

    begin
        MyComponentsynthcomb01 : mysynthcomb01
        generic map ( N => N )
        port map(
            e1 => My_comptdecompNbits_s1(N-1 downto 0),
            e2 => My_comptdecompNbits_s1(2*N-1 downto N),
            c_in => My_comptdecompNbits_s1(2*N),
            sel => My_comptdecompNbits_s1(2*N+1),
            s1 => My_synthcomb01_s1
        );

        MycomponentbufferNbits : bufferNbits
        generic map ( N => 2*N )
        port map(
            e1 => My_synthcomb01_s1,
            reset => reset,
            preset => '0',
            clock => clock,
            s1 => My_bufferNbits_s1
        );
        s1 <= My_bufferNbits_s1;

        MycomponentcomptdecompNbits : comptdecompNbits
        generic map ( N => 2*N +2)
        port map(
            reset => my_reset,
            clock => clock,
            cpt => my_cpt,
            s1 => My_comptdecompNbits_s1
        );


        myAutomateProc : process (reset, clock)
            variable compteur_interne : integer := 0;
        begin
            if (reset = '1') then
                r_SM_Test <= S0_INITCPT;
                compteur_interne := 0;
            elsif rising_edge(clock) then
                case r_SM_Test is
                    when S0_INITCPT =>
                        r_SM_Test <= S1_CPT;
                        compteur_interne := 0;
                    when S1_CPT =>
                        if (compteur_interne = 4+(2**(2*N+2))) then
                            r_SM_Test <= S4_END;
                            compteur_interne := 0;
                        else
                            r_SM_Test <= S1_CPT;
                            compteur_interne := compteur_interne + 1;
                        end if ;
                    when S4_END =>
                            r_SM_Test <= S4_END;
                            compteur_interne := 0;
                    when others =>
                            r_SM_Test <= S0_INITCPT;
                            compteur_interne := 0;
                end case ;
            end if;
        end process;
        
        my_reset <= '1' when r_SM_Test = S0_INITCPT or r_SM_Test = S4_END else '0';
        my_cpt <= '1' when r_SM_Test = S0_INITCPT or r_SM_Test = S1_CPT or r_SM_Test = S4_END else '0';

end synthsequ01_arch;