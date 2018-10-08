#!/bin/bash
iverilog -o mult_n_bit_tb.vvp mult_n_bit_tb.v -I../../hdl/
vvp mult_n_bit_tb.vvp
gtkwave mult_n.vcd waveform.gtkw
