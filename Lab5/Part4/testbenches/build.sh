#!/bin/bash
iverilog -o morse.vvp morse_tb.v
vvp morse.vvp
open -a Scansion anthony.vcd
