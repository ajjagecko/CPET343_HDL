# Dr. Kaputa
# Quartus II compile script for DE1-SoC board

# 1] name your project here
set project_name "simple_processor"

file delete -force project
file delete -force output_files
file mkdir project
cd project
load_package flow
project_new $project_name
set_global_assignment -name FAMILY Cyclone
set_global_assignment -name DEVICE 5CSEMA5F31C6 
set_global_assignment -name TOP_LEVEL_ENTITY simple_processor
set_global_assignment -name PROJECT_OUTPUT_DIRECTORY ../output_files

# 2] include your relative path files here
set_global_assignment -name QIP_FILE ../../src/rom/blink_rom.qip
set_global_assignment -name VHDL_FILE ../../src/package_lib/bcd_4bit.vhd
set_global_assignment -name VHDL_FILE ../../src/package_lib/rising_edge_synchronizer.vhd
set_global_assignment -name VHDL_FILE ../../src/package_lib/double_dabble.vhd
set_global_assignment -name VHDL_FILE ../../src/generic_memory.vhd
set_global_assignment -name VHDL_FILE ../../src/package_lib/generic_adder_arch/generic_adder_arch.vhd
set_global_assignment -name VHDL_FILE ../../src/package_lib/generic_adder_arch/full_adder_single_bit_arch.vhd
set_global_assignment -name VHDL_FILE ../../src/package_lib/synchronizer.vhd
set_global_assignment -name VHDL_FILE ../../src/package_lib/cpet_343_components.vhd
set_global_assignment -name VHDL_FILE ../../src/state_machine_four_states.vhd
set_global_assignment -name VHDL_FILE ../../src/alu.vhd
set_global_assignment -name VHDL_FILE ../../src/calculator_dut.vhd
set_global_assignment -name VHDL_FILE ../../src/simple_processor.vhd

set_location_assignment PIN_AF14 -to clk
set_location_assignment PIN_AA14 -to reset
set_location_assignment PIN_Y16  -to exe_i

set_location_assignment PIN_V16  -to led_o[0]
set_location_assignment PIN_W16  -to led_o[1]
set_location_assignment PIN_V17  -to led_o[2]
set_location_assignment PIN_V18  -to led_o[3]
set_location_assignment PIN_W17  -to led_o[3]

set_location_assignment PIN_AE26 -to bcd_one_o[0]
set_location_assignment PIN_AE27 -to bcd_one_o[1]
set_location_assignment PIN_AE28 -to bcd_one_o[2]
set_location_assignment PIN_AG27 -to bcd_one_o[3]
set_location_assignment PIN_AF28 -to bcd_one_o[4]
set_location_assignment PIN_AG28 -to bcd_one_o[5]
set_location_assignment PIN_AH28 -to bcd_one_o[6]

set_location_assignment PIN_AJ29 -to bcd_ten_o[0]
set_location_assignment PIN_AH29 -to bcd_ten_o[1]
set_location_assignment PIN_AH30 -to bcd_ten_o[2]
set_location_assignment PIN_AG30 -to bcd_ten_o[3]
set_location_assignment PIN_AF29 -to bcd_ten_o[4]
set_location_assignment PIN_AF30 -to bcd_ten_o[5]
set_location_assignment PIN_AD27 -to bcd_ten_o[6]

set_location_assignment PIN_AB23 -to bcd_hun_o[0]
set_location_assignment PIN_AE29 -to bcd_hun_o[1]
set_location_assignment PIN_AD29 -to bcd_hun_o[2]
set_location_assignment PIN_AC28 -to bcd_hun_o[3]
set_location_assignment PIN_AD30 -to bcd_hun_o[4]
set_location_assignment PIN_AC29 -to bcd_hun_o[5]
set_location_assignment PIN_AC30 -to bcd_hun_o[6]

execute_flow -compile
project_close