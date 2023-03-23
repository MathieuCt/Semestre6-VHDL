-- Code your test bench here
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

-- Déclaration d'une entité pour la simulation sans port d'entrée et de sortie
entity myAnd2testbench is 
end myAnd2testbench;

architecture myAnd2testbench_Arch of myAnd2testbench is
    -- Déclaration des composants à tester -> renvoie vers l'entité AND2
    component AND2
        port (e1, e2 : in STD_LOGIC;
              s1 : out STD_LOGIC);
    end component;
    
    -- Déclaration des signaux internes à l'architecture pour réaliser les simulations
    signal e1_sim, e2_sim : STD_LOGIC := '0'; -- valeur par défaut 0
    signal s1_sim : STD_LOGIC := '0'; 
begin
    -- Instantiatin du composant à tester
    MyComponantAnd2underTest : AND2
        port map (e1 => e1_sim, e2 => e2_sim, s1 => s1_sim);

    --Definition du process  permettant de faire évoluer les sigtnaux d'entrée du composant à tester 
    --MyStimulus_e1_sim_e2_sim_Proc : process -- Pas de liste de sensibilité
    --begin
        -- Initialisation des signaux d'entrée
        --e1_sim <= '0';
        --e2_sim <= '0';
        --wait for 100 us; -- Attente de 100 us
        --assert s1_sim = (e1_sim and e2_sim) report "e1_sim =" & std_logic'image(e1_sim) & " | e2_sim =" & std_logic'image(e2_sim) & " | s1_sim =" & std_logic'image(s1_sim) severity failure;
        --e1_sim <= '0';
        --e2_sim <= '1';
        --wait for 100 us;
        --assert s1_sim = (e1_sim and e2_sim) report "e1_sim =" & std_logic'image(e1_sim) & " | e2_sim =" & std_logic'image(e2_sim) & " | s1_sim =" & std_logic'image(s1_sim) severity failure;
        --e1_sim <= '1';
        --e2_sim <= '0';
        --wait for 100 us;
        --assert s1_sim = (e1_sim and e2_sim) report "e1_sim =" & std_logic'image(e1_sim) & " | e2_sim =" & std_logic'image(e2_sim) & " | s1_sim =" & std_logic'image(s1_sim) severity failure;
        --e1_sim <= '1';
        --e2_sim <= '1';
        --wait for 100 us;
        --assert s1_sim = (e1_sim and e2_sim) report "e1_sim =" & std_logic'image(e1_sim) & " | e2_sim =" & std_logic'image(e2_sim) & " | s1_sim =" & std_logic'image(s1_sim) severity failure;
        -- Fin du process
        --report "testg ok (no assert)";
        --wait;
    --end process;
    Mystimulus_e1e2Input_Proc2 : process -- Pas de liste de sensibilité
    begin
        for i in 0 to 1 loop
            for j in 0 to 1 loop 
                e1_sim <= to_unsigned(i,1)(0);
                e2_sim <= to_unsigned(j,1)(0);
                wait for 100 us;
                assert s1_sim = (e1_sim and e2_sim) report "e1_sim =" & std_logic'image(e1_sim) & " | e2_sim =" & std_logic'image(e2_sim) & " | s1_sim =" & std_logic'image(s1_sim) severity failure;
            end loop;
        end loop;
        report "test ok (no assert)";
        wait;
    end process;
end myAnd2testbench_Arch;