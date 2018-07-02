`timescale 1ns/1ns
`include "../hdl/acc_top.v"
`include "../hdl/accumulator.v"
`include "../hdl/char_7seg_hex.v"
`include "../hdl/full_add_8_bit.v"
`include "../hdl/full_add_1_bit.v"

//NOTE: if simulating with iverilog, you'll need to change clk_count in acc_top.v
// to wait for something much smaller than 50 million ticks.

module acc_top_tb();

  reg clk, reset_n;
  reg [7:0] a;
  wire v, c;
  wire [7:0] sum, a_reg;
  wire [6:0] a0, a1, s0, s1;

  acc_top top (.SW(a), .KEY({1'b0, reset_n}), .LEDR({v, c, a_reg}), .HEX0(a0),
    .HEX1(a1), .HEX2(s0), .HEX3(s1), .CLOCK_50(clk));

  always begin
    clk = 1; #10; clk = 0; #10;
  end

  initial begin

    $dumpfile("acc_top.vcd");
    $dumpvars(0, acc_top_tb);

    a = 8'b0; reset_n = 1'b0;
    #3;
    reset_n = 1'b1;
    #2;
    for (a=8'b1; a < 2**10; a=8'b1)
      #15; //$display("a=%d", a);

  end

  initial begin
    #1000 $finish;
  end

endmodule
