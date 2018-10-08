#!/bin/bash
iverilog -o mult_4_bit_tb.vvp mult_4_bit_tb.v -I../../hdl/
vvp mult_4_bit_tb.vvp
gtkwave mult_4.vcd waveform_4bit.gtkw
