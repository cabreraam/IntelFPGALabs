module morse_len_counter(
	input [2:0] in_length,
	input down_en, //enable down count
	input load_en, //enable load
	input reset_n,
	input clk,
	output reg [2:0] out_length // length remaining
);

	/* seq logic */
	always @ (posedge clk or negedge reset_n)
	begin
		if (!reset_n)
			out_length <= 3'b0;	
		else if (load_en)
			out_length <= in_length;
		else if ( down_en && (out_length != 3'b0) )
			out_length <= out_length - 1'b1;
	end


endmodule
