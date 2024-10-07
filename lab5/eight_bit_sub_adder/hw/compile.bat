quartus_sh -t compile.tcl
pause
quartus_pgm --mode=JTAG -o P;output_files\eight_bit_sub_adder.sof@2
pause