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
entity and3 is
   port(
      a_i      :in std_logic;
      b_i      :in std_logic;
      c_i      :in std_logic;
      x_o      :out std_logic
   );
end and3;

architecture structural of and3 is

begin
   x_o <= a_i AND b_i AND c_i;
end architecture;