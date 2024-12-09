vlib work
vcom -93 -work work ../../src/rom_data/rom_data.vhd
vcom -93 -work work ../../src/rom_instructions/rom_instructions.vhd
vcom -93 -work work ../../src/rising_edge_synchronizer.vhd
vcom -93 -work work ../../src/state_machine_five_states.vhd
vcom -93 -work work ../../src/dj_roomba_3000.vhd
vcom -93 -work work ../src/blink_block_mem_tb.vhd
vsim -voptargs=+acc blink_block_mem_tb
do wave.do
run 2 us