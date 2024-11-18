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
      value_i   :in std_logic;
      enable_i  :in std_logic;
      value_o   :out std_logic
   );
end tri_state_buffer;

architecture structural of tri_state_buffer is
signal value_s :std_logic;
begin
   tri_state:process(enable_i, value_i)
   begin
      if (enable_i'event and enable_i = '1') then
            value_o <= value_i;
      else
            if (enable_i = '0') then
            value_o <= '0';
            end if;
      end if;
   end process;    
end architecture;