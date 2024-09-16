-------------------------------------------------------------------------------
-- Dr. Kaputa
-- single bit full adder test bench
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;      -- gives you the std_logic type

entity tri_state_buffer_tb is 
end tri_state_buffer_tb;

architecture arch of tri_state_buffer_tb is

component flip_flop_one_bit
  port(
      clk_i     :in std_logic;
      value_i   :in std_logic;
      enable_i  :in std_logic;
      value_o   :out std_logic
    );
  end component;

signal clk_i       :std_logic := '0';
signal value_i     :std_logic := '0';
signal enable_i    :std_logic := '0'; 
signal value_o     :std_logic;
constant PERIOD : time := 5ns;
begin 
  uut: flip_flop_one_bit 
    port map(
      clk_i => clk_i,
      value_i => value_i,
      enable_i => enable_i,
      value_o => value_o
    );
  Clk_gen: PROCESS
  BEGIN
    clk_i <='0';
    WAIT FOR PERIOD/2;
    clk_i <= '1';
    WAIT FOR PERIOD/2;
  END PROCESS;
  value_i <= not value_i after 10 ns;
  enable_i <= not enable_i after 20 ns;
end arch;