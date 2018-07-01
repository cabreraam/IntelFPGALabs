module morse_a_h_top(KEY, CLOCK_50, SW, LEDR);

	input CLOCK_50;
	input [1:0] KEY;
	input [2:0] SW;
	output [9:0]LEDR;

	// internal signals
	wire [3:0] letter;
	wire ld_reg_from_disp;
	wire [2:0] size;
	wire [2:0] size_from_reg;
	wire sr_q, en_reg_from_disp, en_count_from_disp, reset_from_disp;
	wire key0_AND_reset_from_disp;

	//for display_logic_new
	wire [1:0] count2_in;

	//debug
	//wire debug_all_syms_procd; LEDR[8]

	//reg dummy;

	/*always @ (posedge CLOCK_50)
	begin
		if (half_sec_sig)
			dummy <= ~dummy;
	end*/

	letter_sel_logic letter_logic (.letter_in(SW), .size(size), .letter_out(letter));

	letter_size_reg size_reg (.d(size), .clk(CLOCK_50), .reset_n(KEY[0]),
		.ld(ld_reg_from_disp), .q(size_from_reg));
	letter_sym_sr shift_reg (.d(letter), .clk(CLOCK_50), .reset_n(KEY[0]),
		.en(en_reg_from_disp), .ld(ld_reg_from_disp), .q(sr_q));

	display_logic_new disp (.clk(CLOCK_50), .count2_in(count2_in),
		.size_in(size_from_reg), .sym_in(sr_q), .reset_n(KEY[0]), .disp_n(KEY[1]),
		.ld_out(ld_reg_from_disp), .en_reg_out(en_reg_from_disp),
		.en_count_out(en_count_from_disp), .reset_count_out(reset_from_disp),
		.led_out(LEDR[0]), //); start debug
		.debug_all_syms_procd(),//LEDR[9]),
		.debug_size_in(LEDR[9:7]),
		.debug_size_count(LEDR[6:4]),//3]),
		.debug_count2_in(LEDR[3:2]),
		.debug_sym_in(LEDR[1]));

	modulo_counter half_sec (.clk(CLOCK_50 && en_count_from_disp), .reset_n(key0_AND_reset_from_disp), .q(),
  	.rollover(half_sec_sig));
    defparam half_sec.n = 25;
	  //defparam half_sec.k = 25'b1011111010111100001000000;
		defparam half_sec.k = 25'b10000;

	modulo_counter count_1or3 (.clk(half_sec_sig && en_count_from_disp), .reset_n(key0_AND_reset_from_disp),
		.q(count2_in), .rollover());
	  defparam count_1or3.n = 2;
	  defparam count_1or3.k = 4; //TODO: change back to 3? Yup, I needed to. It was never getting to 3, and this's
																// the thing that will satisfy count2_in == array_1or3

	assign key0_AND_reset_from_disp = KEY[0] & reset_from_disp;
	//debug
	//assign LEDR[1] = dummy;

	endmodule
