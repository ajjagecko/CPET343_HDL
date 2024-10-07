-------------------------------------------------------------------------------
-- Dr. Kaputa, modified by Andrew Akre
-- seven segment test bench retrofited into eight_bit_sub_adder_tb
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity eight_bit_sub_adder_tb is
end eight_bit_sub_adder_tb;

architecture arch of eight_bit_sub_adder_tb is

component eight_bit_sub_adder is
   port(
      clk       :in std_logic;
      reset     :in std_logic;
      switch_i  :in std_logic_vector(7 downto 0);
      btn_i     :in std_logic;
      led_o     :out std_logic_vector(3 downto 0);
      bcd_hun_o :out std_logic_vector(6 downto 0);
      bcd_ten_o :out std_logic_vector(6 downto 0);
      bcd_one_o :out std_logic_vector(6 downto 0)
   );
end component eight_bit_sub_adder;

constant period     : time := 10ns;                                              
signal clk          : std_logic := '0';
signal reset        : std_logic := '1';
signal switch_i  :std_logic_vector(7 downto 0);
signal btn_i     :std_logic := '0';
signal bcd_hun_o :std_logic_vector(6 downto 0);
signal bcd_ten_o :std_logic_vector(6 downto 0);
signal bcd_one_o :std_logic_vector(6 downto 0);
signal led_o     :std_logic_vector(3 downto 0);

constant TWO    :std_logic_vector(7 downto 0) := "00000010";
constant FIVE   :std_logic_vector(7 downto 0) := "00000101";
constant TWOHUN :std_logic_vector(7 downto 0) := "11001000";
constant ONEHUN :std_logic_vector(7 downto 0) := "01100100";

begin

sequential_tb : process 
    begin
      report "****************** sequential testbench start ****************";
      wait for 80ns;   -- let all the initial conditions trickle through
      --input_a
      switch_i <= FIVE;
      wait for 10ns;
      --input_b
      btn_i <= '1';
      wait for 10ns;
      btn_i <= '0';
      wait for 10ns;
      switch_i <= TWO;
      wait for 10ns;
      --disp_sum
      btn_i <= '1';
      wait for 10ns;
      btn_i <= '0';
      wait for 10ns;
      --disp_diff
      btn_i <= '1';
      wait for 10ns;
      btn_i <= '0';
      wait for 10ns;
      --input_a
      btn_i <= '1';
      wait for 10ns;
      btn_i <= '0';
      wait for 10ns;
      switch_i <= TWO;
      wait for 10ns;
      --input_b
      btn_i <= '1';
      wait for 10ns;
      btn_i <= '0';
      wait for 10ns;
      switch_i <= FIVE;
      wait for 10ns;
      --disp_sum
      btn_i <= '1';
      wait for 10ns;
      btn_i <= '0';
      wait for 10ns;
      --disp_diff
      btn_i <= '1';
      wait for 10ns;
      btn_i <= '0';
      wait for 10ns;
      --input_a
      btn_i <= '1';
      wait for 10ns;
      btn_i <= '0';
      wait for 10ns;
      switch_i <= TWOHUN;
      wait for 10ns;
      --input_b
      btn_i <= '1';
      wait for 5ns;
      btn_i <= '0';
      wait for 10ns;
      switch_i <= ONEHUN;
      wait for 10ns;
      --disp_sum
      btn_i <= '1';
      wait for 10ns;
      btn_i <= '0';
      wait for 10ns;
      --disp_diff
      btn_i <= '1';
      wait for 10ns;
      btn_i <= '0';
      wait for 10ns;
      --input_a
      btn_i <= '1';
      wait for 10ns;
      btn_i <= '0';
      wait for 10ns;
      switch_i <= ONEHUN;
      wait for 10ns;
      
      --input_b
      btn_i <= '1';
      wait for 10ns;
      btn_i <= '0';
      wait for 10ns;
      switch_i <= TWOHUN;
      wait for 10ns;
      --disp_sum
      btn_i <= '1';
      wait for 10ns;
      btn_i <= '0';
      wait for 10ns;
      --disp_diff
      btn_i <= '1';
      wait for 10ns;
      btn_i <= '0';
      report "****************** sequential testbench stop ****************";
      wait;
  end process; 

-- clock process
clock: process
  begin
    clk <= not clk;
    wait for period/2;
end process; 
 
-- reset process
async_reset: process
  begin
    wait for 2 * period;
    reset <= '0';
    wait;
end process;

-- DUT
dut: eight_bit_sub_adder
   port map(
      clk => clk,
      reset => reset,
      switch_i => switch_i,
      btn_i => btn_i,
      led_o => led_o,
      bcd_hun_o => bcd_hun_o,
      bcd_ten_o => bcd_ten_o,
      bcd_one_o => bcd_one_o
   );
end architecture;