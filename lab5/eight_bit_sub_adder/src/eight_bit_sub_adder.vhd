library ieee;
use ieee.std_logic_1164.all;     
use ieee.numeric_std.all; 
library work;
use work.cpet_343_components.all;

entity eight_bit_sub_adder is
   port(
      clk       :in std_logic;
      reset     :in std_logic;
      switch_i  :in std_logic_vector(7 downto 0);
      btn_i     :in std_logic;
      bcd_hun_o :out std_logic_vector(6 downto 0);
      bcd_ten_o :out std_logic_vector(6 downto 0);
      bcd_one_o :out std_logic_vector(6 downto 0)
   );
end eight_bit_sub_adder;

architecture beh of eight_bit_sub_adder is

signal btn_sync_s    :std_logic;
signal state_next_s  :std_logic;
signal state_pres_s  :std_logic;

signal switch_sync_s :std_logic_vector(7 downto 0);
signal a_in_s        :std_logic_vector(7 downto 0);
signal b_in_s        :std_logic_vector(7 downto 0);
signal sum_s         :std_logic_vector(11 downto 0);
signal display_sel   :std_logic_vector(7 downto 0);

signal dd_hun_s      :std_logic_vector(3 downto 0);
signal dd_ten_s      :std_logic_vector(3 downto 0);
signal dd_one_s      :std_logic_vector(3 downto 0);

begin

end architecture;
