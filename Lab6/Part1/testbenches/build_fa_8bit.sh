#!/bin/bash
iverilog -o full_add_8_bit_tb.vvp full_add_8_bit_tb.v
vvp full_add_8_bit_tb.vvp
gtkwave anthony.vcd
