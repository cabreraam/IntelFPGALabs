#!/bin/bash
iverilog -o full_add_n_bit_tb.vvp full_add_n_bit_tb.v
vvp full_add_n_bit_tb.vvp
gtkwave full_add_n_bit.vcd
