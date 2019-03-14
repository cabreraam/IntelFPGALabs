module morse_fsm(
	input [2:0] in_ltr, // async; input letter from switches
	input [2:0] ltr_len_cnt, // sync; size of letter from ltr sel. logic (size = [1,4])
	input ld_ltr, //async; external button press to load in_ltr
	input in_shift_reg, // sync; dot or dash for curr ltr 
	input reset_n, // async
	input clk, // sync
	//TODO: remove slow_clk if counter exists within this module, otherwise 
	//			modify slow clk to be [24:0]
	//input slow_clk, // sync; made from half second counter
	output reg [4:0] curr_state, // sync; tell letter sel. logic what letter we're on
	output reg morse_en, // enable signal for length downcounter/shift reg shift
	output reg morse_ld, // load data signal for length counter/shift reg
	output reg slow_clk_enable, // sync; turn the half second counter on/off
	output reg light_on,		
	output slow_clk_out
);

	// state variables
	reg [4:0] state, next_state;
	wire [24:0] slow_clk_wire;

	parameter START = 5'h0, 
						A_ST = 5'h1, // *_STATE will feed letter selection logic
						B_ST = 5'h2, 
						C_ST = 5'h3,
						D_ST = 5'h4, 
						E_ST = 5'h5, 
						F_ST = 5'h6, 
						G_ST = 5'h7, 
						H_ST = 5'h8,  
						CNT_3 = 5'h9,
						CNT_3_EX = 5'hA,
						CNT_2 = 5'hB,
						CNT_2_EX = 5'hC,
						CNT_1 = 5'hD,
						CNT_1_EX = 5'hE,
						CNT_0 = 5'hF,
						CNT_0_EX = 5'h10;

	parameter A_IN = 3'b000,
						B_IN = 3'b001,
						C_IN = 4'b010,
						D_IN = 3'b011,
						E_IN = 3'b100,
						F_IN = 3'b101,
						G_IN = 3'b110,
						H_IN = 3'b111;

	parameter COUNT_VAL = 9;

	half_sec_counter #(.COUNT_VAL(COUNT_VAL)) pulse_count(
		.clk(clk),
		.reset_n(reset_n),
		.clk_en(slow_clk_enable),
		.count_val(slow_clk_wire)
	);

	/* next state combo logic */
	always @ (state, ld_ltr, in_ltr, ltr_len_cnt, in_shift_reg, slow_clk_wire)//,slow_clk)
	begin
		case (state)
			START:
			begin
				if (ld_ltr)
				begin
					case(in_ltr)
						A_IN: next_state <= A_ST;
						B_IN: next_state <= B_ST;
						C_IN: next_state <= C_ST;
						D_IN: next_state <= D_ST;
						E_IN: next_state <= E_ST;
						F_IN: next_state <= F_ST;
						G_IN: next_state <= G_ST;
						H_IN: next_state <= H_ST;
					endcase
				end
				else
					next_state <= START;
			end

			A_ST, B_ST, C_ST, D_ST, E_ST, F_ST, G_ST, H_ST:
			begin
				if (ltr_len_cnt == 3'b0)
					next_state <= state;
				else
				begin
					case (in_shift_reg)
						1'b1: next_state <= CNT_3;
						1'b0: next_state <= CNT_1;
					endcase
				end
			end

			CNT_3: next_state <= CNT_3_EX;

			CNT_3_EX: 
			begin
				case (slow_clk_wire)
					25'b0: next_state <= CNT_2;
					default: next_state <= CNT_3_EX;
				endcase
			end

			CNT_2: next_state <= CNT_2_EX;

			CNT_2_EX: 
			begin 
				case (slow_clk_wire)
					25'b0: next_state <= CNT_1;
					default: next_state <= CNT_2_EX;
				endcase
			end

			CNT_1: next_state <= CNT_1_EX;

			CNT_1_EX: 
			//TODO: enable morse_en for cntr/shift reg
			begin 
				case (slow_clk_wire)
					25'd0: next_state <= CNT_0;
					default: next_state <= CNT_1_EX;
				endcase
			end

			CNT_0: next_state <= CNT_0_EX;

			CNT_0_EX:
			begin
				case (slow_clk_wire)
					25'b0: 
					begin
						if (ltr_len_cnt != 3'b0)
						begin
							case(in_shift_reg)	
								1'b1: next_state <= CNT_3;
								1'b0: next_state <= CNT_1;
							endcase
						end
						else
							next_state <= START;
					end
					default: next_state <= CNT_0_EX;
				endcase
			end

		endcase //state
	end

	/* output combo logic */
	always @ (state, slow_clk_wire, ltr_len_cnt)
	begin: morse_output 
		case (state)
			START:
			begin
				morse_en <= 1'b0;
				morse_ld <= 1'b0;
				slow_clk_enable <= 1'b0;
				light_on <= 1'b0;
				//curr_state <= 5'h0;
			end
				
			//if it's any of the *_STATEs, set morse_ld high 
			A_ST, B_ST, C_ST, D_ST, E_ST, F_ST, G_ST, H_ST:
			begin
				morse_ld <= 1'b1;				
				morse_en <= 1'b0;
				slow_clk_enable <= 1'b0;
				light_on <= 1'b0;
			end

			CNT_3, CNT_3_EX, CNT_2, CNT_2_EX:
			begin
				morse_ld <= 1'b0;
				morse_en <= 1'b0;
				slow_clk_enable <= 1'b1;
				light_on <= 1'b1;
			end
			
			CNT_1:
			begin
				morse_ld <= 1'b0;
				morse_en <= 1'b0;
				slow_clk_enable <= 1'b1;
				light_on <= 1'b1;	
			end
			
			CNT_1_EX: 
			begin 
				case (slow_clk_wire)
					25'd0: 
					begin
						morse_ld <= 1'b0;
						morse_en <= 1'b0;
						slow_clk_enable <= 1'b1;
						light_on <= 1'b0;//important
					end
					default: 
					begin
						morse_ld <= 1'b0;
						morse_en <= 1'b0;
						slow_clk_enable <= 1'b1;
						light_on <= 1'b1;
					end
				endcase
			end

			CNT_0:
			begin
				light_on <= 1'b0; 
				morse_ld <= 1'b0;
				morse_en <= 1'b1;
				//if (ltr_len_cnt == 3'b0)
				//	slow_clk_enable <= 1'b0;
				//else
					slow_clk_enable <= 1'b1;
			end 

			CNT_0_EX:
			begin
				morse_ld <= 1'b0;
				morse_en <= 1'b0;
				light_on <= 1'b0;
				if (slow_clk_wire == 25'd0)
				begin
					if (ltr_len_cnt == 3'b0) // just copied and pasted from CNT_0
						slow_clk_enable <= 1'b0;
					else
						slow_clk_enable <= 1'b1;
				end
				else
					slow_clk_enable <= 1'b1;
			end

			default: 
			begin
				morse_en <= 1'b0;
				morse_ld <= 1'b0;
				slow_clk_enable <= 1'b0;
				light_on <= 1'b0;
			end
		endcase
	end // morse_output


	/* state seq logic */
	always @ (posedge clk or negedge reset_n)
	begin: state_FFs 
		if (!reset_n)
		begin
			state <= START;
		end
		else
			state <= next_state;
	end // state_FFs
			
	/* other seq logic */
	always @ (posedge clk or negedge reset_n)
	begin: output_seq 
		if (!reset_n)
		begin
			/*morse_en <= 1'b0;
			morse_ld <= 1'b0;
			slow_clk_enable <= 1'b0;
			light_on <= 1'b0;*/
			curr_state <= 5'h0;
		end
		else
			curr_state <= next_state;
	end // output_seq 
			
	//assign slow_clk_out = (slow_clk_wire == 25'd0);
	assign slow_clk_out = slow_clk_wire[23];
		

endmodule	
