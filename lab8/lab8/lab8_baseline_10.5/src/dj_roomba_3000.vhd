-- Dr. Kaputa
-- Lab 8: DJ Roomba 3000 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dj_roomba_3000 is 
  port(
    clk                 : in std_logic;
    reset               : in std_logic;
    execute_btn         : in std_logic;
    sync                : in std_logic;
    led                 : out std_logic_vector(7 downto 0);
    audio_out           : out std_logic_vector(15 downto 0)
  );
end dj_roomba_3000;

architecture beh of dj_roomba_3000 is
  -- instruction memory
  component rom_instructions
    port(
      address    : in std_logic_vector (4 DOWNTO 0);
      clock      : in std_logic  := '1';
      q          : out std_logic_vector (7 DOWNTO 0)
    );
  end component;
  
  -- data memory
  component rom_data
    port(
      address  : in std_logic_vector (13 DOWNTO 0);
      clock    : in std_logic  := '1';
      q        : out std_logic_vector (15 DOWNTO 0)
    );
  end component;
  
  component state_machine_five_states is
    port (
      clk             :in  std_logic;
      reset           :in  std_logic;
      exe_i           :in  std_logic;
      error_i         :in  std_logic;
      state_pres_o    :out std_logic_vector(4 downto 0);
      state_next_o    :out std_logic_vector(4 downto 0)
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
  
  component generic_counter is
    generic (
      max_count       : integer range 0 to 10000 := 3
    );
    port (
      clk             : in  std_logic; 
      reset           : in  std_logic;
      output          : out std_logic
    );  
  end component;  

  
signal data_address       : std_logic_vector(13 downto 0);
signal next_data_address  : std_logic_vector(13 downto 0);

signal error_s       : std_logic;
signal counter_sync  : std_logic;
signal execute_btn_s : std_logic;

signal pc_s          : std_logic_vector (4 DOWNTO 0) := "00000";
signal next_pc_s     : std_logic_vector (4 DOWNTO 0) := "00000";

signal instruction_next_s : std_logic_vector(7 downto 0);
signal instruction_s : std_logic_vector(7 downto 0);
alias status_code    : std_logic_vector(1 downto 0) is instruction_s(7 downto 6);
alias repeat_code    : std_logic                    is instruction_s(5);
alias seek_code      : std_logic_vector(4 downto 0) is instruction_s(4 downto 0);

constant idle_state_c    :std_logic_vector(4 downto 0) := "00001";
constant fetch_state_c   :std_logic_vector(4 downto 0) := "00010";
constant decode_state_c  :std_logic_vector(4 downto 0) := "00100";
constant derror_state_c  :std_logic_vector(4 downto 0) := "01000";
constant exec_state_c    :std_logic_vector(4 downto 0) := "10000";

signal state_next_s, state_pres_s  :std_logic_vector(4 downto 0);

begin

-- RES for Execute Button
 dut00: rising_edge_synchronizer
    port map (
       clk   => clk,
       reset => reset,
       input => execute_btn,
       edge  => execute_btn_s
    );
      
-- data instantiation
u_rom_data_inst : rom_data
  port map (
    address    => data_address,
    clock      => clk,
    q          => audio_out
  );
  
u_rom_instruct_inst : rom_instructions
  port map(
    address    => pc_s,
    clock      => clk,
    q          => instruction_next_s
  );
   
  
u_state_machine_inst : state_machine_five_states
  port map(
    clk           => clk,
    reset         => reset,
    exe_i         => execute_btn_s,
    error_i       => error_s,
    state_pres_o  => state_pres_s,
    state_next_o  => state_next_s
  );
  
u_pc_logic: process(pc_s, clk, reset, state_pres_s)
  begin
     pc_s <= pc_s;
     if (reset = '1') then
        pc_s <= "00000";
        next_pc_s <= "00001";
     elsif (clk'event and clk = '1') then 
        if state_pres_s = fetch_state_c then
          pc_s <= next_pc_s;
          next_pc_s <= std_logic_vector(unsigned(next_pc_s) + 1 );
        end if;
     end if;
  end process;
    
u_error_logic : process(clk, error_s, state_pres_s, instruction_next_s)
   begin
      if reset = '1' then
         instruction_s <= "11000000";
      elsif state_pres_s = decode_state_c then
         if (instruction_next_s = "10000000" ) or (instruction_next_s = "10100000") then
            error_s <= '1';
            instruction_s <= instruction_s;
         else
            error_s <= '0';
            instruction_s <= instruction_next_s;
         end if;
      end if;
   end process;
    
u_generic_count_inst : generic_counter
  generic map(
    max_count => 6104
  )
  port map(
    clk        => clk,
    reset      => reset,
    output     => counter_sync
  );  

  -- loop audio file
u_data_addr_logic: process(clk, reset, counter_sync, status_code, data_address, next_data_address, seek_code, repeat_code)
  begin 
    if (reset = '1') then 
      data_address <= (others => '0');
    elsif (clk'event and clk = '1') then
      if counter_sync = '1' then
         case status_code is
            when "00" =>
               if (next_data_address = "00000000000000") then 
                  if repeat_code = '0' then
                     data_address <= data_address;
                  else
                     data_address <= next_data_address;
                  end if;
               else
                  data_address <= next_data_address;
               end if;
            
            when "01" =>
               data_address <= data_address;
               
            when "10" =>
               data_address <= seek_code & "000000000";
               
            when "11" =>
               data_address <= "00000000000000";
               
            when others => 
               data_address <= data_address;
         end case;
      end if;
   end if;
   next_data_address <= std_logic_vector(unsigned(data_address) + 1 );
   end process;
  
  led <= instruction_s;
  
end beh;