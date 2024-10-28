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
      addr_o        :out std_logic_vector(1 downto 0);
      write_en_o    :out std_logic;
      memory_in_o   :out std_logic_vector(7 downto 0);
      state_pres_o  :out std_logic_vector(3 downto 0);
      state_next_o  :out std_logic_vector(3 downto 0);
      memory_out_o         :out std_logic_vector(7 downto 0);
      memory_out_padded_o  :out std_logic_vector(11 downto 0);
      
      bcd_one_o :out std_logic_vector(6 downto 0)
   );
end calculator_dut;


architecture beh of calculator_dut is

-- Synchronized Inputs
signal nsl_s         : std_logic_vector(2 downto 0);
signal op_sel_s      : std_logic_vector(1 downto 0);
signal switch_s      : std_logic_vector(7 downto 0);

-- Internal Memory Signals
signal alu_out_s            : std_logic_vector(7 downto 0);
signal memory_in_s          : std_logic_vector(7 downto 0);
signal memory_out_s         : std_logic_vector(7 downto 0) := "00000000";
signal memory_out_padded_s  : std_logic_vector(11 downto 0);

signal addr_s        : std_logic_vector(1 downto 0);
signal write_en_s    : std_logic := '0';
signal flag_s        :std_logic  :='0';

-- Internal Memory Addr Constants
constant WORK_ADDR   : std_logic_vector(1 downto 0) := "00";
constant SAVE_ADDR   : std_logic_vector(1 downto 0) := "01";

-- Double Dabble Output Signals
signal dd_hun_s      : std_logic_vector(3 downto 0);
signal dd_ten_s      : std_logic_vector(3 downto 0);
signal dd_one_s      : std_logic_vector(3 downto 0);

-- Present State 
signal state_pres_s  : std_logic_vector(3 downto 0);
signal state_next_s  : std_logic_vector(3 downto 0);
constant execute_state :std_logic_vector(3 downto 0) := "1000";
constant ms_state      :std_logic_vector(3 downto 0) := "0100";
constant mr_state      :std_logic_vector(3 downto 0) := "0010";
constant reset_state   :std_logic_vector(3 downto 0) := "0001";

-- State Machine Component
component state_machine_four_states is
   port (
      clk             :in  std_logic;
      reset           :in  std_logic;
      nsl_i           :in  std_logic_vector(2 downto 0);
      state_pres_o    :out std_logic_vector(3 downto 0);
      state_next_o    :out std_logic_vector(3 downto 0)
      
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
      clk               : in std_logic;
      we                : in std_logic;
      addr              : in std_logic_vector(addr_width_g - 1 downto 0);
      din               : in std_logic_vector(data_width_g - 1 downto 0);
      dout              : out std_logic_vector(data_width_g - 1 downto 0)
   );
end component;

begin
   state_pres_o <= state_pres_s;
   state_next_o <= state_next_s;
   addr_o       <= addr_s;
   memory_in_o  <= memory_in_s;
   write_en_o   <= write_en_s ;
   memory_out_o        <= memory_out_s;
   memory_out_padded_o <= memory_out_padded_s;
   
   
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
         state_pres_o => state_pres_s,
         state_next_o => state_next_s
      );
      
   led_o <= state_pres_s;
   
   dut06: generic_memory
      generic map (
         addr_width_g  => 2,
         data_width_g  => 8
      )
      port map (
         clk  => clk,
         we   => write_en_s,
         addr => addr_s,
         din  => memory_in_s,
         dout => memory_out_s
      );
      
   dut07: process(clk,state_next_s, state_pres_s)
      begin
         addr_s <= addr_s;
         write_en_s <= write_en_s;
         memory_in_s <= memory_in_s;
         case state_next_s is
            when reset_state =>
                  addr_s <= WORK_ADDR;
                  write_en_s <= '0';
                  memory_in_s <= memory_in_s;
            when mr_state =>
               if(state_next_s /= state_pres_s) then
                  addr_s <= SAVE_ADDR;
                  write_en_s <= '0';
                  flag_s <= '1';
               else
                  addr_s <= WORK_ADDR;
                  write_en_s <= '1';
                  if (flag_s = '1') then
                     memory_in_s <= memory_out_s;
                     flag_s <= '0';
                  end if;
               end if;
            when ms_state =>
               if(state_next_s /= state_pres_s) then
                  addr_s <= WORK_ADDR;
                  write_en_s <= '0';
                  flag_s <= '1';
               else
                  addr_s <= SAVE_ADDR;
                  write_en_s <= '1';
                  if (flag_s = '1') then
                     memory_in_s <= memory_out_s;
                     flag_s <= '0';
                  end if;
               end if;
            when execute_state =>
                  addr_s <= WORK_ADDR;
                  write_en_s <= '1';
                  memory_in_s <= switch_s;
            when others =>
                  addr_s <= WORK_ADDR;
                  write_en_s <= '0';
                  memory_in_s <= memory_in_s;
         end case;
      end process;
      
   memory_out_padded_s <= "0000" & memory_out_s;
   
   dut10: double_dabble
      port map (
         result_padded => memory_out_padded_s,
         ones          => dd_one_s,
         tens          => dd_ten_s,
         hundreds      => dd_hun_s
      );
      
   dut11: bcd_4bit
      port map (
         bcd_i   =>   dd_hun_s,
         bcd_o   =>   bcd_hun_o
      );
   
   dut12: bcd_4bit
      port map (
         bcd_i   =>   dd_ten_s,
         bcd_o   =>   bcd_ten_o
      );
      
   dut13: bcd_4bit
      port map (
         bcd_i   =>   dd_one_s,
         bcd_o   =>   bcd_one_o
      );
end architecture;
   