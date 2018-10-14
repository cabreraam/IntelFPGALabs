//`include "full_add_n_bit.v"

module mult_n #(parameter N = 4)
	(a, b, p);

	input [N-1:0] a, b;
	output [(N+N-1):0] p;

	/* internal signals */
	// N output wires for 1 adder *(N-1 adders) = # of output wires for adders
	wire [N*(N-1)-1:0] sums;
	wire [N-1:0] a_and_b0, a_and_b1, rep_b0;
	wire [N-2:0] c_out_vec;

	// instantiate first adder, then generate the rest below
	full_add_n_bit #(.N(N)) first_adder(
		.a( {1'b0, a_and_b0[N-1:1]} ),
		.b(a_and_b1),
		.c_in(1'b0),
		.sum(sums[N-1:0]),
		.c_out(c_out_vec[0])	
	); 

	genvar i;
	generate
	for (i = 0; i < N-2; i = i+1)
	begin : generated_adder 
		wire [N-1:0] a_and_b;
		full_add_n_bit #(.N(N))	
			device (
				.a( { c_out_vec[i], sums[ (((i+1)*N)-1) : (i*N)+1] } ), 
				.b(a_and_b), 
				.c_in(1'b0), 
				.sum( sums[ (((i+2)*N)-1) : ((i+1)*N) ] ),
				.c_out(c_out_vec[i+1])
			);

		assign a_and_b = a & {N{b[i+2]}};

		/* output */
		assign p[i+2] = sums[ ((i+1)*N) ];
	end	
	endgenerate

	assign a_and_b0 = a & {N{b[0]}};
	assign a_and_b1 = a & {N{b[1]}};

	/* output */
	assign p[0] = a_and_b0[0];
	assign p[1] = sums[0];
	// (N+N-2)th bit is the next-to-last sums bit
	assign p[ (N+N-2):(N-1) ] = sums[ (N*(N-1)-1):(N*(N-2)) ];
	// (N-2)th bit is the next-to-last c_out_vec bit
	assign p[ N+N-1 ] = c_out_vec[N-2];
	

endmodule
