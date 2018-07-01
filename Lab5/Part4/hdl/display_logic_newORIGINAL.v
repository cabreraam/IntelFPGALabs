module display_logic_new(clk, count2_in, size_in, sym_in, reset_n, disp_n, //half_sec_in,
  ld_out, en_reg_out, en_count_out, reset_count_out, led_out, //);
  debug_all_syms_procd, debug_size_in, debug_size_count, debug_count2_in, debug_sym_in);

  input clk, sym_in, disp_n, reset_n; //TODO: maybe don't need reset?
  input [2:0] size_in;
  input [1:0] count2_in;
  output ld_out;
  output reg en_reg_out, en_count_out, reset_count_out, led_out;
  //debug outputs
  output reg debug_all_syms_procd;
  output [2:0] debug_size_in, debug_size_count;
  output [1:0] debug_count2_in;
  output debug_sym_in;

  //internal signals
  //reg [1:0] array_1or3; // hold LED for either 1 or 3 pulses
  reg [2:0] size_counter;
  reg led_off_for_one_pulse;
  wire [1:0] array_1or3;

  always @ (posedge clk or negedge reset_n)
  begin

    if (!reset_n)
    begin
      en_reg_out <= 1'b0;
      en_count_out <= 1'b0;
      reset_count_out <= ~(1'b1);
      led_out <= 1'b0;

      size_counter <= 3'd0;
      led_off_for_one_pulse <= 1'b0;
      //debug signals
      debug_all_syms_procd <= 1'b0;
    end

    else if (~disp_n) // start displaying!
    begin
      //en_reg_out <= 1'b1;
      en_count_out <= 1'b1;
      reset_count_out <= ~(1'b1);
      led_out <= 1'b1;

      size_counter <= 3'd0;
      //size_counter <= 3'd1;
      led_off_for_one_pulse <= 1'b0;
    end

    else if ((led_off_for_one_pulse == 1'b1) && (count2_in == 2'b1)) // if going blank for a bit;
    begin

      led_off_for_one_pulse <= 1'b0;
      led_out <= 1'b1;
      reset_count_out <= ~(1'b1); //TODO: Necessary?
      en_count_out <= 1'b1; //TODO: Necessary?
      //size_counter <= size_counter + 1'b1; //TODO: Placement?

      //debug
      //debug_all_syms_procd <= 1'b1; //TODO: DELETE
    end

    //else if (count2_in == size_in) // if one sym has been processed
    //else if (sym_in == array_1or3) // if one sym has been proc'd
    else if (count2_in == array_1or3) // if one sym has been proc'd
    begin

      led_out <= 0;
      //size_counter <= size_counter + 1'b1; // TODO: Placement?
      //if (size_in == size_counter - 1'b1) //if all syms of letter are processed
      if (size_in == size_counter) //if all syms of letter are processed
      begin
        en_reg_out <= 1'b0;
        en_count_out <= 1'b0;
        reset_count_out <= ~(1'b1);

        // debug
        debug_all_syms_procd <= 1'b1; //TODO: Uncomment this
        //debug_all_syms_procd <= 1'b0; //TODO: Delete this
        //size_counter <= 3'd0;
      end

      else // there are still some syms left to process
      begin
        en_reg_out <= 1'b1; // shift the next symbol out
        reset_count_out <= ~(1'b1); //should force count2_in to 0
        en_count_out <= 1'b0;

        size_counter <= size_counter + 1'b1;
        led_off_for_one_pulse <= 1'b1;
        debug_all_syms_procd <= 1'b0; //TODO: DELETE
      end
    end

    else
    begin
        en_reg_out <= 1'b0;
        reset_count_out <= ~(1'b0); //it's okay that 1to3 counter keeps going
    end
  end

  // combo logic
  assign ld_out = ~disp_n; // load values into letter size and letter symbol registers
  assign array_1or3 = (sym_in == 1'b0) ? 2'd1 : 2'd3;

  // debug
  //assign debug_size_in = size_in; // 9:7
  assign debug_size_in = count2_in; // 9:7
  assign debug_size_count = size_counter; //6:4
  assign debug_count2_in = array_1or3; //3:2
  assign debug_sym_in = sym_in; //1
  //assign debug_sym_in = debug_all_syms_procd; //1
  //assign debug_sym_in = en_count_out; //1
  //assign debug_count2_in = count2_in; //2:1 (works)

endmodule
