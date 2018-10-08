//THIS NEEDS TO BE UPDATED, THIS DOESN'T WORK

`timescale 1ns/1ns
//`include "../hdl/full_add_8_bit.v"
`include "../hdl/full_add_n_bit.v"

module full_add_n_bit_tb();

  parameter n = 8;

  //reg [n-1:0] a
  reg [n-1:0] a, b;
  reg carry_in;
  wire [n-1:0] sum;
  wire carry_out;

  full_add_n_bit #(.N(8)) dut (
	.a(a),
    .b(b),
    .c_in(carry_in),
    .sum(sum),
    .c_out(carry_out)
  );

  initial begin

    $dumpfile("full_add_n_bit.vcd");
    $dumpvars(2, full_add_8_bit_tb);

    a = 8'b01111111; b = 8'b10000000; carry_in = 1'b0;
    #10; // 2ns
    for (a=8'b01111111; a<2**n; a=a+1'b1)
      #10 $display("done testing case A=%d", a);
  end

  initial begin
    #1000 $finish;
  end

  initial begin
    #50 b = 8'b01000000;
  end

endmodule
