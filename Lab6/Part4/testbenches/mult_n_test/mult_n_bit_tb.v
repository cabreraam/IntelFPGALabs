//THIS NEEDS TO BE UPDATED, THIS DOESN'T WORK

`timescale 1ns/1ns
`include "../../hdl/mult_n.v"

module mult_n_bit_tb();

  parameter n = 8;
  //parameter n = 4;

  //reg [n-1:0] a
  reg [n-1:0] a, b;
  wire [(n+n-1):0] p;

  mult_n #(.N(n)) dut (
	.a(a),
    .b(b),
    .p(p)
  );

  initial begin

    $dumpfile("mult_n.vcd");
    $dumpvars(0, mult_n_bit_tb);

    //a = 8'b01111111; b = 8'b10000000; 
    a = 8'b0; b = 8'b00001010; 
    #10; // 2ns
    //for (a=8'b01111111; a<2**n; a=a+1'b1)
    for (a=8'b0; a<8'b00001111; a=a+1'b1)
      #10 $display("done testing case A=%d", a);
  end

  initial begin
    #1000 $finish;
  end

  initial begin
    #50 b = 8'b01000000;
  end

endmodule
