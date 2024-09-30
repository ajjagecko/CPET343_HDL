-------------------------------------------------------------------------------
-- Name: Andrew Akre
-- Course: CPET 343
-- Assignment: Lab 4
-- Task:
--    3 bit sub-adder with BCD displays
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;     
use ieee.numeric_std.all; 

entity sub_adder_3bit is
port (
   clk        :in std_logic;
   reset      :in std_logic;
   a_i        :in std_logic_vector(2 downto 0);
   b_i        :in std_logic_vector(2 downto 0);
   add_btn_i  :in std_logic;
   sub_btn_i  :in std_logic;
   a_bcd_o        :out std_logic_vector(6 downto 0);
   b_bcd_o        :out std_logic_vector(6 downto 0);
   result_bcd_o   :out std_logic_vector(6 downto 0)
   );
end sub_adder_3bit;

architecture behavioral of sub_adder_3bit is

   signal a_sync_s        :std_logic_vector(2 downto 0);
   signal b_sync_s        :std_logic_vector(2 downto 0);
   signal b_2bc_s         :std_logic_vector(2 downto 0);
   signal sub_btn_sync_s  :std_logic;
   signal add_btn_sync_s  :std_logic;
   signal sum_s           :std_logic_vector(3 downto 0);
   
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
   
   component bcd is
      port(
         num_i      :in std_logic_vector(3 downto 0);
         bcd_o     :out std_logic_vector(6 downto 0)
      );
   end component;
   
   component two_bit_comp is
      port(
         unsign_i       :in std_logic_vector(3 downto 0);
         two_bit_comp_o :out std_logic_vector(3 downto 0)
      );
   end component;

begin

end architecture;
