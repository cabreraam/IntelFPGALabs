`include "full_add_n_bit.v"
module mult_tree_8 (
	a, // multiplicand 
	b, // multiplier 
	p  // product
);

	input [7:0] a, b;
	output [15:0] p;

	/* internal signals */
	wire [15:0] ABCD, EFGH;

	/* level 0 adders */
	/*full_add_n_bit #(.N(16)) lvl0_add_AB (
		.a(input_sigs[7].add_input), 
		.b(input_sigs[6].add_input), 
		.c_in(1'b0), 
		.sum(AB), 
		.c_out()
	);	

	full_add_n_bit #(.N(16)) lvl0_add_CD (
		.a(input_sigs[5].add_input), 
		.b(input_sigs[4].add_input), 
		.c_in(1'b0), 
		.sum(AB), 
		.c_out()
	);	

	full_add_n_bit #(.N(16)) lvl0_add_EF (
		.a(input_sigs[3].add_input), 
		.b(input_sigs[2].add_input), 
		.c_in(1'b0), 
		.sum(AB), 
		.c_out()
	);	

	full_add_n_bit #(.N(16)) lvl0_add_GH (
		.a(input_sigs[1].add_input), 
		.b(input_sigs[0].add_input), 
		.c_in(1'b0), 
		.sum(AB), 
		.c_out()
	);*/	

	/* level 1 adders */
	full_add_n_bit #(.N(16)) lvl1_add_ABCD 
	(
		.a(lvl0_adds[3].sum), 
		.b(lvl0_adds[2].sum), 
		.c_in(1'b0), 
		.sum(ABCD), 
		.c_out()
	);	

	full_add_n_bit #(.N(16)) lvl1_add_EFGH 
	(
		.a(lvl0_adds[1].sum), 
		.b(lvl0_adds[0].sum), 
		.c_in(1'b0), 
		.sum(EFGH), 
		.c_out()
	);	

	/* level 2 adder */
	full_add_n_bit #(.N(16)) lvl2_add_ALL 
	(
		.a(ABCD), 
		.b(EFGH), 
		.c_in(1'b0), 
		.sum(p), 
		.c_out()
	);	

	
	/* level 0 adders */
	genvar i; // lower index is LSB
	generate
		for (i = 0; i < 8; i = i + 1)
		begin: input_sigs
			wire [15:0] add_input;
			assign add_input = (b[i]) ? 
				a << i : 16'b0;
		end
	endgenerate	

	generate
		for (i = 0; i < 4; i = i + 1)
		begin: lvl0_adds // level 0 adders

			wire [15:0] sum;			

			full_add_n_bit #(.N(16)) inst 
			(
				.a(input_sigs[i*2    ].add_input), 
				.b(input_sigs[i*2 + 1].add_input), 
				.c_in(1'b0), 
				.sum(sum), 
				.c_out()
			);	
		end
	endgenerate


endmodule
