-------------------------------------------------------------------------------
-- Dr. Kaputa, modified by Andrew Akre
-- seven segment test bench retrofited into sub_adder tb
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity two_bit_comp_tb is
end two_bit_comp_tb;

architecture arch of two_bit_comp_tb is

component two_bit_comp is
   port(
      unsign_i       :in std_logic_vector(3 downto 0);
      two_bit_comp_o :out std_logic_vector(3 downto 0)
   );
end component; 
                                           
signal unsign_i       :std_logic_vector(3 downto 0) := "0000";
signal two_bit_comp_o :std_logic_vector(3 downto 0);

begin

-- bcd iteration
sequential_tb : process 
    begin
      report "****************** sequential testbench start ****************";
      wait for 80 ns;   -- let all the initial conditions trickle through
      for i in 0 to 7 loop
         unsign_i <= std_logic_vector(unsigned(unsign_i) + 1);
         wait for 40 ns;
      end loop;
      report "****************** sequential testbench stop ****************";
      wait;
  end process; 

uut: two_bit_comp
  port map(        
      unsign_i => unsign_i,
      two_bit_comp_o => two_bit_comp_o
  );
end arch;