module state_machine(clk, reset_n, w, z);

	input clk, reset_n, w;
	output z;

	parameter A=9'd1,
						B=9'd2,
						C=9'd4,
						D=9'd8,
						E=9'd16,
						F=9'd32,
						G=9'd64,
						H=9'd128,
						I=9'd256;

	/* internal signals */
	reg [8:0] state;
	wire [8:0] next_state;

	always @ (posedge clk)
	begin
		if (~reset_n)
			// state <= 9'd1; /* Question 2 */
			state <= 9'd0; /* Question 6 */
		else
			state <= next_state;			
	end

	assign z = ~( | state[7:5] | state[3:0] ) & (state[8] ^ state[4]);
	
	// State I
	assign next_state[8] = ~( | state[6:0]  ) & w & (state[8] ^ state[7]);

	// State H 
	assign next_state[7] = ~( | {state[8:7], state[5:0]} ) & w & state[6];

	// State G 
	assign next_state[6] = ~( | {state[8:6], state[4:0]} ) & w & state[5];

	// State F 
	assign next_state[5] = ~( | state[8:7] ) & w & state[0] +
												(~( | state[8:2] | state[0] ) & w & state[1]) +  //B->F 
												(~( | state[8:3] | state[1:0] ) & w & state[2]) +//C->F 
												(~( | state[8:4] | state[2:0] ) & w & state[3]) +//D->F 
												(~( | state[8:5] | state[3:0] ) & w & state[4]);  //E->F 
	// State E 
	assign next_state[4] = ~( | {state[8:5], state[2:0], w} ) & 
													(state[4] ^ state[3]);
	// State D 
	assign next_state[3] = ~( | {state[8:3], state[1:0], w} ) & state[2];

	// State C 
	assign next_state[2] = ~( | {state[8:2], state[0], w} ) & state[1];

	// State B 
	assign next_state[1] = ~( | {state[8:1], w} ) & state[0];//A->B 
												(~( | state[8:6] | state[4:0] | w ) & state[5]) +//F->B 
												(~( | state[8:7] | state[5:0] | w ) & state[6]) +//G->B 
												(~( | state[8] | state[6:0] | w ) & state[7]) + //H->B 
												(~( | state[7:0] | w ) & state[8]); //I->B
	//assign next_state[0] = 1'b1; /* Question 2 */
	assign next_state[0] = 1'b1; /* Question 6 */

endmodule
