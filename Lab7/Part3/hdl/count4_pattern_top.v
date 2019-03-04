module count4_pattern_top(
	input [1:0] KEY,
	input [1:0] SW,
	input CLOCK_50,	
	output [9:0] LEDR
);

	parameter N = 4;

	/* internal signals for unnecessary counter */
	reg [25:0] count;
	reg slow_clk;
	wire slow_clk_out;

	countN_pattern #(.NUM_COUNT(N)) count4(
		.clk(slow_clk_out),
		.reset_n(KEY[1]),
		.w(SW[1]),
		.z(LEDR[9]),
		.shift_reg_state(LEDR[N-1:0])
	);

	/* unnecessary counter */
  always @ (posedge CLOCK_50)
  begin

    if (!KEY[1])
    begin
      count <= 26'b0;
      slow_clk <= 1'b0;
    end 
    else if (count != 26'd25000000)
      count <= count + 1'b1;
    else if (count == 26'd25000000)
    begin
      count <= 26'b0;
      slow_clk <= ~slow_clk;
    end 
    
  end
  assign slow_clk_out = slow_clk;


endmodule
