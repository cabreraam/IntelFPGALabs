//`include "../../Part3/hdl/full_add_1_bit.v"
//is the above necessary? maybe not

module full_add_n_bit #(parameter N = 4) 
	(a, b, c_in, sum, c_out);

	input c_in;
	input [N-1:0] a, b;
	output c_out;
	output [N-1:0] sum;  	

	assign {c_out, sum} = c_in + a + b;

endmodule
