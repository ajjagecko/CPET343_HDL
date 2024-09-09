-------------------------------------------------------------------------------
-- Andrew Akre
-- Structural Implementation of Single Bit Adder with Carry Over
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;     
use ieee.numeric_std.all; 

entity adder_single_bit_s is
   port(
      a      :in std_logic;
      b      :in std_logic;
      cin    :in std_logic;
      sum    :out std_logic;
      cout   :out std_logic;
   );
end adder_single_bit_s;

architecture structural of adder_single_bit_s is

component xor is
   port(
      a      :in std_logic;
      b      :in std_logic;
      x      :out std_logic;
   );
end component;

component or is
   port(
      a      :in std_logic;
      b      :in std_logic;
      x      :out std_logic;
   );
end component;

component and is
   port(
      a      :in std_logic;
      b      :in std_logic;
      s      :out std_logic;
   );
end component;

begin

end architecture;
