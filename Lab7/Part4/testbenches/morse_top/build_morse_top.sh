#!/bin/bash
iverilog -o morse_top_tb.vvp morse_top_tb.v -I../../hdl/
vvp morse_top_tb.vvp
gtkwave morse_top.vcd waveform_sm.gtkw
