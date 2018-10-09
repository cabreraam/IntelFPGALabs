#!/bin/bash
iverilog -o mult_8_bit_tb.vvp mult_8_bit_tb.v -I../../hdl/
vvp mult_8_bit_tb.vvp
gtkwave mult_8.vcd waveform_8bit.gtkw
