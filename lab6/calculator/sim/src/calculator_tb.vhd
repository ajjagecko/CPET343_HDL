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
signal clk        : std_logic := '0';
signal reset      : std_logic := '0';
signal mr_i       : std_logic := '0';
signal ms_i       : std_logic := '0';
signal exe_i      : std_logic := '0';
signal op_sel_i   : std_logic_vector(1 downto 0);
signal switch_i   : std_logic_vector(7 downto 0);
signal led_o      : std_logic_vector(3 downto 0) := "0000";
signal bcd_hun_o  : std_logic_vector(6 downto 0);
signal bcd_ten_o  : std_logic_vector(6 downto 0);
signal      state_pres_o  : std_logic_vector(3 downto 0);
signal      state_next_o  : std_logic_vector(3 downto 0);
signal bcd_one_o  : std_logic_vector(6 downto 0);
signal addr_s        : std_logic_vector(1 downto 0);
signal write_en_s    : std_logic;
signal memory_in_s          : std_logic_vector(7 downto 0);
signal memory_out_o         : std_logic_vector(7 downto 0);
signal memory_out_padded_o  : std_logic_vector(11 downto 0);

begin

sequential_tb : process 
    begin
      report "****************** sequential testbench start ****************";
      -- Reset
      wait for 80ns;
      
      -- Addition 1
      switch_i <= "00000100";
      op_sel_i <= "00";
      wait for 20ns;
      exe_i    <= '1';
      wait for 10ns;
      exe_i    <= '0';
      wait for 50ns;
      
      -- Multiply 1
      switch_i <= "00001000";
      op_sel_i <= "10";
      wait for 20ns;
      exe_i    <= '1';
      wait for 10ns;
      exe_i    <= '0';
      wait for 50ns;
      
      -- Save 1
      ms_i <= '1';
      wait for 10ns;
      ms_i <= '0';
      wait for 70ns;
      
      --Subtract 1
      switch_i <= "00001000";
      op_sel_i <= "01";
      wait for 20ns;
      exe_i    <= '1';
      wait for 10ns;
      exe_i    <= '0';
      wait for 50ns;
      
      -- Divide 1
      switch_i <= "00000010";
      op_sel_i <= "11";
      wait for 20ns;
      exe_i    <= '1';
      wait for 10ns;
      exe_i    <= '0';
      wait for 50ns;
      
      -- Load 1
      mr_i <= '1';
      wait for 10ns;
      mr_i <= '0';
      wait for 70ns;
      
      -- Divide 2
      switch_i <= "00000010";
      op_sel_i <= "11";
      wait for 20ns;
      exe_i    <= '1';
      wait for 10ns;
      exe_i    <= '0';
      wait for 50ns;      
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
    reset <= '1';
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