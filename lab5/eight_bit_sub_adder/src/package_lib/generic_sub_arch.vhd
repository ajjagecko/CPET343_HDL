-------------------------------------------------------------------------------
-- Dr. Kaputa
-- generic adder [hierarchical]
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.cpet_343_components.all;

entity generic_sub_arch is
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
end entity generic_sub_arch;

architecture arch of generic_sub_arch is

signal b_subtract_s :std_logic_vector(bits-1 downto 0);
signal b_selected_s :std_logic_vector(bits-1 downto 0);

begin
   twos: two_comp
      generic map (
         bits => bits
      )   
      port map (
         two_comp_i => b_i,
         two_comp_o => b_subtract_s
      );
   
   sel: process(sub_en_i, b_i, b_subtract_s) is
   begin
      case sub_en_i is
         when '1' => b_selected_s <= b_subtract_s;
         when others => b_selected_s <= b_i;
      end case;
   end process;
   
   adders: generic_adder_arch
      generic map (
         bits => bits
      )
      port map (
         a => a_i,
         b => b_selected_s,
         cin => carry_i,
         sum => sum_o,
         cout => carry_o
      );
      
end arch;