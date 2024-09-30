vlib work
vcom -93 -work work ../../src/two_bit_comp.vhd
vcom -93 -work work ../../src/generic_adder_arch/generic_adder_arch.vhd
vcom -93 -work work ../../src/generic_adder_arch/full_adder_single_bit_arch.vhd
vcom -93 -work work ../src/two_bit_comp_tb.vhd
vsim -voptargs=+acc -msgmode both two_bit_comp_tb
do wave.do
run 1 us