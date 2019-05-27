module top_ram(
	input [4:0] addr,
	input clk,
	input [3:0] data,
	input wr_en,
	output [3:0] q	
);

	ram32x4 my_ram(
		.address(addr), //input
		.clock(clk), //input
		.data(data), //input
		.wren(wr_en), //input
		.q(q) //output
	);

endmodule 
