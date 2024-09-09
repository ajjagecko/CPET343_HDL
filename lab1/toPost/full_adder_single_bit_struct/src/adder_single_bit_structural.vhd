-------------------------------------------------------------------------------
-- Name: Andrew Akre
-- Course: CPET 343
-- Assignment: Lab 1
-- Task:
--    Structural Implementation of Single Bit Adder with Carry Over
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;     
use ieee.numeric_std.all; 

-- Defining Inputs and Outputs for Structural
entity adder_single_bit_s is
   port(
      a_i      :in std_logic;
      b_i      :in std_logic;
      cin_i    :in std_logic;
      sum_o    :out std_logic;
      cout_o   :out std_logic
   );
end adder_single_bit_s;

architecture structural of adder_single_bit_s is

-- Defining Internal Signals
signal ab_or_s  :std_logic;
signal ac_or_s  :std_logic;
signal bc_or_s  :std_logic;
signal ab_xor_s :std_logic;

-- Defining XOR Gate with 2 Input Signals
component xor2 is
   port(
      a_i      :in std_logic;
      b_i      :in std_logic;
      x_o      :out std_logic
   );
end component;

-- Defining OR Gate with 2 Input Signals
component or2 is
   port(
      a_i      :in std_logic;
      b_i      :in std_logic;
      x_o      :out std_logic
   );
end component;

-- Defining AND Gate with 3 Input Signals
component and3 is
   port(
      a_i      :in std_logic;
      b_i      :in std_logic;
      c_i      :in std_logic;
      x_o      :out std_logic
   );
end component;

begin
   -- OR gates
   u0: or2 port map   (a_i => a_i, b_i => b_i, x_o => ab_or_s);
   u1: or2 port map   (a_i => a_i, b_i => cin_i, x_o => ac_or_s);
   u2: or2 port map   (a_i => b_i, b_i => cin_i, x_o => bc_or_s);
   
   -- AND gate
   u3: and3 port map  (a_i => ab_or_s, b_i => ac_or_s, c_i => bc_or_s, x_o => cout_o);
   
   -- XOR gate
   u4: xor2 port map  (a_i => a_i, b_i => b_i, x_o => ab_xor_s);
   u5: xor2 port map  (a_i => ab_xor_s, b_i => cin_i, x_o => sum_o);
   
   
end architecture;
