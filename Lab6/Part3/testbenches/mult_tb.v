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
`include "../hdl/full_add_1_bit.v"
`include "../hdl/mult.v"

// By convention, I usually just name the module as the module under test and
// append "_tb" to indicate that it's a testbench. e.g.
module mult_tb();

  // all of the input/output signals of the MUT (module under test) will be
  // defined as internal signals
  reg [3:0] a, b;
  wire [7:0] p;

  // instantiate MUT
  mult top (.a(a), .b(b), .p(p));

  // This is the logic that simulates a clock signal if module needs clock
  /*always begin
    clk = 1; #10; clk = 0; #10;
  end*/

  // In this particular code, the testing of the module is implmented here.
  initial begin

    // name for the .vcd file to be fed to waveform viewer Scansion
    $dumpfile("mult.vcd");
    // signals of a given module that are wanted for view in Scansion
    $dumpvars(0, mult_tb);

    a = 4'b0; b = 4'b1010;
    for (a=4'b0; a < 2**10; a=a + 1'b1)
    begin
      #40; //$display("a=%d", a);
    end
  end

  // After some amount of time, just treat the simulation as finished
  initial begin
    #4000 $finish;
  end


endmodule
