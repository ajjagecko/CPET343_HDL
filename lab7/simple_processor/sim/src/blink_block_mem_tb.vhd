-------------------------------------------------------------------------------
-- Dr. Kaputa
-- block mem test bench
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity blink_block_mem_tb is
end blink_block_mem_tb;

architecture arch of blink_block_mem_tb is

component simple_processor is
   port(
      clk         :in std_logic;
      reset       :in std_logic;
      exe_btn_i   :in std_logic;
      bcd_hun_o   :out std_logic_vector(6 downto 0);
      bcd_ten_o   :out std_logic_vector(6 downto 0);
      bcd_one_o   :out std_logic_vector(6 downto 0);
      led_o       :out std_logic_vector(3 downto 0)
   );
end component; 
                                        
signal clk            : std_logic := '0';
signal reset          : std_logic := '0';
constant period   : time := 10ns;
signal exe_btn_i      : std_logic := '0';
signal led_o      : std_logic_vector(3 downto 0) := "0000";
signal bcd_hun_o  : std_logic_vector(6 downto 0);
signal bcd_ten_o  : std_logic_vector(6 downto 0);
signal bcd_one_o  : std_logic_vector(6 downto 0);

begin

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

uut: simple_processor
   port map(
      clk         => clk,
      reset       => reset,
      exe_btn_i   => exe_btn_i,
      bcd_hun_o   => bcd_hun_o,
      bcd_ten_o   => bcd_ten_o,
      bcd_one_o   => bcd_one_o,
      led_o       => led_o
   );

sequential_tb : process 
    begin
      report "****************** sequential testbench start ****************";
      -- Reset
      wait for 80ns;
      exe_btn_i <= '1';
      wait for 80ns;
      exe_btn_i <= '0';
      wait for 80ns;
      exe_btn_i <= '1';
      wait for 80ns;
      exe_btn_i <= '0';
      wait for 80ns;
      exe_btn_i <= '1';
      wait for 80ns;
      exe_btn_i <= '0';      
      wait for 80ns;
      exe_btn_i <= '1';
      wait for 80ns;
      exe_btn_i <= '0';
      wait for 80ns;
      exe_btn_i <= '1';
      wait for 80ns;
      exe_btn_i <= '0';
      wait for 80ns;
      exe_btn_i <= '1';
      wait for 80ns;
      exe_btn_i <= '0';
      
end process;


end arch;