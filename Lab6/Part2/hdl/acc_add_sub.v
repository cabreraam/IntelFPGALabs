// the subtract functionality was based on the excellent description found here:
// http://barrywatson.se/dd/dd_adder_subtractor.html

module acc_add_sub(reset_n, clk, a, a_reg, add_sig, sum, v, c);

  input [7:0] a;
  input clk, reset_n, add_sig;
  //output [7:0] a_reg;
  output reg [7:0] a_reg;
  output reg v, c; // v = overflow flag, c = carry flag
  output reg [7:0] sum;

  // internal signals
  wire [7:0] sum_d;
  wire v_d, c_d; // d as in data to DFF
  reg [7:0] a_q; // q as in output of DFF
  wire [7:0] a_xor_add_sig; // explained in the link above

  full_add_8_bit adder (.a(a_xor_add_sig), .b(sum), .c_in(add_sig), .sum(sum_d), .c_out(c_d));

  always @ (posedge clk or negedge reset_n)
  begin

    if (!reset_n)
    begin
      a_q <= 8'b0;
      sum <= 8'b0;
      c <= 1'b0;
      v <= 1'b0;
		a_reg <= 8'b0;
    end
    else
    begin
      a_q <= a_xor_add_sig;
      sum <= sum_d;
      c <= c_d;
      v <= v_d;
		a_reg <= a_xor_add_sig + add_sig;
    end


  end

  // for overflow, either both adder operands were positive but the sum is
  // negative, or both operands were negative but the sum is positive.
  assign v_d = (a_q[7] & sum[7] & !sum_d[7]) | (!a_q[7] & !sum[7] & sum_d[7]);

  //assign a_reg = a_q;

  // when add_sig == 0, accumulator is in adding mode, and anything XOR'd with
  // 0 just equals itself.
  // when add_sig == 1, accumulator is in subtracting mode, and anything
  // XOR'd with 1 will flip the original bit. 0 ^ 1 = 1, 1 ^ 1 = 0.
  assign a_xor_add_sig = a ^ {add_sig, add_sig, add_sig, add_sig, add_sig,
    add_sig, add_sig, add_sig};


endmodule
