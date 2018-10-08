//THIS NEEDS TO BE UPDATED, THIS DOESN'T WORK

`timescale 1ns/1ns
`include "../../hdl/mult_n.v"

module mult_n_bit_tb();

  parameter n = 4;

  //reg [n-1:0] a
  reg [n+1:0] a_i, b_i;
  reg [n-1:0] a, b;
  wire [(n+n-1):0] p;

  mult_n #(.N(n)) dut (
	.a(a),
    .b(b),
    .p(p)
  );

  initial begin

    $dumpfile("mult_4.vcd");
    $dumpvars(0, mult_n_bit_tb);

    a_i = 6'b0; b_i = 6'b0; 
    a = 4'b0; b = 4'b0; 
    #10; // 2ns
    for (a_i=6'b0; a_i<6'b010000; a_i=a_i+1'b1)
	begin
    	for (b_i=6'b0; b_i<6'b010000; b_i=b_i+1'b1)
		begin
			b=b+1'b1;
			#10;
		end
		a=a+1'b1;
		b=4'b0;
		#10;
	end
  end

  initial begin
    #2760 $finish;
  end

  initial begin
    //#50 b = 4'b0100;
    //#50 b = 4'b0001;
  end

endmodule
