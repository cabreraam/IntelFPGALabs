#!/bin/bash
iverilog -o mult.vvp mult_tb.v
vvp mult.vvp
open -a Scansion mult.vcd
