-------------------------------------------------------------------------------
-- Dr. Kaputa
-- generic adder [hierarchical]
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity generic_sync_arch is
  generic (
    bits    : integer := 4
  );
    port (
    clk               : in std_logic;
    reset             : in std_logic;
    input             : in std_logic_vector(bits-1 downto 0);
    edge              : out std_logic
  );
end generic_sync_arch;

architecture beh of generic_sync_arch is

signal edge_vec_s :std_logic_vector(bits-1 downto 0);
signal edge_carry_s :std_logic := '0';

component rising_edge_synchronizer is
  port (
    clk               : in std_logic;
    reset             : in std_logic;
    input             : in std_logic;
    edge              : out std_logic
  );
end component;

begin
   syncs: for i in 0 to bits-1 generate
      sync: rising_edge_synchronizer
         port map(
            clk   => clk,
            reset => reset,
            input => input(i),
            edge  => edge_vec_s(i)
         );
   end generate;
   
   edge <= edge_vec_s(0) or edge_vec_s(1) or edge_vec_s(2);
   
end architecture;