library ieee;
use ieee.std_logic_1164.all;     
use ieee.numeric_std.all; 
library work;
use work.cpet_343_components.all;

entity eight_bit_sub_adder is
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
end eight_bit_sub_adder;

architecture beh of eight_bit_sub_adder is

type STATE_TYPE is (st_input_a, st_input_b, st_disp_sum, st_disp_diff);
signal state_next_s, state_pres_s :STATE_TYPE;

signal btn_sync_s    :std_logic;
signal carry_out_s   :std_logic;

signal switch_sync_s :std_logic_vector(7 downto 0);
signal a_in_s        :std_logic_vector(8 downto 0);
signal b_in_s        :std_logic_vector(8 downto 0);
signal sub_en_s      :std_logic;
signal sum_s         :std_logic_vector(8 downto 0);

signal display_sel_s   :std_logic_vector(11 downto 0);
signal dd_hun_s      :std_logic_vector(3 downto 0);
signal dd_ten_s      :std_logic_vector(3 downto 0);
signal dd_one_s      :std_logic_vector(3 downto 0);

component double_dabble is
  port (
    result_padded           : in  std_logic_vector(11 downto 0); 
    ones                    : out std_logic_vector(3 downto 0);
    tens                    : out std_logic_vector(3 downto 0);
    hundreds                : out std_logic_vector(3 downto 0)
  );  
end component; 

begin
   -- Synchronizer for switch_i
   dut00: generic_sync_arch
      generic map (
         bits => 8
      )
      port map (
         clk     => clk,
         reset   => reset,
         async_i => switch_i,
         sync_o  => switch_sync_s
      );
   -- Synchronizer for btn_i
   dut01: rising_edge_synchronizer
      port map (
         clk   => clk,
         reset => reset,
         input => btn_i,
         edge  => btn_sync_s
      );
   -- Reset for State Machine
	dut02:process(clk,reset) is
      begin
         if(reset = '1') then
            state_pres_s <= st_input_a;
         elsif(clk'event and clk = '1') then
            state_pres_s <= state_next_s;
         end if;
      end process;
   
   -- State Machine
   dut03: process(state_pres_s, btn_sync_s)
      begin
         case state_pres_s is
         
            when st_input_a =>
               led_o <= "0001";
               if (btn_sync_s = '1') then
                  state_next_s <= st_input_b;
               else
                  state_next_s <= st_input_a;
               end if;
               
            when st_input_b =>
               led_o <= "0010";
               if (btn_sync_s = '1') then
                  state_next_s <= st_disp_sum;
               else
                  state_next_s <= st_input_b;
               end if;
               
            when st_disp_sum =>
               led_o <= "0100";
               if (btn_sync_s = '1') then
                  state_next_s <= st_disp_diff;
               else
                  state_next_s <= st_disp_sum;
               end if;
               
            when st_disp_diff =>
               led_o <= "1000";
               if (btn_sync_s = '1') then
                  state_next_s <= st_input_a;
               else
                  state_next_s <= st_disp_diff;
               end if;
               
            when others =>
               state_next_s <= state_pres_s; --NEXT TIME: MOVE THIS OUT OF when others AND ADD IT ABOVE CASE STATEMENT TO AVOID LATCHES!!!!!
               
         end case;
      end process;
   
   dut04: process(state_pres_s)
      begin
         case state_pres_s is
            when st_disp_diff => sub_en_s <= '1';
            when others       => sub_en_s <= '0';
         end case;
      end process;
      
   dut05: process(state_pres_s, switch_sync_s)
      begin
         case state_pres_s is
            when st_input_a => a_in_s <= '0' & switch_sync_s;
            when others     => a_in_s <= a_in_s;
         end case;
      end process;
      
   dut06: process(state_pres_s, switch_sync_s)
      begin
         case state_pres_s is
            when st_input_b => b_in_s <= '0' & switch_sync_s;
            when others     => b_in_s <= b_in_s;
         end case;
      end process;
   
   dut07: process(state_pres_s, a_in_s, b_in_s, carry_out_s, sum_s)
      begin
         case state_pres_s is
            when st_input_a   => display_sel_s <= "000" & a_in_s;
            when st_input_b   => display_sel_s <= "000" & b_in_s;
            when st_disp_sum  => display_sel_s <= "000" & sum_s;
            when st_disp_diff => display_sel_s <= "000" & sum_s;
            when others       => display_sel_s <= display_sel_s;
         end case;
      end process;
   
   dut08: generic_sub_arch
      generic map (
         bits => 9
      )
      port map (
         a_i      => a_in_s,
         b_i      => b_in_s,
         carry_i  => '0',
         sub_en_i => sub_en_s,
         sum_o    => sum_s,
         carry_o  => carry_out_s
      );
      
   dut09: double_dabble
      port map (
         result_padded => display_sel_s,
         ones          => dd_one_s,
         tens          => dd_ten_s,
         hundreds      => dd_hun_s
      );
      
   dut10: bcd_4bit
      port map (
         bcd_i   =>   dd_hun_s,
         bcd_o   =>   bcd_hun_o
      );
   
   dut11: bcd_4bit
      port map (
         bcd_i   =>   dd_ten_s,
         bcd_o   =>   bcd_ten_o
      );
      
   dut12: bcd_4bit
      port map (
         bcd_i   =>   dd_one_s,
         bcd_o   =>   bcd_one_o
      );
end architecture;
