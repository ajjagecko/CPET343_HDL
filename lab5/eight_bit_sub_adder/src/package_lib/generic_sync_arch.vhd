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
    async_i           : in std_logic_vector(bits-1 downto 0);
    sync_o            : out std_logic_vector(bits-1 downto 0)
  );
end generic_sync_arch;

architecture beh of generic_sync_arch is

component synchronizer is 
  port (
    clk               : in std_logic;
    reset             : in std_logic;
    async_in          : in std_logic;
    sync_out          : out std_logic
  );
end component;

begin
   syncs: for i in 0 to bits-1 generate
      sync: synchronizer
         port map(
            clk   => clk,
            reset => reset,
            async_in => async_i(i),
            sync_out => sync_o(i)
         );
   end generate;
end architecture;