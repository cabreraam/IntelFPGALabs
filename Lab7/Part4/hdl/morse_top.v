module morse_top(
	input CLOCK_50,
	input [1:0] KEY,
	input [2:0] SW,
	output [1:0] LEDR
);

	//parameter COUNT_VAL = 25'd9; //for simulation
	parameter COUNT_VAL = 25'd24999999; // for actual hardware

	wire [2:0] ltr_len_from_sel_logic; //attach to letter sel logic	
	wire [2:0] ltr_len_from_counter; //attach to letter sel logic	
	wire [3:0] input_to_shift_reg;
	wire [4:0] curr_state;
	wire char_from_shift_reg; //where char is a dot(0) or dash(1)
	wire morse_en;
	wire morse_ld;
	wire slow_clk_en;

	wire key1_n;

	morse_fsm #(.COUNT_VAL(COUNT_VAL)) 
	fsm(
		.in_ltr(SW[2:0]),
		.ltr_len_cnt(ltr_len_from_counter),
		.ld_ltr(key1_n),//probably need to negate this
		.in_shift_reg(char_from_shift_reg),
		.reset_n(KEY[0]),
		.clk(CLOCK_50),
		.curr_state(curr_state),
		.morse_en(morse_en),
		.morse_ld(morse_ld),
		.slow_clk_enable(slow_clk_en),
		.light_on(LEDR[0]),
		.slow_clk_out(LEDR[1])
	); 

	letter_sel_logic 
	ltr_sel_logic(
		.input_state(curr_state),
		.size(ltr_len_from_sel_logic),
		.letter_out(input_to_shift_reg)
	);
	
	morse_shift 
	morse_shift_reg(
		.in_chars(input_to_shift_reg),
		.shift_en(morse_en),
		.load_en(morse_ld),
		.clk(CLOCK_50),
		.reset_n(KEY[0]),
		.char_bit(char_from_shift_reg)
	);

	morse_len_counter
	morse_len_count(
		.in_length(ltr_len_from_sel_logic),
		.down_en(morse_en),
		.load_en(morse_ld),
		.reset_n(KEY[0]),
		.clk(CLOCK_50),
		.out_length(ltr_len_from_counter)
	);


	assign key1_n = ~KEY[1];
endmodule
