-------------------------------------------------------------------------------
-- Andrew Akre
-- Structural Implementation of Single Bit Adder with Carry Over
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;     
use ieee.numeric_std.all; 

entity alu_or is
   port(
      a_i      :in std_logic;
      b_i      :in std_logic;
      x_o      :out std_logic
   );
end alu_or;

architecture structural of alu_or is

begin
   x_o <= a_i OR b_i;
end