-------------------------------------------------------------------------------
-- Name: Andrew Akre
-- Course: CPET 343
-- Task:
--    Lab 6 Calculator
--    Last Updated: 21/10//2024

--Shall Employ the 4 push buttons as 'execute', 'ms', 'mr', and reset (Memory Save and Memory Retrieve respectively)
--
--Shall use the 8 right most switches for the second input of the calculator
--
--The first input shall come from either the the working register or the save register
--
--Shall implement an 8 bit wide memory that contains the working register and the save register. Only really need two rows, however you might have to create a 4x8 memory since the addresss line wants to be a std_logic_vector (at least 2 bits)
--
--Shall use the two left most switches to select desired operation
--
--The working register shall only be updated upon a mr or execute push
--
--Pressing ms button shall save the present working register to the save register
--
--Pressing mr button shall load the save register to the working register
--
--Calculator inputs shall be both 8 bit and the output shall be 8 bit
--
--Shall operate with unsigned base 256 numbers
--
--All inouts shall be syncedd
--
--Shall display state via LEDs
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.cpet_343_components.all;

entity calculator_dut is
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
end calculator_dut;


architecture beh of calculator_dut is

-- Synchronized Inputs
signal nsl_s         : std_logic_vector(2 downto 0);
signal op_sel_s      : std_logic_vector(1 downto 0);
signal switch_s      : std_logic_vector(7 downto 0);

-- Internal Memory Signals
signal alu_out_s     : std_logic_vector(7 downto 0);
signal memory_in_s   : std_logic_vector(7 downto 0);
signal memory_out_s  : std_logic_vector(7 downto 0);

signal addr_s        : std_logic_vector(1 downto 0);
signal write_en_s    : std_logic;

-- Internal Memory Addr Constants
constant WORK_ADDR   : std_logic_vector(1 downto 0) := "00";
constant SAVE_ADDR   : std_logic_vector(1 downto 0) := "01";

-- Double Dabble Output Signals
signal dd_hun_s      : std_logic_vector(3 downto 0);
signal dd_ten_s      : std_logic_vector(3 downto 0);
signal dd_one_s      : std_logic_vector(3 downto 0);

-- Present State 
signal state_pres_s  : std_logic_vector(3 downto 0);

-- State Machine Component
component state_machine_four_states is
   port (
      clk             :in  std_logic;
      reset           :in  std_logic;
      nsl_i           :in  std_logic_vector(2 downto 0);
      state_pres_o    :out std_logic_vector(3 downto 0)
   );
end component;

-- Behavioral ALU Component
component alu is
  port (
    clk           :in  std_logic;
    reset         :in  std_logic;
    a             :in  std_logic_vector(7 downto 0); 
    b             :in  std_logic_vector(7 downto 0);
    op            :in  std_logic_vector(1 downto 0); -- 00: add, 01: sub, 10: mult, 11: div
    result        :out std_logic_vector(7 downto 0)
  );  
end component;  

component generic_memory is
   generic (addr_width_g : integer := 2;
            data_width_g : integer := 4);
   port (
      clk              :in  std_logic;
      write_en_i       :in  std_logic;
      addr_i           :in  std_logic_vector(addr_width_g - 1 downto 0);
      data_i           :in  std_logic_vector(data_width_g - 1 downto 0);
      data_o           :out std_logic_vector(data_width_g - 1 downto 0)
   );
end component;

begin
   -- Synchronizer for Switch Input
   dut00: generic_sync_arch
      generic map (
         bits => 8
      )
      port map (
         clk     => clk,
         reset   => reset,
         async_i => switch_i,
         sync_o  => switch_s
      );

   dut01: generic_sync_arch
      generic map (
         bits => 2
      )
      port map (
         clk     => clk,
         reset   => reset,
         async_i => op_sel_i,
         sync_o  => op_sel_s
      );

   -- RES for all three button inputs for nsl_s (next state logic)
   dut02: rising_edge_synchronizer
      port map (
         clk   => clk,
         reset => reset,
         input => exe_i,
         edge  => nsl_s(2)
      );

   dut03: rising_edge_synchronizer
      port map (
         clk   => clk,
         reset => reset,
         input => ms_i,
         edge  => nsl_s(1)
      );
      
   dut04: rising_edge_synchronizer
      port map (
         clk   => clk,
         reset => reset,
         input => mr_i,
         edge  => nsl_s(0)
      );
   
   -- State Machine
   dut05: state_machine_four_states
      port map (
         clk   => clk,
         reset => reset,
         nsl_i => nsl_s,
         state_pres_o => state_pres_s
      );
      
   led_o <= state_pres_s;
   
   dut06: generic_memory
      generic map (
         addr_width_g  => 2,
         data_width_g  => 8
      )
      port map (
         clk        => clk,
         write_en_i => write_en_s,
         addr_i     => addr_s,
         data_i     => memory_in_s,
         data_o     => memory_out_s
      );
   

end architecture;
   