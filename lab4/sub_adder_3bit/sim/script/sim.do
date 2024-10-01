vlib work
vcom -93 -work work ../../src/sub_adder_3bit_top.vhd
vcom -93 -work work ../../src/rising_edge_synchronizer.vhd
vcom -93 -work work ../../src/generic_sync_arch.vhd
vcom -93 -work work ../../src/generic_adder_arch/generic_adder_arch.vhd
vcom -93 -work work ../../src/generic_adder_arch/full_adder_single_bit_arch.vhd
vcom -93 -work work ../../src/bcd/bcd_4bit.vhd
vcom -93 -work work ../../src/two_bit_comp/src/two_bit_comp.vhd
vcom -93 -work work ../src/sub_adder_3bit_tb.vhd
vsim -voptargs=+acc -msgmode both sub_adder_3bit_tb
do wave.do
run 3000 ns