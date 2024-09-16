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
entity flip_flop_one_bit is
   port(
      clk_i        :in std_logic;
      enable_i     :in std_logic;
      value_i      :in std_logic;
      value_o      :out std_logic
   );
end flip_flop_one_bit;

architecture arch of flip_flop_one_bit is

signal output_buffer_s      :std_logic;
signal value_hold_s         :std_logic;
signal input_hold_buffer_s  :std_logic;
signal output_hold_buffer_s :std_logic;
signal not_enable_s         :std_logic;

-- Defining OR Gate with 2 Input Signals
component my_or2 is
   port(
      a_i      :in std_logic;
      b_i      :in std_logic;
      x_o      :out std_logic
   );
end component;

component tri_state_buffer is
   port(
      clk_i     :in std_logic;
      value_i   :in std_logic;
      enable_i  :in std_logic;
      value_o   :out std_logic
   );
end component;

begin
   
   not_enable_s <= NOT enable_i;
   
   -- Tri-state portmaps
   u0: tri_state_buffer port map  (clk_i => clk_i, value_i => value_i, enable_i => enable_i, value_o => output_buffer_s);
   u1: tri_state_buffer port map  (clk_i => clk_i, value_i => input_hold_buffer_s, enable_i => not_enable_s, value_o => output_hold_buffer_s);
   u2: my_or2 port map   (a_i => output_buffer_s, b_i => output_hold_buffer_s, x_o => value_hold_s);
   
   value_o <= value_hold_s;
   input_hold_buffer_s <= value_hold_s;
   
end architecture;





