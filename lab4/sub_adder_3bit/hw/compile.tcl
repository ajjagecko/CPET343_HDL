# Dr. Kaputa
# Quartus II compile script for DE1-SoC board

# 1] name your project here
set project_name "sub_adder_3bit"

file delete -force project
file delete -force output_files
file mkdir project
cd project
load_package flow
project_new $project_name
set_global_assignment -name FAMILY Cyclone
set_global_assignment -name DEVICE 5CSEMA5F31C6 
set_global_assignment -name TOP_LEVEL_ENTITY sub_adder_3bit
set_global_assignment -name PROJECT_OUTPUT_DIRECTORY ../output_files

# 2] include your relative path files here
set_global_assignment -name VHDL_FILE ../../src/sub_adder_3bit_top.vhd
set_global_assignment -name VHDL_FILE ../../src/rising_edge_synchronizer.vhd
set_global_assignment -name VHDL_FILE ../../src/generic_sync_arch.vhd
set_global_assignment -name VHDL_FILE ../../src/generic_adder_arch/generic_adder_arch.vhd
set_global_assignment -name VHDL_FILE ../../src/generic_adder_arch/full_adder_single_bit_arch.vhd
set_global_assignment -name VHDL_FILE ../../src/bcd/bcd_4bit.vhd
set_global_assignment -name VHDL_FILE ../../src/two_bit_comp/src/two_bit_comp.vhd
set_global_assignment -name VHDL_FILE ../../src/synchronizer.vhd

set_location_assignment PIN_AB12 -to reset
set_location_assignment PIN_AF14 -to clk
set_location_assignment PIN_AC9  -to a_i[0]
set_location_assignment PIN_AD10 -to a_i[1]
set_location_assignment PIN_AE12 -to a_i[2]
set_location_assignment PIN_AD11 -to b_i[0]
set_location_assignment PIN_AD12 -to b_i[1]
set_location_assignment PIN_AE11 -to b_i[2]

set_location_assignment PIN_AA24 -to a_bcd_o[0]
set_location_assignment PIN_Y23  -to a_bcd_o[1]
set_location_assignment PIN_Y24  -to a_bcd_o[2]
set_location_assignment PIN_W22  -to a_bcd_o[3]
set_location_assignment PIN_W24  -to a_bcd_o[4]
set_location_assignment PIN_V23  -to a_bcd_o[5]
set_location_assignment PIN_W25  -to a_bcd_o[6]

set_location_assignment PIN_AB23 -to b_bcd_o[0]
set_location_assignment PIN_AE29 -to b_bcd_o[1]
set_location_assignment PIN_AD29 -to b_bcd_o[2]
set_location_assignment PIN_AC28 -to b_bcd_o[3]
set_location_assignment PIN_AD30 -to b_bcd_o[4]
set_location_assignment PIN_AC29 -to b_bcd_o[5]
set_location_assignment PIN_AC30 -to b_bcd_o[6]

set_location_assignment PIN_AE26 -to result_bcd_o[0]
set_location_assignment PIN_AE27 -to result_bcd_o[1]
set_location_assignment PIN_AE28 -to result_bcd_o[2]
set_location_assignment PIN_AG27 -to result_bcd_o[3]
set_location_assignment PIN_AF28 -to result_bcd_o[4]
set_location_assignment PIN_AG28 -to result_bcd_o[5]
set_location_assignment PIN_AH28 -to result_bcd_o[6]

set_location_assignment PIN_AA15 -to add_btn_i
set_location_assignment PIN_AA14 -to sub_btn_i

execute_flow -compile
project_close