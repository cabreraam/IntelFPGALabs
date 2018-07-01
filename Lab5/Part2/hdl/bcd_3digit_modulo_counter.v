// design goals:
// 1) 3 digit Display
// 2) connect all counters in your circuit to 50-MHz clock signal
// 3) make the BCD counter increment at one-seoncd intervals.
//      digit0 changes 50 Mcycles
// 4) push-button input for reset

module bcd_3digit_module_counter (reset_n, clk, count, rollover);

  parameter disp_bits = 4;

  input reset_n, clk;
  output [11:0] count;
  output [5:0] rollover; // don't think I need 6 bits of rollover


  /*
  * These modules count for ones-, tens-, and hundreds-place
  */
  modulo_counter digit0_val (.clk(clk), .reset_n(reset_n), .q(),
    .rollover(rollover[0]));
    defparam digit0_val.n = 26;
    //defparam digit0_val.n = 27;
    defparam digit0_val.k = 50000000;
  modulo_counter digit1_val (.clk(clk), .reset_n(reset_n), .q(),
    .rollover(rollover[1]));
    defparam digit1_val.n = 29;
    //defparam digit1_val.n = 30;
    defparam digit1_val.k = 500000000;
  modulo_counter digit2_val (.clk(clk), .reset_n(reset_n), .q(),
    .rollover(rollover[2]));
    defparam digit2_val.n = 33;
    //defparam digit2_val.k = 500000000 * 10;
	  defparam digit2_val.k = 33'b100101010000001011111001000000000;

  /*
  * These modules are incremented when the modules above rollover.
  * For example, digit0_disp is incremented when digit0_val rolls over.
  */
  modulo_counter digit0_disp (.clk(rollover[0]), .reset_n(reset_n),
    .q(count[3:0]), .rollover(rollover[3]));
    defparam digit0_disp.n = disp_bits;
    defparam digit0_disp.k = 10;
  modulo_counter digit1_disp (.clk(rollover[1]), .reset_n(reset_n),
    .q(count[7:4]), .rollover(rollover[4]));
    defparam digit1_disp.n = disp_bits;
    defparam digit1_disp.k = 10;
  modulo_counter digit2_disp (.clk(rollover[2]), .reset_n(reset_n),
    .q(count[11:8]), .rollover(rollover[5]));
    defparam digit2_disp.n = disp_bits;
    defparam digit2_disp.k = 10;

endmodule
