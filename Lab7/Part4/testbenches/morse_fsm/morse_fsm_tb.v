`timescale 1ns/1ns
`include "../../hdl/morse_fsm.v"
`include "../../hdl/half_sec_counter.v"

module morse_fsm_tb();

	// DUT inputs
	reg [2:0] in_ltr;
	reg [1:0] ltr_len_cnt;
	reg clk, reset_n, ld_ltr, in_shift_reg, slow_clk;
	// DUT outputs
	wire [4:0] curr_state;
	wire morse_en, morse_ld, slow_clk_enable, light_on;

	morse_fsm dut (
		.in_ltr(in_ltr),
		.ltr_len_cnt(ltr_len_cnt),
		.ld_ltr(ld_ltr),
		.in_shift_reg,
		.reset_n(reset_n),
		.clk(clk),
		//.slow_clk(slow_clk),
		.curr_state(curr_state),
		.morse_en(morse_en),
		.morse_ld(morse_ld),
		.slow_clk_enable(slow_clk_enable),
		.light_on(light_on)
	);

	// clock
	always begin
		clk = 1; #10; clk = 0; #10; // 50MHz Clock	
	end

	initial begin

		$dumpfile("morse_fsm.vcd");
		$dumpvars(0, morse_fsm_tb);

		reset_n = 1'b0; 
		#15; 
		reset_n = 1'b1; slow_clk = 1'b0; 
		#10;

		#40
		/* shift 4 1's in, then 0 */
		/* A */
		in_ltr[2:0] = 3'b000;
		#40;
		ld_ltr = 1'b1; //simulate button press for loading letter
		#20;
		/* should be at count 1 */
		//TODO: Start here, the following two statements timing are off, and slow
		//clk too
		ltr_len_cnt[1:0] = 2'b10; // 1 dot, 1 dash
		in_shift_reg = 1'b0; // bit 1 is dash, bit 0 is dot
		#20;
		ld_ltr = 1'b0;
		#75
		//#80;
		slow_clk = 1'b1; /* should be at count 0 */
		#5
		#15
		slow_clk = 1'b0;
		#5
		ltr_len_cnt[1:0] = 2'b01; // 1 dot, 1 dash
		in_shift_reg = 1'b1; // bit 1 is dash, bit 0 is dot
		#5

		#80;
		slow_clk = 1'b1; /* should be at count 3 */
		#20
		slow_clk = 1'b0;
		
		#80;
		slow_clk = 1'b1; /* should be at count 2 */
		#20
		slow_clk = 1'b0;
		
		#80;
		slow_clk = 1'b1; /* should be at count 1 */
		#20
		slow_clk = 1'b0;
		
		#80;
		slow_clk = 1'b1; /* should be at count 0 */
		ltr_len_cnt[1:0] = 2'b00; // 1 dot, 1 dash
		in_shift_reg = 1'b0; // bit 1 is dash, bit 0 is dot
		#20
		slow_clk = 1'b0;
	end

initial begin
  #100000 $finish;
end

endmodule
