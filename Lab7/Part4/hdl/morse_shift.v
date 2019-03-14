module morse_shift(
	input [3:0] in_chars, //either dots or dashes	
	input shift_en, //shift a bit out,
	input load_en,
	input clk,
	input reset_n,
	output char_bit
);

	reg [3:0] chars_reg;

	/* seq logic */
	always @ (posedge clk, negedge reset_n)
	begin
		if (!reset_n)
		begin
			chars_reg[3:0] <= 4'h0;
		end
		else if (load_en)	
		begin
			chars_reg <= in_chars;
		end
		else if (shift_en)
		begin
			chars_reg <= {chars_reg[2:0], 1'b0};
		end
	
	end

	assign char_bit = chars_reg[3];
	

endmodule
