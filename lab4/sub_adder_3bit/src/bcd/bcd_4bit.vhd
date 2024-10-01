
library ieee;
use ieee.std_logic_1164.all;     
use ieee.numeric_std.all; 

entity bcd is
port(
   num_i      :in std_logic_vector(3 downto 0);
   bcd_o     :out std_logic_vector(6 downto 0)
   );
end bcd;

architecture beh of bcd is
begin
   bcd: process(num_i)
      begin
         case num_i is
            when "0000" => bcd_o <= "1000000";
            when "0001" => bcd_o <= "1111001";
            when "0010" => bcd_o <= "0100100";
            when "0011" => bcd_o <= "0110000";
            when "0100" => bcd_o <= "0011001";
            when "0101" => bcd_o <= "0010010";
            when "0110" => bcd_o <= "0000010";
            when "0111" => bcd_o <= "1111000";
            when "1000" => bcd_o <= "0000000";
            when "1001" => bcd_o <= "0011000";
            when "1010" => bcd_o <= "0100000";
            when "1011" => bcd_o <= "0000011";
            when "1100" => bcd_o <= "0100111";
            when "1101" => bcd_o <= "0100001";
            when "1110" => bcd_o <= "0000100";
            when "1111" => bcd_o <= "0111000";
            when others => bcd_o <= "0111111";
         end case;
      end process;
end architecture;