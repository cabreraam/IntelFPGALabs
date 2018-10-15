//`include "mult_n.v"

/*
  N is the bit-width of input
*/
module reg_mult_n #(parameter N = 8)
	(clk,reset_n,ea,eb,a,ra_out,b,rb_out,p);	

	input [N-1:0] a, b;
	input clk, ea, eb, reset_n;

	output reg [N+N-1:0] p;
	output [N-1:0] ra_out, rb_out;

	/* internal signals */
	reg [N-1:0] reg_a, reg_b;
	wire [N+N-1:0] mult_out;
	
	mult_tree_8 #(.N(N)) multiplier
	(
		.a(reg_a),
		.b(reg_b),
		.p(mult_out)
	);


	
	always @ (posedge clk)
	begin
		if (~reset_n)
		begin
			reg_a <= {N{1'b0}};
			reg_b <= {N{1'b0}};
			p <= {N*2{1'b0}};
		end
		else
		begin
			if (ea == 1'b1)		
				reg_a <= a;
			if (eb == 1'b1)		
				reg_b <= b;
			p <= mult_out;
		end
	end

	assign ra_out = reg_a;
	assign rb_out = reg_b;

endmodule
