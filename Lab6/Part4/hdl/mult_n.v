module mult_n #(parameter N = 4)
	(a, b, p);

	input [N-1:0] a, b;
	output [(N+N-1):0] p;

	/* internal signals */
	// N output wires for 1 adder *(N-1 adders) = # of output wires for adders
	wire [N*(N-1)-1:0] sums;
	wire [N-1:0] a_and_b0, a_and_b1;
	wire [N-2:0] c_out_vec;
	// TODO: any other internal signals?

	// instantiate first adder, then generate the rest below
	full_add_n_bit #(.N(4)) first_adder(
		.a(a_and_b0),
		.b(a_and_b1),
		.c_in(1'b0),
		.sum(sums[3:0]),
		.c_out(c_out_vec[0])	
	); 

	genvar i;
	generate
	// TODO: take care of the 2nd adder, b3a3 input
	for (i = 0; i < N-2; i = i+1)
	begin : adder 
		wire [N-1:0] a_and_b;
		full_add_n_bit #(.N(4))	
			device (
				.a(sums[ (((i+1)*4)-1) : (i*4)] ), 
				.b(a_and_b), 
				.c_in(1'b0), 
				.sum( sums[ (((i+2)*4)-1) : ((i+1)*4) ] ),
				.c_out(c_out_vec[i+1])
			);

		assign a_and_b = a & {3{b[i+2]}};
	end	
	endgenerate

	assign a_and_b0 = a & {3{b[0]}};
	assign a_and_b1 = a & {3{b[1]}};
	

endmodule
