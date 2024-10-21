
library ieee;
use ieee.std_logic_1164.all;     
use ieee.numeric_std.all; 
library work;
use work.cpet_343_components.all;

entity two_comp is
   generic (
      bits    : integer := 4
   );
   port(
      two_comp_i     :in std_logic_vector(bits-1 downto 0);
      two_comp_o     :out std_logic_vector(bits-1 downto 0)
   );
end two_comp;

architecture beh of two_comp is

   signal inverted_in_s :std_logic_vector(bits-1 downto 0);
   signal one_s         :std_logic_vector(bits-1 downto 0);
      
begin
   -- Inverting every bit in unsigned (Add proper generate option later)
   inverting: for i in 0 to bits-1 generate
      inverted_in_s(i) <= NOT(two_comp_i(i));
   end generate;
   
   assigning: for i in 1 to bits-1 generate
      one_s(i) <= '0';
   end generate;
   
   one_s(0) <= '1';
   
   uut0: generic_adder_arch
      generic map (
         bits => bits
      )
      port map (
         a => inverted_in_s,
         b => one_s,
         cin => '0',
         sum => two_comp_o,
         cout => open
      );
      
end architecture;