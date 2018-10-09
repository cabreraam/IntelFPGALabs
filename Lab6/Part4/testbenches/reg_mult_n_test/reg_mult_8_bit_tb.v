//random comment, remove me later
`timescale 1ns/1ns
`include "reg_mult_n.v"

module reg_mult_n_bit_tb();

	parameter n = 8;

	reg [n+1:0] a_i, b_i;
	reg [n-1:0] a, b;
	reg clk, reset_n, ea, eb;

	wire [(n+n-1):0] p;

	reg_mult_n #(.N(n)) dut (
		.clk(clk),
		.reset_n(reset_n),
		.ea(ea),
		.eb(eb),
		.a(a),
		.b(b),
		.p(p)
	);

  // This is the logic that simulates a clock signal if your module requires
  // clk signal
	always begin
		clk = 1; #10; clk = 0; #10;
	end

	initial begin

		$dumpfile("reg_mult_8.vcd");
		$dumpvars(0, reg_mult_n_bit_tb);

		a = {n{1'b0}}; b = {n{1'b0}}; 
		reset_n = 1'b0; ea = 1'b0; eb = 1'b0;
		#15;
		reset_n = 1'b1; ea = 1'b1; eb = 1'b1;


		#20; // 2ns
		for (a_i = {n+1{1'b0}}; a_i < {1'b1, {n{1'b0}}}; a_i=a_i+1'b1)
		begin
			for (b_i={n+1{1'b0}}; b_i < {1'b1, {n{1'b0}}}; b_i=b_i+1'b1)
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
  #100000 $finish;
end

initial begin
  //#50 b = 4'b0100;
  //#50 b = 4'b0001;
end

endmodule
