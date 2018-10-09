`include "mult_n.v"

/*
  N is the bit-width of input
*/
module reg_mult_n #(parameter N = 4)
	(clk,reset_n,ea,eb,a,b,p);	

	input [N-1:0] a, b;
	input clk, ea, eb, reset_n;

	output reg [N+N-1:0] p;

	/* internal signals */
	reg [N-1:0] reg_a, reg_b;
	wire [N+N-1:0] mult_out;

	mult_n #(.N(N)) multiplier(
		.a(reg_a),
		.b(reg_b),
		.p(mult_out)
	);

	always @ (posedge clk)
	begin
		if (ea == 1'b1)		
			reg_a <= a;
		if (eb == 1'b1)		
			reg_b <= b;
		p <= mult_out;
		if (~reset_n)
		begin
			reg_a <= {N{1'b0}};
			reg_b <= {N{1'b0}};
			p <= {N{1'b0}};
		end
	end


endmodule
