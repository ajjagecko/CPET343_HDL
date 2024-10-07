vlib work
vcom -93 -work work ../../src/package_lib/cpet_343_components.vhd
vcom -93 -work work ../../src/package_lib/bcd_4bit.vhd
vcom -93 -work work ../../src/package_lib/rising_edge_synchronizer.vhd
vcom -93 -work work ../../src/package_lib/generic_sync_arch.vhd
vcom -93 -work work ../../src/package_lib/synchronizer.vhd
vcom -93 -work work ../../src/package_lib/generic_sub_arch.vhd
vcom -93 -work work ../../src/package_lib/two_comp.vhd
vcom -93 -work work ../../src/package_lib/generic_adder_arch/generic_adder_arch.vhd
vcom -93 -work work ../../src/package_lib/generic_adder_arch/full_adder_single_bit_arch.vhd

vcom -93 -work work ../../src/eight_bit_sub_adder.vhd
vcom -93 -work work ../src/eight_bit_sub_adder_tb.vhd
vsim -voptargs=+acc -msgmode both eight_bit_sub_adder_tb
do wave.do
run 3000 ns