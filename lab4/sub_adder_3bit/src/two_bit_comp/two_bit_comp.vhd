
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

begin
   two_bit_comp_o <= unsign_i;
end architecture;