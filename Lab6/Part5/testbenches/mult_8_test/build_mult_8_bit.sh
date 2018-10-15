#!/bin/bash
iverilog -o mult_tree_8_bit_tb.vvp mult_tree_8_bit_tb.v -I../../hdl/ 
vvp mult_tree_8_bit_tb.vvp
gtkwave mult_tree_8_bit.vcd waveform_8bit.gtkw
