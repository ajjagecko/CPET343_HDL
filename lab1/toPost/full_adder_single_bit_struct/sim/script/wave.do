onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {New Group} -color Yellow -itemcolor Maroon /full_adder_single_bit_beh_tb/uut/a_i
add wave -noupdate -expand -group {New Group} -color Yellow -itemcolor Maroon /full_adder_single_bit_beh_tb/uut/b_i
add wave -noupdate -expand -group {New Group} -color Yellow -itemcolor Maroon /full_adder_single_bit_beh_tb/uut/cin_i
add wave -noupdate -expand -group {New Group} -color Yellow -itemcolor Maroon /full_adder_single_bit_beh_tb/uut/sum_o
add wave -noupdate -expand -group {New Group} -color Yellow -itemcolor Maroon /full_adder_single_bit_beh_tb/uut/cout_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {14103 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 112
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ps} {105 ns}
