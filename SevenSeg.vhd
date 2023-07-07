library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Seven_Seg is
    Port ( 
        watering_seg: in bit;
        seg7 : out STD_LOGIC_VECTOR (7 downto 0) -- ABCDEFG and DP (RIGHT to LEFT)
       ); 
end Seven_Seg;
architecture seg_act of Seven_Seg is
begin
    process (watering_seg)
    begin
               if (watering_seg = '1') then
                   seg7 <= "10001001";  -- Shows 'H'
               elsif (watering_seg = '0') then          
                   seg7 <= "10111111"; -- Shows dash   
               end if;
    end process;     
end seg_act;
