vlib work
vcom -93 -work work ../../src/seven_seg_dut.vhd
vcom -93 -work work ../../src/generic_adder_arch.vhd
vcom -93 -work work ../../src/full_adder_single_bit_arch.vhd
vcom -93 -work work ../../src/generic_counter.vhd
vcom -93 -work work ../src/seven_seg_tb.vhd
vsim -voptargs=+acc -msgmode both seven_seg_tb
do wave.do
run 6 us