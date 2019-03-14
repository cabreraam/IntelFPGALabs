`timescale 1ns/1ns
`include "../../hdl/morse_fsm.v"
`include "../../hdl/half_sec_counter.v"
`include "../../hdl/letter_sel_logic.v"
`include "../../hdl/morse_len_counter.v"
`include "../../hdl/morse_shift.v"
`include "../../hdl/morse_top.v"


module morse_top_tb();

	// DUT inputs
	reg [2:0] switches;
	reg [1:0] buttons;
	reg clk, reset_n;
	// DUT outputs
	wire [1:0] ledr;

	morse_top dut (
		.CLOCK_50(clk),	
		.KEY(buttons),
		.SW(switches),
		.LEDR(ledr)
	);

	// clock
	always begin
		clk = 1; #10; clk = 0; #10; // 50MHz Clock	
	end

	initial begin

		$dumpfile("morse_top.vcd");
		$dumpvars(0, morse_top_tb);

		//reset_n = 1'b0; 
		buttons[0] = 1'b0;
		buttons[1] = 1'b1;
		#15; 
		//reset_n = 1'b1; 
		buttons[0] = 1'b1; //release button
		#10;
		buttons[1] = 1'b0; //press button
		#40
		/* shift 4 1's in, then 0 */
		/* A */
		switches[2:0] = 3'b000;
		
		/* B */
		//switches[2:0] = 3'b001;
		#20;
		buttons[1] = 1'b1; // release button

	end

initial begin
  #100000 $finish;
end

endmodule
