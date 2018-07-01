/*
 * Design a real-time clock
 *
 * 1) display minutes (0 to 59) on HEX5-4
 * 2) display seconds (0 to 59) on HEX3-2
 * 3) display hundreths of a second (0 to 99) on HEX1-0
 * 4) when KEY1 is pressed, use SW7-0 to adjust minutes
 * 5) when KEY0 is pressed, stop the clock. when it is not pressed, clock runs
 */

module rt_clock_top(KEY, CLOCK_50, SW, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);

  input [1:0] KEY;
  input CLOCK_50;
  input [8:0] SW;
  output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;


  wire [7:0] huns, secs, mins;

  rt_clock clock (.clk(CLOCK_50), .set_n(KEY[1]), .stop_n(KEY[0]),
    .set_val(SW), .mins(mins), .secs(secs), .huns(huns));

  char_7seg_0_9 huns0 (.C(huns[3:0]), .Display(HEX0));
  char_7seg_0_9 huns1 (.C(huns[7:4]), .Display(HEX1));
  char_7seg_0_9 secs0 (.C(secs[3:0]), .Display(HEX2));
  char_7seg_0_9 secs1 (.C(secs[7:4]), .Display(HEX3));
  char_7seg_0_9 mins0 (.C(mins[3:0]), .Display(HEX4));
  char_7seg_0_9 mins1 (.C(mins[7:4]), .Display(HEX5));

endmodule
