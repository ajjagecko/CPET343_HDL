-------------------------------------------------------------------------------
-- Dr. Kaputa, modified by Andrew Akre
-- seven segment test bench retrofited into sub_adder tb
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sub_adder_3bit_tb is
end sub_adder_3bit_tb;

architecture arch of sub_adder_3bit_tb is

component sub_adder_3bit is
  port (
   clk        :in std_logic;
   reset      :in std_logic;
   a_i        :in std_logic_vector(2 downto 0);
   b_i        :in std_logic_vector(2 downto 0);
   add_btn_i  :in std_logic;
   sub_btn_i  :in std_logic;
   a_bcd_o        :out std_logic_vector(6 downto 0);
   b_bcd_o        :out std_logic_vector(6 downto 0);
   sum_temp_o     :out std_logic_vector(3 downto 0);
   prev_sum_temp_o     :out std_logic_vector(3 downto 0);
   result_bcd_o   :out std_logic_vector(6 downto 0)
  );  
end component; 

constant period     : time := 10ns;                                              
signal clk          : std_logic := '0';
signal reset        : std_logic := '1';
signal a_i        :std_logic_vector(2 downto 0) := "000";
signal b_i        :std_logic_vector(2 downto 0) := "000";
signal add_btn_i  :std_logic := '0';
signal sub_btn_i  :std_logic := '1';
signal a_bcd_o        :std_logic_vector(6 downto 0);
signal b_bcd_o        :std_logic_vector(6 downto 0);
signal sum_temp_o     :std_logic_vector(3 downto 0);
signal prev_sum_temp_o     :std_logic_vector(3 downto 0);
signal result_bcd_o   :std_logic_vector(6 downto 0);

begin

-- bcd iteration
sequential_tb : process 
    begin
      report "****************** sequential testbench start ****************";
      wait for 80ns;   -- let all the initial conditions trickle through
      for i in 0 to 2 loop
         add_btn_i <= not add_btn_i;
         wait for 10ns;
         sub_btn_i <= not sub_btn_i;
         wait for 10ns;
         for k in 0 to 7 loop
            for j in 0 to 7 loop
               a_i <= std_logic_vector(unsigned(a_i) + 1);
               wait for 20ns;
            end loop;
            b_i <= std_logic_vector(unsigned(b_i) + 1);
         end loop;
      end loop;
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

uut: sub_adder_3bit  
  port map(        
   clk           => clk,
   reset         => reset,
   a_i           => a_i,
   b_i           => b_i,
   add_btn_i     => add_btn_i,
   sub_btn_i     => sub_btn_i,
   a_bcd_o       => a_bcd_o,
   b_bcd_o       => b_bcd_o,
   sum_temp_o    => sum_temp_o,
   prev_sum_temp_o => prev_sum_temp_o,
   result_bcd_o  => result_bcd_o  
  );
end arch;