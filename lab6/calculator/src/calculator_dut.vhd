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
use ieee.std_logic_1164.all
use ieee.numeric_std.all

entity calculator_dut is
   port(
      clk         :in std_logic;
      reset       :in std_logic;
      mr_i        :in std_logic;
      ms_i        :in std_logic;
      exe_i       :in std_logic;
      op_sel_i    :in std_logic_vector(1 downto 0);
      switch_i    :in std_logic_vector(7 downto 0)
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

-- Internal Memory Addr Constants
constant WORK_ADDR   : std_logic_vector(1 downto 0) := "01";
constant SAVE_ADDR   : std_logic_vector(1 downto 0) := "10";

-- Double Dabble Output Signals
signal dd_hun_s      : std_logic_vector(3 downto 0);
signal dd_ten_s      : std_logic_vector(3 downto 0);
signal dd_one_s      : std_logic_vector(3 downto 0);


begin




end architecture;
   