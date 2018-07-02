module full_add_1_bit (a, b, c_in, sum, c_out);

  input a, b, c_in;
  output sum, c_out;

  assign {c_out, sum} = c_in + a + b;

endmodule
