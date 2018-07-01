/*
 * Design a real-time clock
 *
 * 1) display minutes (0 to 59) on HEX5-4
 * 2) display seconds (0 to 59) on HEX3-2
 * 3) display hundreths of a second (0 to 99) on HEX1-0
 * 4) when KEY1 is pressed, use SW7-0 to adjust minutes
 * 5) when KEY0 is pressed, stop the clock. when it is not pressed, clock runs
 */

/*
 * clock, set, stop, minutes, seconds, hundredths
 */
module rt_clock(clk, set_n, stop_n, set_val, mins, secs, huns);

  input clk, set_n, stop_n;
  input [8:0] set_val;
  output [7:0] mins, secs, huns;

  //internal signals
  wire [5:0] roll;

  /* modules for hundredths*/
  //modulo_counter huns_count (.clk(clk), .reset_n(set_val[8]), .q(),
  //  .rollover(roll[0]));
  set_stop_modulo_counter huns_count (
    .clk(clk), .set_n(set_val[8]), .stop_n(stop_n), .set_val(), .q(), .rollover(roll[0]));
    defparam huns_count.n = 19;
    defparam huns_count.k = 19'b1111010000100100000;
  modulo_counter huns0_disp (.clk(roll[0]), .reset_n(set_val[8]), .q(huns[3:0]),
    .rollover(roll[1]));
    defparam huns0_disp.n = 4;
    defparam huns0_disp.k = 10;
  modulo_counter huns1_disp (.clk(roll[1]), .reset_n(set_val[8]), .q(huns[7:4]),
    .rollover(roll[2]));
    defparam huns1_disp.n = 4;
    defparam huns1_disp.k = 10;

  // modules for seconds
  modulo_counter secs0_disp (.clk(roll[2]), .reset_n(set_val[8]), .q(secs[3:0]),
    .rollover(roll[3]));
    defparam secs0_disp.n = 4;
    defparam secs0_disp.k = 10;
  modulo_counter secs1_disp (.clk(roll[3]), .reset_n(set_val[8]), .q(secs[7:4]),
    .rollover(roll[4]));
    defparam secs1_disp.n = 4;
    defparam secs1_disp.k = 6;

  // modules for minutes
  //set_stop_modulo_counter mins0_disp (.clk(roll[4]), .set_n(set_n),
  ssr_modulo_counter mins0_disp (.clk(roll[4]), .set_n(set_n),
    .stop_n(stop_n), .reset_n(set_val[8]), .set_val(set_val[3:0]), .q(mins[3:0]), .rollover(roll[5]));
    defparam mins0_disp.n = 4;
    defparam mins0_disp.k = 10;
  //set_stop_modulo_counter mins1_disp (.clk(roll[5]), .set_n(set_n),
  ssr_modulo_counter mins1_disp (.clk(roll[5]), .set_n(set_n),
    .stop_n(stop_n), .reset_n(set_val[8]), .set_val(set_val[7:4]), .q(mins[7:4]), .rollover());
    defparam mins1_disp.n = 4;
    defparam mins1_disp.k = 6;


endmodule
