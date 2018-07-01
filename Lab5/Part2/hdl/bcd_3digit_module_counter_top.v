module bcd_3digit_module_counter_top (KEY, CLOCK_50, LEDR, HEX0, HEX1, HEX2);

  input [1:0] KEY;
  input CLOCK_50;
  output [5:0] LEDR;
  output [6:0] HEX0, HEX1, HEX2;

  //internal signals
  wire [3:0] count0, count1, count2;

  bcd_3digit_module_counter counter (.reset_n(KEY[0]), .clk(CLOCK_50),
    .count({count2, count1, count0}), .rollover(LEDR));
  char_7seg_0_9 digit0 (.C(count0), .Display(HEX0));
  char_7seg_0_9 digit1 (.C(count1), .Display(HEX1));
  char_7seg_0_9 digit2 (.C(count2), .Display(HEX2));


endmodule
