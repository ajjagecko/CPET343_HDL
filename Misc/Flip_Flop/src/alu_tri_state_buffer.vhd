-------------------------------------------------------------------------------
-- Name: Andrew Akre
-- Course: CPET 343
-- Assignment: Lab 1
-- Task:
--    Structural Implementation of Single Bit Adder with Carry Over
--    AND gate sub component
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;     
use ieee.numeric_std.all; 

-- Defining Inputs and Outputs for Structural
entity tri_state_buffer is
   port(
      clk_i     :in std_logic;
      value_i   :in std_logic;
      enable_i  :in std_logic;
      value_o   :out std_logic
   );
end tri_state_buffer;

architecture structural of tri_state_buffer is

begin
   tri_state:process(enable_i, clk_i, value_i)
   begin
      if (clk_i'event and clk_i = '1') then
         if (enable_i = '1') then 
            value_o <= value_i;
         else
            value_o <= 'Z';
         end if;
      end if;
   end process;    
end architecture;