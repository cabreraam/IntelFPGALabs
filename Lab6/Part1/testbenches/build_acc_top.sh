#!/bin/bash
iverilog -o acc_top.vvp acc_top_tb.v
vvp acc_top.vvp
open -a Scansion acc_top.vcd
