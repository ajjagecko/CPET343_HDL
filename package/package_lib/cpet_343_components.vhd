-------------------------------------------------------------------------------
-- Name: Andrew Akre
-- Course: CPET 343
-- Task:
--    Package of presently made components
--    Last Updated: 07/10//2024
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;     
use ieee.numeric_std.all; 

package cpet_343_components is
   ------ BCD ------
   component bcd_4bit is
      port(
         bcd_i:   in std_logic_vector(3 downto 0); 
         bcd_o:   out std_logic_vector(6 downto 0)
      );
   end component;
   ------ Generic Sub-Adder ------
   component generic_sub_arch is
      generic (
         bits    : integer := 4
      );
      port (
         a_i        : in  std_logic_vector(bits-1 downto 0);
         b_i        : in  std_logic_vector(bits-1 downto 0);
         carry_i    : in  std_logic;
         sub_en_i   : in  std_logic;
         sum_o      : out std_logic_vector(bits-1 downto 0);
         carry_o    : out std_logic
      );  
   end component;
   ------ Generic Adder ------
   component generic_adder_arch is 
      generic (
         bits    : integer := 4
      );
      port (
         a       : in  std_logic_vector(bits-1 downto 0);
         b       : in  std_logic_vector(bits-1 downto 0);
         cin     : in  std_logic;
         sum     : out std_logic_vector(bits-1 downto 0);
         cout    : out std_logic
      );
   end component;
   ------ Generic Two's complement ------
   component two_comp is
      generic (
         bits    : integer := 4
      );
      port(
         two_comp_i     :in std_logic_vector(bits-1 downto 0);
         two_comp_o     :out std_logic_vector(bits-1 downto 0)
      );
   end component;
   ------ Rising Edge Synchronizer ------
   component rising_edge_synchronizer is
      port (
         clk               : in std_logic;
         reset             : in std_logic;
         input             : in std_logic;
         edge              : out std_logic
      );
   end component;
   ------ Generic Synchronizer ------
   component generic_sync_arch is
      generic (
         bits    : integer := 4
      );   
      port (
         clk               : in std_logic;
         reset             : in std_logic;
         async_i           : in std_logic_vector(bits-1 downto 0);
         sync_o            : out std_logic_vector(bits-1 downto 0)
      );
   end component;
end package cpet_343_components;