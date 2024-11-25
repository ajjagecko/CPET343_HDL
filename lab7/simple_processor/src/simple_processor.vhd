-------------------------------------------------------------------------------
-- Name: Andrew Akre
-- Course: CPET 343
-- Task:
--    Lab 7 Calculator
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

entity simple_processor is
   port(
      clk         :in std_logic;
      reset       :in std_logic;
      exe_btn_i   :in std_logic;
      bcd_hun_o   :out std_logic_vector(6 downto 0);
      bcd_ten_o   :out std_logic_vector(6 downto 0);
      bcd_one_o   :out std_logic_vector(6 downto 0);
      led_o       :out std_logic_vector(3 downto 0)
   );
end simple_processor;

architecture beh of simple_processor is

-- Synchronized execution button
signal exe_btn_s : std_logic;
signal reset_s : std_logic;

signal pc_s      : std_logic_vector(4 downto 0) := "00000";
signal pc_count_s      : std_logic_vector(4 downto 0) := "00000";
signal next_pc_s      : std_logic_vector(4 downto 0);

-- Instruction set and mapping aliases
signal instruct_set_orig_s : std_logic_vector(12 downto 0);
signal instruct_set_s : std_logic_vector(12 downto 0);
signal flag :integer := 0;
alias exe_a    : std_logic                    is instruct_set_s(12);
alias opcode_a : std_logic_vector(1 downto 0) is instruct_set_s(11 downto 10);
alias mr_a     : std_logic                    is instruct_set_s(9);
alias ms_a     : std_logic                    is instruct_set_s(8);
alias in_b_a   : std_logic_vector(7 downto 0) is instruct_set_s(7 downto 0);

-- Lab 6 component declaration
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

component blink_rom
  PORT(
    address         : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
    clock           : IN STD_LOGIC  := '1';
    q               : OUT STD_LOGIC_VECTOR (12 DOWNTO 0)
  );
end component;

begin
   reset_s <= not reset;
   
   -- RES for Execute Button
   dut00: rising_edge_synchronizer
      port map (
         clk   => clk,
         reset => reset_s,
         input => exe_btn_i,
         edge  => exe_btn_s
      );
      
   -- Logic for determining PC
   dut01 : process(exe_btn_s, pc_s, clk)
      begin
         pc_s <= pc_s;
         if (reset_s = '1') then
            pc_s <= "00000";
            pc_count_s <= "00000";
         elsif (clk'event and clk = '1') then 
            if exe_btn_s = '1' then
               pc_s <= next_pc_s;
               pc_count_s <= next_pc_s;
               flag <= 1;
            elsif flag < 4 then
               flag <= flag + 1;
            else
               pc_s <= "00000";
               flag <= 0;
            end if;
         end if;
      end process;
   
   dut04 : generic_adder_arch
      generic map (
         bits => 5
      )
      port map (
         a     => pc_count_s,
         b     => "00001",
         cin   => '0',
         sum   => next_pc_s,
         cout  => open
      );
   
   -- Memory for Instruction Sets
   dut02 : blink_rom 
   port map (
      address     => pc_s,
      clock       => clk,
      q           => instruct_set_s
   );
   
   -- Calculator_Dut Initialization
   dut03 : calculator_dut
      port map(
         clk       =>   clk,
         reset     =>   reset_s,
         mr_i      =>   mr_a,
         ms_i      =>   ms_a,
         exe_i     =>   exe_a,
         op_sel_i  =>   opcode_a,
         switch_i  =>   in_b_a,
         led_o     =>   led_o,
         bcd_hun_o =>   bcd_hun_o,
         bcd_ten_o =>   bcd_ten_o,
         bcd_one_o =>   bcd_one_o
   );
   
end architecture;