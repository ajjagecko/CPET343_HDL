-------------------------------------------------------------------------------
-- Andrew Akre
-- Structural Implementation of Single Bit Adder with Carry Over
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;     
use ieee.numeric_std.all; 

entity adder_single_bit_s is
   port(
      a_i      :in std_logic;
      b_i      :in std_logic;
      cin_i    :in std_logic;
      sum_o    :out std_logic;
      cout_o   :out std_logic;
   );
end adder_single_bit_s;

architecture structural of adder_single_bit_s is

signal ab_or_s  :std_logic;
signal ac_or_s  :std_logic;
signal bc_or_s  :std_logic;
signal ab_xor_s :std_logic;

component xor2 is
   port(
      a_i      :in std_logic;
      b_i      :in std_logic;
      x_o      :out std_logic;
   );
end component;

component or2 is
   port(
      a_i      :in std_logic;
      b_i      :in std_logic;
      x_o      :out std_logic;
   );
end component;

component and3 is
   port(
      a_i      :in std_logic;
      b_i      :in std_logic;
      c_i      :in std_logic;
      x_o      :out std_logic;
   );
end component;

begin
   u0: or2 port map   (a_i => a_i, b_i => b_i, ab_or_s => x_o);
   u1: or2 port map   (a_i => a_i, c_i => b_i, ac_or_s => x_o);
   u2: or2 port map   (c_i => a_i, b_i => b_i, bc_or_s => x_o);
   u3: and3 port map  (ab_or_s => a_i, ac_or_s => b_i, bc_or_s => c_i, cout_o => x_o);
   u4: xor2 port map  (a_i => a_i, b_i => b_i, ab_xor_s => x_o);
   u5: xor2 port map  (ab_xor_s => a_i, c_i => b_i, sum_o => x_o);
   
   
end architecture;
