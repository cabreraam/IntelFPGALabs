//module letter_size_reg(d, clk, reset_n, en, ld, q);

// removed en
module letter_size_reg(d, clk, reset_n, ld, q);

  //input           clk, reset_n, en, ld;
  input           clk, reset_n, ld; //TODO: Don't need enable signal for this register anymore, right?
  input   [2:0]   d;
  output reg [2:0]   q;

  always @ (posedge clk or negedge reset_n)
  begin

    if (!reset_n)
      q = 3'b000;
    else if (ld)
      q = d;

  end

endmodule
