#!/bin/bash
iverilog -o reg_mult_8_bit_tb.vvp reg_mult_8_bit_tb.v -I../../hdl/
vvp reg_mult_8_bit_tb.vvp
gtkwave reg_mult_8.vcd waveform_8bit.gtkw
