module modulo_counter (clk, reset_n, q, rollover);

  parameter n = 4;
  parameter k = 8;

  input clk, reset_n;
  output reg [n-1:0] q;
  output reg rollover;

  always @ (posedge clk or negedge reset_n)
  begin

    if (!reset_n)
    begin
      q <= 0;
      rollover <= 0;
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
