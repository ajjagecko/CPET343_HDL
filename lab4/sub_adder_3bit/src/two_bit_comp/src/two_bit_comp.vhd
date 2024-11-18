
library ieee;
use ieee.std_logic_1164.all;     
use ieee.numeric_std.all; 


entity two_bit_comp is
port(
   unsign_i       :in std_logic_vector(3 downto 0);
   two_bit_comp_o :out std_logic_vector(3 downto 0)
   );
end two_bit_comp;

architecture beh of two_bit_comp is

   signal not_unsign_s :std_logic_vector(3 downto 0);
   
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
      
begin
   -- Inverting every bit in unsigned (Add proper generate option later)
   not_unsign_s <= NOT(unsign_i(3)) & NOT(unsign_i(2)) & NOT(unsign_i(1)) & NOT(unsign_i(0));
   
   uut0: generic_adder_arch
      generic map (
         bits => 4
      )
      port map (
         a => not_unsign_s,
         b => "0001",
         cin => '0',
         sum => two_bit_comp_o,
         cout => open
      );
      
end architecture;