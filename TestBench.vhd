LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

ENTITY Testbench IS
END Testbench;

ARCHITECTURE behavior OF Testbench IS 

 -- COMPONENT Declaration for the Unit Under Test (UUI) 
 COMPONENT WateringSystem
 PORT(
    reset,clk: in std_logic;
    M: in std_logic_vector (2 downto 0);      --rotubat
    L,T: in bit;                              --dama v noor
    seg: out std_logic_vector (7 downto 0);
    final_state: out bit_vector (1 downto 0);
    watering : inout bit
 );
 END COMPONENT;
 
 --Inputs
 signal clk1 : std_logic := '0';
 signal reset1 : std_logic := '0';
 signal M1 : std_logic_vector(2 downto 0) := (others => '0');
 signal L1 : bit := '0';
 signal T1 : bit := '0';
 
--Outputs
 signal seg1 : std_logic_vector(7 downto 0) := (others => '0');
 signal final_state1 : bit_vector (1 downto 0):= (others => '0');
 signal watering1 : bit := '0';
 
BEGIN

-- Instantiate the Unit Under Test (UUI)
uut: WateringSystem PORT MAP (
    reset => reset1,
    clk => clk1,
    M => M1,
    L => L1,
    T => T1,
    seg => seg1,
    final_state => final_state1,
    watering => watering1
);

-- Stimulus process
ClockGenerator: process
begin

-- insert stimulus
M1 <= "100";
L1 <= '0';
T1 <= '0';
--wait for 10 ns;

M1 <= "011" after 10 ns; --3
L1 <= '0' after 10 ns;
T1 <= '0' after 10 ns;
--wait for 10 ns;

M1 <= "001" after 20 ns; --1
L1 <= '1' after 20 ns;
T1 <= '1' after 20 ns;
--wait for 10 ns;

M1 <= "010" after 30 ns; --2
L1 <= '1' after 30 ns;
T1 <= '0' after 30 ns;
--wait for 10 ns;

M1 <= "110" after 40 ns; --6
L1 <= '0' after 40 ns;
T1 <= '0' after 40 ns;
--wait for 10 ns;

M1 <= "111" after 50 ns; --7
L1 <= '0' after 50 ns;
T1 <= '0' after 50 ns;
--wait for 10 ns;

M1 <= "010" after 60 ns; --2
L1 <= '1' after 60 ns;
T1 <= '0' after 60 ns;
--wait for 10 ns;

M1 <= "011" after 70 ns; --3
L1 <= '0' after 70 ns;
T1 <= '1' after 70 ns;
--wait for 10 ns;

reset1 <= '1' , '0' after 1 ns ;
clk1 <= not clk1 after 400 ps ;

end process;

END ARCHITECTURE;
