// inputs:
// clk is the input CLOCK_50
// count2_in is an internal signal for now
// size_in (may not be needed) is how many symbols are needed for a character
//    WE PROBABLY NEED THIS
// sym_in is either 0 or 1 for a dot or dash, respectively
// reset_n is KEY[0] which resets everything
// disp_n is KEY[1] and lets us know that we are ready to load/display a new
//    value
// ld_out is tied to ~disp_n and lets the registers know to shift in the letter
//    specified by the input switches
// en_reg_out tells the shift register to shift a new value in.
// en_count_out enables the 1or3 pulse counter to start counting
// reset_out tells the 1or3 pulse counter to reset
//  (this will be used as an internal signal for now until we migrate counters
//  outside of this display logic module)
// led_out controls the LED that pulses
/*module display_logic(clk, count2_in, size_in, sym_in, reset_n, disp_n, ld_out,
  en_reg_out, en_count_out, reset_out, led_out);*/
/*module display_logic(clk, size_in, sym_in, reset_n, disp_n, ld_out,
  en_reg_out, en_count_out, led_out);
  // contains both combo and seq logic

  //input [1:0] count2_in, size_in;
  input [1:0] size_in;
  input clk, reset_n, disp_n, sym_in;
  //output ld_out, en_reg_out, en_count_out, reset_out, led_out;
  output ld_out;
  //output reg en_reg_out, en_count_out, reset_out, led_out;
  output reg en_reg_out, en_count_out, led_out;

  // internal signals
  wire half_sec_sig;
  wire [1:0] count2_in;
  reg reset_count_1or3;
  reg [2:0] count_size_reg;
  reg [1:0] array_1or3 [2]; // hold LED for either 1 or 3 pulses
  reg reset_out; // for half second counter

  initial
  begin
    array_1or3[0] = 2'd1;
    array_1or3[1] = 2'd3;
    count_size_reg = 3'd0;
  end

  modulo_counter half_sec (.clk(clk & en_count_out), .reset_n(reset_out), .q(),
    .rollover(half_sec_sig));
    defparam half_sec.n = 25;
    defparam half_sec.k = 25'b1011111010111100001000000;

  modulo_counter count_1or3 (.clk(half_sec_sig), .reset_n(reset_count_1or3), .q(count2_in), .rollover(TBD));
    defparam count_1or3.n = 3;
    defparam count_1or3.k = 4;
    //TODO: May need to address this

  //modulo_counter count_size (.clk(), .reset_n(), .q(), .rollover());

  always @ (negedge reset_n)
  begin
    //ld_out <= 1'b0; TODO: This needs to be a wire...no need for this signal
    en_reg_out <= 1'b0;
    en_count_out <= 1'b0;
    reset_out <= 1'b1; //TODO: currently all of the counters are wrapped in this module and not an external one,
							// so you need to remodularize to shove the counter out!
    led_out <= 1'b0;

    reset_count_1or3 <= 1'b1;
  end

  always @ (ld_out)
  begin
    if (ld_out)
      led_out <= 1'b1;
      en_count_out <= 1'b1;
      reset_out <= 1'b0;
      reset_count_1or3 <= 1'b0;
    //else TODO: WHAT IS THE ELSE CONDITION

  end

  always @ (posedge half_sec_sig)
  begin
    // if we've pulsed an led for long enough
    if (count2_in == array_1or3[sym_in])
    begin
      en_reg_out <= 1'b1; // shift to next value
      led_out <= 1'b0; // turn LED off
      reset_count_1or3 <= 1'b1; // reset 1 or 3
      //TODO: need to keep track of how many symbols have been processed then
      //  set the half_sec reset signal to high
      if (count_size_reg ~= size_in)
      begin
        count_size_reg = count_size_reg + 1'b1;
      end
      else
      begin
        count_size_reg <= 3'd0;
        reset_out <= 1'b1;
      end
    end
    else
    begin
      en_reg_out <= 1'b0;
      led_out <= 1'b1;
      reset_count_1or3 <= 1'b0;
    end

  end

  assign ld_out = ~disp_n;

endmodule*/
