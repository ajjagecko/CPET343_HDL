-------------------------------------------------------------------------------
-- Dr. Kaputa, modified by Andrew Akre
-- seven segment test bench retrofited into eight_bit_sub_adder_tb
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity calculator_tb is
end calculator_tb;

architecture arch of calculator_tb is

component calculator_dut is
   port(
      clk         :in std_logic;
      reset       :in std_logic;
      mr_i        :in std_logic;
      ms_i        :in std_logic;
      exe_i       :in std_logic;
      op_sel_i    :in std_logic_vector(1 downto 0);
      switch_i    :in std_logic_vector(7 downto 0);
      led_o       :out std_logic_vector(3 downto 0);
      bcd_hun_o :out std_logic_vector(6 downto 0);
      bcd_ten_o :out std_logic_vector(6 downto 0);
      bcd_one_o :out std_logic_vector(6 downto 0)
   );
end component;

constant period   : time := 10ns;                                              
signal clk        : std_logic;
signal reset      : std_logic;
signal mr_i       : std_logic;
signal ms_i       : std_logic;
signal exe_i      : std_logic;
signal op_sel_i   : std_logic_vector(1 downto 0);
signal switch_i   : std_logic_vector(7 downto 0);
signal led_o      : std_logic_vector(3 downto 0) := "0000";
signal bcd_hun_o  : std_logic_vector(6 downto 0);
signal bcd_ten_o  : std_logic_vector(6 downto 0);
signal bcd_one_o  : std_logic_vector(6 downto 0);

begin

sequential_tb : process 
    begin
      report "****************** sequential testbench start ****************";
      
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
dut: calculator_dut
   port map(
      clk => clk,
      reset => reset,
      switch_i => switch_i,
      mr_i      => mr_i     ,
      ms_i      => ms_i     ,
      exe_i     => exe_i    ,
      op_sel_i  => op_sel_i ,
      led_o     => led_o    ,
      bcd_hun_o => bcd_hun_o,
      bcd_ten_o => bcd_ten_o,
      bcd_one_o => bcd_one_o
   );

end architecture;