/* Note: my dev board's buttons don't really work as the clock. Therefore, I use 
 * a synthetic, slow clock to act as my actual clock instead of using the
 * buttons. It's just a counter. When we're simulating, remove all of the stuff
 * that has to deal with the fake clock
 */


module sm_top (	input 	[1:0]	KEY,
								input 	[1:0]	SW,
								input		 			CLOCK_50,
								output	[9:0] LEDR);

	reg [25:0] count;
	reg slow_clk;
	wire slow_clk_out;
	

	//state_machine sm(	.clk(KEY[0]),
	state_machine sm(	.clk(slow_clk_out),
										.reset_n(KEY[1]),
										.w(SW[1]),
										.z(LEDR[9]),
										.state_output(LEDR[3:0])	);
										
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


	
endmodule //sm_top
