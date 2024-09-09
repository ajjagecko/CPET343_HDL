-------------------------------------------------------------------------------
-- Andrew Akre
-- Structural Implementation of Single Bit Adder with Carry Over
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;     
use ieee.numeric_std.all; 

entity alu_and is
   port(
      a_i      :in std_logic;
      b_i      :in std_logic;
      c_i      :in std_logic;
      x_o      :out std_logic
   );
end alu_and;

architecture structural of alu_and is

begin
   x_o <= a_i AND b_i AND c_i;
end