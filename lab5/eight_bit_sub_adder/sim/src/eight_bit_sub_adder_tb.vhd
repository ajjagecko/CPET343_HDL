-------------------------------------------------------------------------------
-- Dr. Kaputa, modified by Andrew Akre
-- seven segment test bench retrofited into eight_bit_sub_adder_tb
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity eight_bit_sub_adder_tb is
end eight_bit_sub_adder_tb;

architecture arch of eight_bit_sub_adder_tb is

component eight_bit_sub_adder is
   port(
      clk       :in std_logic;
      reset     :in std_logic;
      switch_i  :in std_logic_vector(7 downto 0);
      btn_i     :in std_logic;
      bcd_hun_o :out std_logic_vector(6 downto 0);
      bcd_ten_o :out std_logic_vector(6 downto 0);
      bcd_one_o :out std_logic_vector(6 downto 0)
   );
end component eight_bit_sub_adder;

signal clk       :std_logic;
signal reset     :std_logic;
signal switch_i  :std_logic_vector(7 downto 0);
signal btn_i     :std_logic;
signal bcd_hun_o :std_logic_vector(6 downto 0);
signal bcd_ten_o :std_logic_vector(6 downto 0);
signal bcd_one_o :std_logic_vector(6 downto 0);

begin

dut: eight_bit_sub_adder
   port map(
      clk => clk,
      reset => reset,
      switch_i => switch_i,
      btn_i => btn_i,
      bcd_hun_o => bcd_hun_o,
      bcd_ten_o => bcd_ten_o,
      bcd_one_o => bcd_one_o
   );
end architecture;