//`include "reg_mult_n.v"

module reg_mult_n_top //#(parameter N = 8)
	(SW, LEDR, KEY, HEX0, HEX1, HEX2, HEX3);
	
	parameter N = 8;
	parameter N_HALF = N/2;
	input [9:0] SW;
	input [1:0] KEY;
	output [7:0] LEDR;
	output [6:0] HEX0, HEX1, HEX2, HEX3;

	/* internal signals */
	wire [N+N-1:0] mult_out;
	wire [N-1:0] ra_out,rb_out;
	wire [6:0] d0_wire, d1_wire, d2_wire, d3_wire;

	reg_mult_n #(.N(N)) multiplier(
		.clk(KEY[1]),
		.reset_n(KEY[0]),
		.ea(SW[9]),
		.eb(SW[8]),
		.a(SW[7:0]),
		.ra_out(ra_out),
		.b(SW[7:0]),
		.rb_out(rb_out),
		.p(mult_out)
	);

	char_7seg_hex d0 (.C( mult_out[1*N_HALF-1:0*N_HALF]), .Display(d0_wire));
	char_7seg_hex d1 (.C( mult_out[2*N_HALF-1:1*N_HALF]), .Display(d1_wire));
	char_7seg_hex d2 (.C( mult_out[3*N_HALF-1:2*N_HALF]), .Display(d2_wire));
	char_7seg_hex d3 (.C( mult_out[4*N_HALF-1:3*N_HALF]), .Display(d3_wire));
	
	assign LEDR[7:0] = (SW[9]) ? ra_out : rb_out;
	
	assign HEX0[6:0] = d0_wire;
	assign HEX1[6:0] = d1_wire;
	assign HEX2[6:0] = d2_wire;
	assign HEX3[6:0] = d3_wire;


endmodule
