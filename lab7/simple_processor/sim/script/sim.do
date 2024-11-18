vlib work

vcom -93 -work work ../../src/package_lib/cpet_343_components.vhd
vcom -93 -work work ../../src/package_lib/bcd_4bit.vhd
vcom -93 -work work ../../src/package_lib/rising_edge_synchronizer.vhd
vcom -93 -work work ../../src/package_lib/generic_sync_arch.vhd
vcom -93 -work work ../../src/package_lib/synchronizer.vhd
vcom -93 -work work ../../src/package_lib/double_dabble.vhd
vcom -93 -work work ../../src/package_lib/generic_adder_arch/generic_adder_arch.vhd
vcom -93 -work work ../../src/package_lib/generic_adder_arch/full_adder_single_bit_arch.vhd
vcom -93 -work work ../../src/generic_memory.vhd
vcom -93 -work work ../../src/alu.vhd
vcom -93 -work work ../../src/state_machine_four_states.vhd
vcom -93 -work work ../../src/calculator_dut.vhd


vcom -93 -work work ../../src/simple_processor.vhd
vcom -93 -work work ../src/blink_block_mem_tb.vhd
vsim -voptargs=+acc -msgmode both blink_block_mem_tb
do wave.do
run 3000 ns