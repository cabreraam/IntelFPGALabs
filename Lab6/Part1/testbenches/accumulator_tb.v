`timescale 1ns/1ns
`include "../hdl/accumulator.v"
`include "../hdl/full_add_8_bit.v"
`include "../hdl/full_add_1_bit.v"

module accumulator_tb();

  reg clk, reset_n;
  reg [7:0] a;
  wire v, c;
  wire [7:0] sum;

  accumulator acc (.clk(clk), .a(a), .sum(sum), .v(v), .c(c),
    .reset_n(reset_n));

  always begin
    clk = 1; #10; clk = 0; #10;
  end

  initial begin

    $dumpfile("acc.vcd");
    $dumpvars(0, accumulator_tb, acc);

    a = 8'b0; reset_n = 1'b0;
    #3;
    reset_n = 1'b1;
    #2;
    for (a=8'b0; a < 2**10; a=a+1'b1)
      #15 $display("a=%d", a);

  end

  initial begin
    #1000 $finish;
  end

endmodule
