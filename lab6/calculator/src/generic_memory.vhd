--------------------------
-- Dr. Kaputa
-- Memory Generic
--------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity generic_memory is
   generic (addr_width_g : integer := 2;
            data_width_g : integer := 4);
   port (
      clk            :in  std_logic;
      write_en_i       :in  std_logic;
      addr_i           :in  std_logic_vector(addr_width_g - 1 downto 0);
      data_i           :in  std_logic_vector(data_width_g - 1 downto 0);
      data_o           :out std_logic_vector(data_width_g - 1 downto 0)
   );
end generic_memory;

architecture beh of generic_memory is

type ram_type is array ((2 ** addr_width_g - 1) downto 0) of std_logic_vector(data_width_g - 1 downto 0);
signal ram_s :ram_type :=(others=> (others => '0'));

begin

process(clk)
   begin
      if (clk'event and clk = '1') then
         if(write_en_i = '1') then
            ram_s(to_integer(unsigned(addr_i))) <= data_i;
         end if
         data_o <= ram_s(to_integer(unsigned(addr_i)));
      end if;
   end process;
   
end beh;