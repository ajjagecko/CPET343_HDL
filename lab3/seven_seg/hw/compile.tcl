# Dr. Kaputa
# Quartus II compile script for DE1-SoC board

# 1] name your project here
set project_name "seven_seg_dut"

file delete -force project
file delete -force output_files
file mkdir project
cd project
load_package flow
project_new $project_name
set_global_assignment -name FAMILY Cyclone
set_global_assignment -name DEVICE 5CSEMA5F31C6 
set_global_assignment -name TOP_LEVEL_ENTITY seven_seg
set_global_assignment -name PROJECT_OUTPUT_DIRECTORY ../output_files

# 2] include your relative path files here
set_global_assignment -name VHDL_FILE ../../src/seven_seg_dut.vhd
set_global_assignment -name VHDL_FILE ../../src/generic_adder_arch.vhd
set_global_assignment -name VHDL_FILE ../../src/full_adder_single_bit_arch.vhd
set_global_assignment -name VHDL_FILE ../../src/generic_counter.vhd

# 3] Set pin assignments
set_location_assignment -to seven_seg_o[6] PIN_AH28
set_location_assignment -to seven_seg_o[5] PIN_AG28
set_location_assignment -to seven_seg_o[4] PIN_AF28
set_location_assignment -to seven_seg_o[3] PIN_AG27
set_location_assignment -to seven_seg_o[2] PIN_AE28
set_location_assignment -to seven_seg_o[1] PIN_AE27
set_location_assignment -to seven_seg_o[0] PIN_AE26
set_location_assignment -to reset_i PIN_AB12

execute_flow -compile
project_close