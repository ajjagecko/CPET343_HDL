vlib work
vcom -93 -work work ../../src/flip_flop_one_bit.vhd
vcom -93 -work work ../../src/alu_tri_state_buffer.vhd
vcom -93 -work work ../../src/alu_or.vhd
vcom -93 -work work ../src/tri_state_buffer_tb.vhd
vsim -voptargs=+acc tri_state_buffer_tb
do wave.do
run 200 ns
