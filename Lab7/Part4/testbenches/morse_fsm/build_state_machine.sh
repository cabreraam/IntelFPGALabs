#!/bin/bash
iverilog -o morse_fsm_tb.vvp morse_fsm_tb.v -I../../hdl/
vvp morse_fsm_tb.vvp
gtkwave morse_fsm.vcd waveform_sm.gtkw
