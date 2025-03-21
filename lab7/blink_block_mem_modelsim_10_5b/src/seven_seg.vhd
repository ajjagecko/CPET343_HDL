-------------------------------------------------------------------------------
-- Dr. Kaputa
-- seven segment led demo
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;      

entity seven_seg is
  port (
    bcd             : in std_logic_vector(12 downto 0);
    seven_seg_out   : out std_logic_vector(6 downto 0)
  );  
end seven_seg;  

architecture beh of seven_seg  is

begin
process(bcd)
  begin
    case  bcd is
      when "0000000000000"=> seven_seg_out <="1000000";  -- '0'
      when "0000000000001"=> seven_seg_out <="1111001";  -- '1'
      when "0000000000010"=> seven_seg_out <="0100100";  -- '2' 
      when "0000000000011"=> seven_seg_out <="0110000";  -- '3'
      when "0000000000100"=> seven_seg_out <="0011001";  -- '4'
      when "0000000000101"=> seven_seg_out <="0010010";  -- '5'
      when "0000000000110"=> seven_seg_out <="0000010";  -- '6'
      when "0000000000111"=> seven_seg_out <="1111000";  -- '7'
      when "0000000001000"=> seven_seg_out <="0000000";  -- '8'
      when "0000000001001"=> seven_seg_out <="0011000";  -- '9'
      --nothing is displayed when a number more than 9 is given as input.
      when others=> seven_seg_out <="1111111";
    end case; 
  end process;
end beh;