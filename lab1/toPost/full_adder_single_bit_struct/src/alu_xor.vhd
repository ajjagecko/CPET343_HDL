-------------------------------------------------------------------------------
-- Name: Andrew Akre
-- Course: CPET 343
-- Assignment: Lab 1
-- Task:
--    Structural Implementation of Single Bit Adder with Carry Over
--    XOR gate sub component
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;     
use ieee.numeric_std.all; 

-- Defining Inputs and Outputs for Structural
entity xor2 is
   port(
      a_i      :in std_logic;
      b_i      :in std_logic;
      x_o      :out std_logic
   );
end xor2;

architecture structural of xor2 is

begin
   x_o <= a_i XOR b_i;
end architecture;