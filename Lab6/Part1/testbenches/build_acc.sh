#!/bin/bash
iverilog -o acc.vvp accumulator_tb.v
vvp acc.vvp
open -a Scansion acc.vcd
