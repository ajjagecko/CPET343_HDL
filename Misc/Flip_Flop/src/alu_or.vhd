-------------------------------------------------------------------------------
-- Name: Andrew Akre
-- Course: CPET 343
-- Assignment: Lab 1
-- Task:
--    Structural Implementation of Single Bit Adder with Carry Over
--    OR gate sub component
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;     
use ieee.numeric_std.all; 

-- Defining Inputs and Outputs for Structural
entity my_or2 is
   port(
      a_i      :in std_logic;
      b_i      :in std_logic;
      x_o      :out std_logic
   );
end my_or2;

architecture structural of my_or2 is

begin
   x_o <= a_i OR b_i;
end architecture;