library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Project_digital is
    Port (
        reset, clk: in std_logic;
        M: in std_logic_vector (2 downto 0); -- rotubat
        L, T: in std_logic; -- dama v noor
        seg: out std_logic_vector (7 downto 0);
        final_state: out std_logic_vector (1 downto 0);
        watering: inout std_logic
    );
end Project_digital;

architecture Behavioral of Project_digital is

    component Seven_Seg is
        port (
            watering_seg: in std_logic;
            seg7: out std_logic_vector (7 downto 0)
        );
    end component;

    type TandL is (ideal, notideal);
    signal TwithL: TandL;
    type states is (st0, st1, st2);
    signal state, next_state: states;

begin

    SS : Seven_Seg 
    port map (
        watering_seg => watering,
        seg7 => seg
    );
    
    process (reset, clk)
    begin
        if reset = '1' then
            state <= st2;
        elsif rising_edge(clk) then
            state <= next_state;
        end if;
    end process;

    process (T, L)
    begin
        if T = '0' and L = '0' then
            TwithL <= ideal; 
        elsif T = '1' or L = '1' then
            TwithL <= notideal;
        end if;
    end process;
 
    process (M, TwithL)
    begin
        case state is
            when st0 =>
                if M > "011" and TwithL = ideal then
                    next_state <= st0;
                elsif M <= "011" and TwithL = ideal then
                    next_state <= st1;
                elsif M <= "001" and TwithL = notideal then
                    next_state <= st1; 
                else
                    next_state <= st0;
                end if;
            when st1 =>
                if M < "111" and TwithL = ideal then
                    next_state <= st1;
                elsif M >= "111" and TwithL = ideal then
                    next_state <= st0;
                elsif M < "011" and TwithL = notideal then
                    next_state <= st1; 
                else
                    next_state <= st0;
                end if;
            when st2 =>
                next_state <= st0;
        end case;      
    end process;

    process (state)
    begin
        case state is
            when st0 =>
                final_state <= "00";
                watering <= '0';
            when st1 =>
                final_state <= "01";
                watering <= '1';
            when st2 => 
                final_state <= "11";
                watering <= '0';
        end case;      
    end process;

end Behavioral;
