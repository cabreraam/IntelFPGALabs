#!/bin/bash
iverilog -o state_machine_tb.vvp state_machine_tb.v -I../../hdl/
vvp state_machine_tb.vvp
gtkwave state_machine.vcd waveform_sm.gtkw
