`timescale 1ns/1ns
`include "../../hdl/ram32x4.v"
`include "../../hdl/top_ram.v"

module top_ram_tb();

	// DUT inputs
	reg [4:0] addr;
	reg [3:0] data;
	reg clk, wr_en;
	// DUT outputs
	wire [3:0] q;

	top_ram dut (
		.addr(addr), //input
		.clk(clk), //input
		.data(data), //input
		.wr_en(wr_en), //input
		.q(q) //output
	);

	// clock
	always begin
		clk = 1; #10; clk = 0; #10; // 50MHz Clock	
	end

	initial begin

		$dumpfile("top_ram.vcd");
		$dumpvars(0, top_ram_tb);

		/*reset_n = 1'b0; 
		#15; 
		reset_n = 1'b1; slow_clk = 1'b0; 
		#10;

		#40
		in_ltr[2:0] = 3'b000;
		#40;
		ld_ltr = 1'b1; //simulate button press for loading letter
		#20;*/

		// Initial condition
		addr[4:0] = 5'b0;
		data[3:0] = 4'b0;
		wr_en = 1'b0;
		#15;

		data[3:0] = 4'b1010;
		wr_en = 1'b1;
		#20;

		data[3:0] = 4'b0000;
		wr_en = 1'b0;
		#20;

		addr[4:0] = 5'h1F;
		data[3:0] = 4'b0101;
		wr_en = 1'b1;
		#20;

		addr[4:0] = 5'b0;
		wr_en = 1'b0;
		#20;

		addr[4:0] = 5'h1F;
		#20;

		addr[4:0] = 5'b0;
		#20;
		
	end

initial begin
  #100000 $finish;
end

endmodule
