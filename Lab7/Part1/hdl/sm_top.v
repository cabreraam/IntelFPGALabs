
module sm_top (
	input [1:0] KEY,
	input [1:0] SW,
	output [9:0] LEDR,
	input CLOCK_50
	);

	reg [25:0] count;
	reg slow_clk;

	wire slow_clk_out;
	
	state_machine_with_output_state sm (
	//state_machine sm (
		//.clk(slow_clk_out),
		.clk(CLOCK_50),
		.reset_n(SW[0]),
		.w(SW[1]),
		.z(LEDR[9]),
		.state_out(LEDR[8:0])
	);	

	/* unnecessary counter */
	always @ (posedge CLOCK_50)
	begin

		if (~SW[0])
		begin
			count <= 26'b0;
			slow_clk <= 1'b0;
		end
		else if (count != 4) //
		//else if (count != 26'd25000000)
			count <= count + 1'b1;
		else if (count == 4) 
		//else if (count == 26'd25000000)
		begin
			count <= 26'b0;
			slow_clk <= ~slow_clk;
		end
			
	end
	
	//assign LEDR[8] = slow_clk;
	assign slow_clk_out = slow_clk;
	
endmodule



