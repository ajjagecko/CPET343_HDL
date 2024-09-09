-------------------------------------------------------------------------------
-- Andrew Akre
-- Structural Implementation of Single Bit Adder with Carry Over
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;     
use ieee.numeric_std.all; 

entity xor2 is
   port(
      a_i      :in std_logic;
      b_i      :in std_logic;
      x_o      :out std_logic
   );
end xor2;

architecture structural of xor2 is

signal a_not_s    :std_logic;
signal b_not_s    :std_logic;
signal a_not_or_s :std_logic;
signal b_not_or_s :std_logic;

component or2 is
   port(
      a_i      :in std_logic;
      b_i      :in std_logic;
      x_o      :out std_logic
   );
end component;

component and3 is
   port(
      a_i      :in std_logic;
      b_i      :in std_logic;
      c_i      :in std_logic;
      x_o      :out std_logic
   );
end component;

begin
   a_not_s <= NOT a_i;
   b_not_s <= NOT b_i;
   
   u0: and3 port map(a_i => a_not_s, b_i => b_i, c_i => b_i, x_o => a_not_or_s);
   u1: and3 port map(a_i => a_i, b_i => a_i, c_i => b_not_s, x_o => b_not_or_s);
   u2: or2 port map(a_i => a_not_or_s, b_i => b_not_or_s, x_o => x_o);
end architecture;