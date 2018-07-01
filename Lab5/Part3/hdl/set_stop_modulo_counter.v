// This counter will not have a reset function
// Number of bits is variable but set_val is not. Just something to keep in
//  mind. For this design to work, keep n = 4;
// For the rt_clock, will need to set k to either 5 or 9, depending on
//  mins/secs or huns
module set_stop_modulo_counter (clk, set_n, stop_n, set_val, q, rollover);

  parameter n = 4;
  parameter k = 8;

  input [3:0] set_val;
  input clk, set_n, stop_n;
  output reg [n-1:0] q;
  output reg rollover;

  always @ (posedge clk or negedge set_n or negedge stop_n)
  begin

    if (!set_n)
    begin
      q <= set_val;
      rollover <= 0;
    end

    else if (!stop_n)
    begin
      q <= q;
    end

    else if (q == k-1)
    begin
      q <= 1'd0;
      rollover <= 1;
    end

    else
    begin
      q <= q + 1'b1;
      rollover <= 0;
    end
  end

endmodule
