/* Author:      Anthony Cabrera
*  File:        template_tb.v 
*  Date:        7/22/18 
*  Description: This is a template for testbenches 
*/

// `timescale takes arguments unit / precision
// It has no effect on synthesis.
// Delays will be of size "unit"
// Times in between unit (e.g. 1.22 or 2.78) will get rounded to the nearest
// "precision", e.g. (1 or 3)
`timescale 1ns/1ns

// Include all of the files that your testbench and its modules are dependent
// on. e.g.
`include "../hdl/acc_top.v"

// By convention, I usually just name the module as the module under test and
// append "_tb" to indicate that it's a testbench. e.g.
module mult_tb();

  // all of the input/output signals of the MUT (module under test) will be
  // defined as internal signals
  reg clk, reset_n, a_sig;
  reg [7:0] a;
  wire v, c;
  wire [7:0] a_reg;
  wire [6:0] a0, a1, s0, s1;

  // instantiate MUT
  mult_tb top (.SW({a_sig, a}), .KEY({1'b0, reset_n}), .LEDR({v, c, a_reg}), .HEX0(a0),
    .HEX1(a1), .HEX2(s0), .HEX3(s1), .CLOCK_50(clk));

  // This is the logic that simulates a clock signal
  always begin
    clk = 1; #10; clk = 0; #10;
  end

  // In this particular code, the testing of the module is implmented here.
  initial begin

    // name for the .vcd file to be fed to waveform viewer Scansion
    $dumpfile("acc_top.vcd");
    // signals of a given module that are wanted for view in Scansion
    $dumpvars(0, mult_tb);

    a = 8'b0; reset_n = 1'b0; a_sig = 1'b0;
    #3;
    reset_n = 1'b1;
    #2;
    for (a=8'b1; a < 2**10; a=8'hFF)
    begin
      #15; //$display("a=%d", a);
    end
  end

  // After some amount of time, just treat the simulation as finished
  initial begin
    #4000 $finish;
  end

  initial begin
    #1920 a_sig = 1'b1;
  end

endmodule
