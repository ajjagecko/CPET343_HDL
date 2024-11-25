onerror {resume}
radix define States {
    "7'b1000000" "0" -color "red",
    "7'b1111001" "1" -color "red",
    "7'b0100100" "2" -color "red",
    "7'b0110000" "3" -color "red",
    "7'b0011001" "4" -color "red",
    "7'b0010010" "5" -color "red",
    "7'b0000010" "6" -color "red",
    "7'b1111000" "7" -color "red",
    "7'b0000000" "8" -color "red",
    "7'b0011000" "9" -color "red",
    "7'b0001000" "a" -color "red",
    "7'b0000011" "b" -color "red",
    "7'b0100111" "c" -color "red",
    "7'b0100001" "d" -color "red",
    "7'b0000110" "e" -color "red",
    "7'b0001110" "f" -color "red",
    -default default
}
quietly WaveActivateNextPane {} 0
add wave -noupdate /blink_block_mem_tb/clk
add wave -noupdate /blink_block_mem_tb/reset
add wave -noupdate /blink_block_mem_tb/exe_btn_i


add wave -noupdate /blink_block_mem_tb/led_o

add wave -noupdate /blink_block_mem_tb/uut/pc_s
add wave -noupdate /blink_block_mem_tb/uut/instruct_set_s
add wave -noupdate /blink_block_mem_tb/uut/exe_btn_s
add wave -noupdate /blink_block_mem_tb/uut/dut03/exe_i
add wave -noupdate /blink_block_mem_tb/uut/dut03/mr_i
add wave -noupdate /blink_block_mem_tb/uut/dut03/ms_i
add wave -noupdate /blink_block_mem_tb/uut/dut03/nsl_s
add wave -noupdate /blink_block_mem_tb/uut/dut03/op_sel_s
add wave -noupdate /blink_block_mem_tb/uut/dut03/switch_s
add wave -noupdate /blink_block_mem_tb/uut/dut03/alu_out_s
add wave -noupdate /blink_block_mem_tb/uut/dut03/memory_out_s
add wave -noupdate /blink_block_mem_tb/uut/dut03/state_next_s
add wave -noupdate /blink_block_mem_tb/uut/dut03/state_pres_s

add wave -noupdate -radix States /blink_block_mem_tb/bcd_hun_o
add wave -noupdate -radix States /blink_block_mem_tb/bcd_ten_o
add wave -noupdate -radix States /blink_block_mem_tb/bcd_one_o


TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {50000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 177
configure wave -valuecolwidth 40
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {400250 ps} {505250 ps}
