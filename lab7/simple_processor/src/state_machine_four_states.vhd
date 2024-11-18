-------------------------------------------------------------------------------
-- Name: Andrew Akre
-- Course: CPET 343
-- Task:
--    Generic State Machine cor
--    Last Updated: 21/10//2024
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity state_machine_four_states is
   port (
      clk             :in  std_logic;
      reset           :in  std_logic;
      nsl_i           :in  std_logic_vector(2 downto 0);
      state_pres_o    :out std_logic_vector(3 downto 0);
      state_next_o    :out std_logic_vector(3 downto 0)
   );
end entity state_machine_four_states;

architecture beh of state_machine_four_states is

constant execute_state :std_logic_vector(3 downto 0) := "1000";
constant ms_state      :std_logic_vector(3 downto 0) := "0100";
constant mr_state      :std_logic_vector(3 downto 0) := "0010";
constant reset_state   :std_logic_vector(3 downto 0) := "0001";

signal state_next_s, state_pres_s  :std_logic_vector(3 downto 0);
signal state_timer_s               :integer := 0;
--constant timer_max                 :integer := 4;

begin

   state_reset:process(clk,reset) is
      begin
         state_pres_s <= state_pres_s;            --Avoiding latch
         if(reset = '1') then
            state_pres_s <= reset_state;        --ALWAYS USES encode(0) FOR RESET
         elsif(clk'event and clk = '1') then
            state_pres_s <= state_next_s;
         end if;
      end process;
   
   next_state_logic: process(clk, state_pres_s, nsl_i)
      begin
         case state_pres_s is
         
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
   --            if (state_pres_s /= state_next_s) then
   --               state_timer_s <= 0;
   --            end if;
               case nsl_i is
                  when "010" =>
                     state_next_s <= ms_state;
                  when "100" => 
                     state_next_s <= execute_state;
                  when others =>
                  --   if (state_timer_s >= timer_max) then
                  --      state_next_s <= reset_state;
                  --   else
                  --      state_timer_s <= state_timer_s + 1;
                  --      state_next_s <= mr_state;
                  --   end if;
                     state_next_s <= mr_state;
               end case;
               
            when ms_state =>
            --   if (state_pres_s /= state_next_s) then
            --      state_timer_s <= 0;
            --   end if;
               case nsl_i is
                  when "001" =>
                     state_next_s <= mr_state;
                  when "100" =>
                     state_next_s <= execute_state;
                  when others =>
               --      if (state_timer_s >= timer_max) then
               --         state_next_s <= reset_state;
               --     else
               --        state_timer_s <= state_timer_s + 1;
               --        state_next_s <= ms_state;
               --     end if;
                     state_next_s <= ms_state;
               end case;
               
            when execute_state =>
            --  if (state_pres_s /= state_next_s) then
            --     state_timer_s <= 0;
            --  end if;
               case nsl_i is
                  when "001" =>
                     state_next_s <= mr_state;
                  when "010" =>
                     state_next_s <= ms_state;
                  when others =>
               --      if (state_timer_s >= timer_max) then
               --         state_next_s <= reset_state;
               --      else
               --         state_timer_s <= state_timer_s + 1;
               --         state_next_s <= execute_state;
               --      end if;
                     state_next_s <= execute_state;
               end case;
               
            when others =>
               state_next_s <= state_pres_s; --NEXT TIME: MOVE THIS OUT OF when others AND ADD IT ABOVE CASE STATEMENT TO AVOID LATCHES!!!!!
               
         end case;
      end process;
      
      state_pres_o <= state_pres_s;
      state_next_o <= state_next_s;
      
end architecture;