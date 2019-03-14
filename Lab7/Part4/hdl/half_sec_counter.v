module half_sec_counter(
	input clk,
	input reset_n,
	input clk_en,
	output reg [24:0] count_val
);

	//parameter COUNT_VAL = 25'd24999999;
	parameter COUNT_VAL = 25'd9;

	/* seq logic and async reset */
	always @ (posedge clk, negedge reset_n)
	begin
		if (!reset_n)
			count_val <= COUNT_VAL;	
		else if ( (count_val == 25'd0) && clk_en)
			count_val <= COUNT_VAL;	
		else if (clk_en)
			count_val <= count_val - 1'b1;
		//else do i need anything else?
	end


endmodule
