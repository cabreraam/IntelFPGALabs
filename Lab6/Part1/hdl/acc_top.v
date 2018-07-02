/*Connect input A to switches SW7−0, use KEY0 as an active-low asynchronous reset, and use KEY1 as a
manual clock input. The sum from the adder should be displayed on the red lights LEDR7−0, the registered
carry signal should be displayed on LEDR8, and the registered overflow signal should be displayed on
LEDR9. Show the registered values of A and S as hexadecimal numbers on the 7-segment displays HEX3−2
and HEX1 − 0*/

module acc_top(SW, KEY, LEDR, HEX0, HEX1, HEX2, HEX3, CLOCK_50);

	input [8:0] SW;
	input [1:0] KEY;
	input CLOCK_50;
	output [9:0] LEDR;
	output [6:0] HEX0, HEX1, HEX2, HEX3;

	// internal signals
	wire [7:0] a_in, a_reg_out, s; // input a and output s signals from accumulator
	wire v, c, reset_n;//, clk; // overflow, carry, reset, and clk signals from/to accumultor
	reg [25:0] clk_count;
	reg clk;


	char_7seg_hex A0 (.C(a_reg_out[3:0]), .Display(HEX0));
	char_7seg_hex A1 (.C(a_reg_out[7:4]), .Display(HEX1));
	char_7seg_hex S0 (.C(s[3:0]), .Display(HEX2));
	char_7seg_hex S1 (.C(s[7:4]), .Display(HEX3));

	accumulator acc (.clk(clk), .a(a_in), .a_reg(a_reg_out), .sum(s), .v(v), .c(c), .reset_n(reset_n));

	always @ (negedge reset_n or posedge CLOCK_50)
	begin

		if (!reset_n)
		begin
			clk <= 1'b0;
			clk_count <= 26'b0;
		end

		else
		begin
			if (clk_count == 26'b10111110101111000010000000)
			begin
				clk <= !clk;
				clk_count <= 26'b0;
			end
			else
			begin
				clk_count <= clk_count + 1'b1;
			end
		end

	end

	assign reset_n = KEY[0];
	//assign clk = !KEY[1];
	//assign clk = SW[8];
	assign a_in = SW[7:0];
	assign LEDR[7:0] = s;
	assign LEDR[8] = c;
	assign LEDR[9] = v;


endmodule
