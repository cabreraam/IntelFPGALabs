/*
 * Set output z high if we encounter NUM_COUNT consecutive 0's or 1's 
 */

module countN_pattern(
	input wire clk,
	input reset_n,
	input w,
	output z,
	output [3:0] shift_reg_state
);
	parameter NUM_COUNT = 4;

	reg [NUM_COUNT-1:0]	zeros_reg, ones_reg;

	/* sequential logic */
	always @ (posedge clk or negedge reset_n)
	begin: count4_pattern_seq
		if (!reset_n)
		begin
			zeros_reg[NUM_COUNT-1:0] <= 4'hF;
			ones_reg[NUM_COUNT-1:0] <= 4'h0;
		end	
		else
		begin
			zeros_reg <= {w, zeros_reg[NUM_COUNT-1:1]};
			ones_reg <= {w, ones_reg[NUM_COUNT-1:1]};
		end
	end //count4_pattern_seq

	/* continous assignments */
	assign z = (zeros_reg[NUM_COUNT-1:0] == 4'h0) || 
							(ones_reg[NUM_COUNT-1:0] == 4'hF);
	assign shift_reg_state = zeros_reg;

endmodule
