-------------------------------------------------------------------------------
-- Name: Andrew Akre
-- Course: CPET 343
-- Assignment: Lab 4
-- Task:
--    3 bit sub-adder with BCD displays
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;     
use ieee.numeric_std.all; 

entity sub_adder_3bit is
port (
   clk        :in std_logic;
   reset      :in std_logic;
   a_i        :in std_logic_vector(2 downto 0);
   b_i        :in std_logic_vector(2 downto 0);
   add_btn_i  :in std_logic;
   sub_btn_i  :in std_logic;
   a_bcd_o        :out std_logic_vector(6 downto 0);
   b_bcd_o        :out std_logic_vector(6 downto 0);
   --sum_temp_o     :out std_logic_vector(3 downto 0);
   --sub_sync_o     :out std_logic;
   --add_sync_o     :out std_logic;
   result_bcd_o   :out std_logic_vector(6 downto 0)
   );
end sub_adder_3bit;

architecture behavioral of sub_adder_3bit is

   signal a_sync_s        :std_logic_vector(3 downto 0);
   signal b_sync_s        :std_logic_vector(3 downto 0);
   signal a_async_s        :std_logic_vector(3 downto 0);
   signal b_async_s        :std_logic_vector(3 downto 0);
   signal b_2bc_s         :std_logic_vector(3 downto 0);
   signal b_add_in_s      :std_logic_vector(3 downto 0);
   signal sub_btn_sync_s  :std_logic;
   signal add_btn_sync_s  :std_logic;
   signal sub_enable_s    :std_logic;
   signal prev_sum_s      :std_logic_vector(3 downto 0);
   signal sum_s           :std_logic_vector(3 downto 0);
   
   component generic_adder_arch is 
      generic (
         bits    : integer := 4
      );
      port (
         a       : in  std_logic_vector(bits-1 downto 0);
         b       : in  std_logic_vector(bits-1 downto 0);
         cin     : in  std_logic;
         sum     : out std_logic_vector(bits-1 downto 0);
         cout    : out std_logic
      );
   end component;
   
   component bcd is
      port(
         num_i      :in std_logic_vector(3 downto 0);
         bcd_o     :out std_logic_vector(6 downto 0)
      );
   end component;
   
   component two_bit_comp is
      port(
         unsign_i       :in std_logic_vector(3 downto 0);
         two_bit_comp_o :out std_logic_vector(3 downto 0)
      );
   end component;
   
   component rising_edge_synchronizer is
      port (
         clk               : in std_logic;
         reset             : in std_logic;
         input             : in std_logic;
         edge              : out std_logic
      );
   end component;
   
   component generic_sync_arch is
      generic (
         bits    : integer := 4
      );   
      port (
         clk               : in std_logic;
         reset             : in std_logic;
         async_i           : in std_logic_vector(bits-1 downto 0);
         sync_o            : out std_logic_vector(bits-1 downto 0)
      );
   end component;

begin
   --Assigning switch inputs to 4 bit signals for addition later, I could do this after sync, but chose to do it here since it changed less
   a_async_s <= '0' & a_i;
   b_async_s <= '0' & b_i;
   
   --Synchronizer for a_async_s
   uut0: generic_sync_arch
      generic map (
         bits => 4
      )
      port map(
         clk   => clk,
         reset => reset,
         async_i => a_async_s,
         sync_o  => a_sync_s
      );
   
   --Synchronizer for b_async_s
   uut10: generic_sync_arch
      generic map (
         bits => 4
      )
      port map(
         clk   => clk,
         reset => reset,
         async_i => b_async_s,
         sync_o  => b_sync_s
      );
      
   --RES for add button
   uut7: rising_edge_synchronizer
      port map(
         clk   => clk,
         reset => reset,
         input => add_btn_i,
         edge  => add_btn_sync_s
      );
   
   --RES for sub button
   uut8: rising_edge_synchronizer
      port map(
         clk   => clk,
         reset => reset,
         input => sub_btn_i,
         edge  => sub_btn_sync_s
      );
   
   --Clock for BCD input
   uut9: process(clk, reset)
      begin
         if (clk'event and clk = '1') then
            prev_sum_s <= sum_s;
         end if;   
      end process;
   
   --Two's Complement on b_sync_s
   uut1: two_bit_comp
   port map (
      unsign_i => b_sync_s,
      two_bit_comp_o => b_2bc_s
   );
   
   --Selection Logic for when to add or subtract, and which b to use
   uut2: process(sub_btn_sync_s, add_btn_sync_s, b_2bc_s, b_sync_s)
      begin
         if (reset = '1') then
            sub_enable_s <= '0';
         else
            if(sub_btn_sync_s = '1') then
               sub_enable_s <= '1';
            elsif (add_btn_sync_s = '1') then
               sub_enable_s <= '0';
            end if;
         end if;
         case sub_enable_s is
            when '1' => b_add_in_s <= b_2bc_s;
            when others => b_add_in_s <= b_sync_s;
         end case;
      end process;
      
   --Generic Adder
   uut3: generic_adder_arch
      generic map (
         bits => 4
      )
      port map (
         a => a_sync_s,
         b => b_add_in_s,
         cin => '0',
         sum => sum_s,
         cout => open
      );
   
   --BCD for a_sync
   uut4: bcd
      port map (
         num_i => a_sync_s,
         bcd_o => a_bcd_o
      );
   
   --BCD for b_sync
   uut5: bcd
      port map (
         num_i => b_sync_s,
         bcd_o => b_bcd_o
      );
   
   --BCD for sum
   uut6: bcd
      port map (
         num_i => prev_sum_s,
         bcd_o => result_bcd_o
      );
   
   --sum_temp_o <= sum_s;
   --sub_sync_o <= not sub_btn_sync_s;
   --add_sync_o <= not add_btn_sync_s;
         
end architecture;
