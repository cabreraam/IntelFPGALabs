module full_add_8_bit(a, b, c_in, sum, c_out);

  input [7:0] a, b;
  input c_in;
  output [7:0] sum;
  output c_out;

  wire [7:0] c_internal;

  full_add_1_bit b0 (.a(a[0]), .b(b[0]), .c_in(c_in), .sum(sum[0]),
    .c_out(c_internal[0]));
  full_add_1_bit b1 (.a(a[1]), .b(b[1]), .c_in(c_internal[0]), .sum(sum[1]),
    .c_out(c_internal[1]));

  full_add_1_bit b2 (.a(a[2]), .b(b[2]), .c_in(c_internal[1]), .sum(sum[2]),
    .c_out(c_internal[2]));
  full_add_1_bit b3 (.a(a[3]), .b(b[3]), .c_in(c_internal[2]), .sum(sum[3]),
    .c_out(c_internal[3]));
  full_add_1_bit b4 (.a(a[4]), .b(b[4]), .c_in(c_internal[3]), .sum(sum[4]),
    .c_out(c_internal[4]));
  full_add_1_bit b5 (.a(a[5]), .b(b[5]), .c_in(c_internal[4]), .sum(sum[5]),
    .c_out(c_internal[5]));
  full_add_1_bit b6 (.a(a[6]), .b(b[6]), .c_in(c_internal[5]), .sum(sum[6]),
    .c_out(c_internal[6]));
  full_add_1_bit b7 (.a(a[7]), .b(b[7]), .c_in(c_internal[6]), .sum(sum[7]),
    .c_out(c_internal[7]));

  assign c_out = c_internal[7];

endmodule
