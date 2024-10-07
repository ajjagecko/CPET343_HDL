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

constant bits :integer := 8;

signal btn_sync_s    :std_logic;
signal state_next_s  :std_logic;
signal state_pres_s  :std_logic;

signal switch_sync_s :std_logic_vector(7 downto 0);
signal a_in_s        :std_logic_vector(7 downto 0);
signal b_in_s        :std_logic_vector(7 downto 0);
signal sub_en_s      :std_logic;
signal sum_s         :std_logic_vector(7 downto 0);

signal display_sel   :std_logic_vector(7 downto 0);
signal dd_hun_s      :std_logic_vector(3 downto 0);
signal dd_ten_s      :std_logic_vector(3 downto 0);
signal dd_one_s      :std_logic_vector(3 downto 0);

begin
   -- Synchronizer for switch_i
   dut00: generic_sync_arch
      generic map (
         bits => bits
      )
      port map (
         clk     => clk,
         reset   => reset,
         async_i => switch_i,
         sync_o  => switch_sync_s
      );
      
   dut01: rising_edge_synchronizer
      port map (
         clk   => clk,
         reset => reset,
         input => btn_i,
         edge  => btn_sync_s
      );
   
   -- Add STATE MACHINE AND DEMUX HERE
   
   dut05: generic_sub_arch
      generic map (
         bits => bits
      )
      port map (
         a_i      => a_in_s,
         b_i      => b_in_s,
         carry_i  => '0',
         sub_en_i => sub_en_s,
         sum_o    => sum_s,
         carry_o  => open
      );
      
   dut08: bcd_4bit
      port map (
         bcd_i   =>   dd_hun_s,
         bcd_o   =>   bcd_hun_o
      );
   
   dut09: bcd_4bit
      port map (
         bcd_i   =>   dd_ten_s,
         bcd_o   =>   bcd_ten_o
      );
      
   dut10: bcd_4bit
      port map (
         bcd_i   =>   dd_one_s,
         bcd_o   =>   bcd_one_o
      );
end architecture;
