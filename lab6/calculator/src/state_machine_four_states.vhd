-------------------------------------------------------------------------------
-- Name: Andrew Akre
-- Course: CPET 343
-- Task:
--    Generic State Machine cor
--    Last Updated: 21/10//2024
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all
use ieee.numeric_std.all

entity state_machine_four_states is
   port (
      clk             :in  std_logic;
      reset           :in  std_logic;
      nsl_i           :in  std_logic_vector(2 downto 0);
      state_pres_o    :out std_logic_vector(3 downto 0)
   );
end entity state_machine_four_states;

architecture beh of state_machine_four_states is

signal execute_state :std_logic_vector(3 downto 0) := "1000";
signal ms_state      :std_logic_vector(3 downto 0) := "0100";
signal mr_state      :std_logic_vector(3 downto 0) := "0010";
signal reset_state   :std_logic_vector(3 downto 0) := "0001";

signal state_next_s  :std_logic_vector(3 downto 0);

begin

   state_creation: for i in 0 to states-1 generate
      zeros(i) := '1';
      encode(i) := zeros;
      zeros(i) := '0';
   end generate;
   
   state_reset:process(clk,reset) is
      begin
         state_pres_o <= state_pres;            --Avoiding latch
         if(reset = '1') then
            state_pres_s <= reset_state;        --ALWAYS USES encode(0) FOR RESET
         elsif(clk'event and clk = '1') then
            state_pres_s <= state_next_s;
         end if;
      end process;
   
   next_state_logic: process(state_pres_s, btn_sync_s)
      begin
         case state_pres_s 
         
            when reset_state =>
               case nsl_i is
                  when "001" =>
                     state_next_s <= mr_state;
                  when "010" =>
                     state_next_s <= ms_state;
                  when "100" => 
                     state_next_s <= execute_state;
                  when others =>
                     state_next_s <= reset_state;
               end case;
                  
            when mr_state =>
               case nsl_i is
                  when "010" =>
                     state_next_s <= ms_state;
                  when "100" => 
                     state_next_s <= execute_state;
                  when others =>
                     state_next_s <= mr_state;
               end case;
               
            when ms_state =>
               case nsl_i is
                  when "001" =>
                     state_next_s <= mr_state;
                  when "100" =>
                     state_next_s <= execute_state;
                  when others =>
                     state_next_s <= ms_state;
               end case;
               
            when execute =>
               case nsl_i is
                  when "001" =>
                     state_next_s <= mr_state;
                  when "010" =>
                     state_next_s <= ms_state;
                  when others =>
                     state_next_s <= execute_state;
               end case;
               
            when others =>
               state_next_s <= state_pres_s; --NEXT TIME: MOVE THIS OUT OF when others AND ADD IT ABOVE CASE STATEMENT TO AVOID LATCHES!!!!!
               
         end case;
      end process;
end architecture;