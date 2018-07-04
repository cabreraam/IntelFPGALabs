module accumulator(clk, a, a_reg, sum, v, c, reset_n);

  input [7:0] a;
  input clk, reset_n;
  output [7:0] a_reg;
  output reg v, c; // v = overflow flag, c = carry flag
  output reg [7:0] sum;

  // internal signals
  wire [7:0] sum_d;
  wire v_d, c_d; // d as in data to DFF
  reg [7:0] a_q; // q as in output of DFF

  full_add_8_bit adder (.a(a_q), .b(sum), .c_in(1'b0), .sum(sum_d), .c_out(c_d));

  always @ (posedge clk or negedge reset_n)
  begin

    if (!reset_n)
    begin
      a_q <= 8'b0;
      sum <= 8'b0;
      c <= 1'b0;
      v <= 1'b0;
    end
    else
    begin
      a_q <= a;
      sum <= sum_d;
      c <= c_d;
      v <= v_d;
    end


  end

  //assign v_d = (!(a_q[7] & sum[7]) | (a_q[7] & sum[7])) & sum_d[7];
  // for overflow, either both adder operands were positive but the sum is
  // negative, or both operands were negative but the sum is positive.
  assign v_d = (a_q[7] & sum[7] & !sum_d[7]) | (!a_q[7] & !sum[7] & sum_d[7]);
  assign a_reg = a_q;



endmodule
