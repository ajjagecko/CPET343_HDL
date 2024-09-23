-------------------------------------------------------------------------------
-- Name: Andrew Akre
-- Course: CPET 343
-- Assignment: Lab 1
-- Task:
--    Structural Implementation of Single Bit Adder with Carry Over
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;     
use ieee.numeric_std.all; 

entity seven_seg is
port (
   clk_Mhz_i   :in std_logic;
   reset_i     :in std_logic;
   bcd_i       :in std_logic_vector(3 downto 0);
   seven_seg_o :out std_logic_vector(6 downto 0)
   );
end seven_seg;

architecture structural of seven_seg is

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

component generic_counter is
  generic (
    max_count       : integer := 3
  );
  port (
    clk             : in  std_logic; 
    reset           : in  std_logic;
    output          : out std_logic
  );  
end component;

constant bits_c : integer := 4;
constant max_count_c : integer := 2;

signal sum_reg_in_s   :std_logic_vector(bits_c-1 downto 0);
signal sum_reg_out_s  :std_logic_vector(bits_c-1 downto 0) := "0000";
signal c_s         : std_logic := '0';
signal enable_s  :std_logic;

begin

   dut0: generic_counter
      generic map (
         max_count => max_count_c
      )
      port map (
         clk => clk_Mhz_i, 
         reset => reset_i,
         output => enable_s
      );
      
      
   dut1: generic_adder_arch
      generic map (
         bits => bits_c
      )
      port map (
         a => sum_reg_out_s,
         b => bcd_i,
         cin => c_s,
         sum => sum_reg_in_s,
         cout => c_s
      );
      
   process(clk_Mhz_i, enable_s, sum_reg_in_s)
      begin
         if(clk_Mhz_i'event and clk_Mhz_i = '1') then
            if(enable_s = '1') then
               sum_reg_out_s <= sum_reg_in_s;
            --else
               --sum_reg_out_s <= "0000";
            end if;
         end if;
      end process;
      
      
   bcd: process(sum_reg_out_s)
      begin
         case bcd_i is
            when "0000" => seven_seg_o <= "1000000";
            when "0001" => seven_seg_o <= "1111001";
            when "0010" => seven_seg_o <= "0100100";
            when "0011" => seven_seg_o <= "0110000";
            when "0100" => seven_seg_o <= "0011001";
            when "0101" => seven_seg_o <= "0010010";
            when "0110" => seven_seg_o <= "0000010";
            when "0111" => seven_seg_o <= "1111000";
            when "1000" => seven_seg_o <= "0000000";
            when "1001" => seven_seg_o <= "0011000";
            when others => seven_seg_o <= "1111111";
         end case;
      end process;

end structural;
   