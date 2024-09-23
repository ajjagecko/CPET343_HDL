-------------------------------------------------------------------------------
-- Name: Andrew Akre
-- Course: CPET 343
-- Assignment: Lab 1
-- Task:
--    Structural Implementation of Single Bit Adder with Carry Over
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;     
use ieee.numeric_std.all; 

entity seven_seg is
port (
   clk_Mhz_i   :in std_logic;
   reset_i       :in std_logic;
   seven_seg_o :out std_logic_vector(7 downto 0)
   );
end seven_seg;

architecture structural of seven_seg is

component generic_adder is 
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

component generic_counter is
  generic (
    max_count       : integer := 3
  );
  port (
    clk             : in  std_logic; 
    reset           : in  std_logic;
    output          : out std_logic
  );  
end component;

constant bits_c : integer := 4;
constant max_count_c : integer := 4;

signal sum_reg_in_s   :std_logic_vector(bits_c-1 downto 0);
signal sum_reg_out_s  :std_logic_vector(bits_c-1 downto 0);
signal cout_s         :std_logic;
signal cin_s          :std_logic;
signal counter_out_s  :std_logic;

begin

   dut0: generic_counter
      generic map (
         max_count => max_count_c
      )
      port map (
         clk => clk_Mhz_i, 
         reset => reset_i,
         output => counter_out_s
      );
   
   dut1: generic_adder
      generic map (
         bits => bits_c
      )
      port map (
         a => sum_reg_out_s,
         b => "0001",
         cin => cout_s,
         sum => sum_reg_in_s,
         cout => cin_s
      );

end structural;
   