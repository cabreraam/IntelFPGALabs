module state_machine(	input clk, 
											input reset_n, 
											input w, 
											output z,
											output [3:0] state_output);

	reg [3:0] state, next_state; 

	parameter A = 4'b0000,
						B = 4'b0001,
						C = 4'b0010,
						D = 4'b0011,
						E = 4'b0100,
						F = 4'b0101,
						G = 4'b0110,
						H = 4'b0111,
						I = 4'b1000;

	/* combo logic */
	always @ (w, state)
	begin: state_table
		case (state)
			A: 
				next_state = (!w) ? B : F;
			B:
				next_state = (!w) ? C : F;
			C:
				next_state = (!w) ? D : F;
			D:
				next_state = (!w) ? E : F;
			E:
				next_state = (!w) ? E : F;
			F:
				next_state = (!w) ? B : G;
			G:
				next_state = (!w) ? B : H;
			H:
				next_state = (!w) ? B : I;
			I:
				next_state = (!w) ? B : I;
			default:
				next_state = 4'bxxx;
		endcase
	end // state_FFS

	/* seq logic */
	always @ (posedge clk or negedge reset_n)
	begin: state_FFs
	if (!reset_n)
		state <= A;
	else
		state <= next_state;
	end // state_FFS

	// Output Combo assignments
	assign z = (state[3:0] == E) || (state[3:0] == I);
	assign state_output = state;	


endmodule



