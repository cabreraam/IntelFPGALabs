// implementation inspired by:
// https://courses.cs.washington.edu/courses/cse467/05wi/pdfs/lectures/07-SequentialVerilog.pdf

// parallel in, serial out

// input: 0 for 0.5 s, 1 for 1.5 s
module letter_sym_sr(d, clk, reset_n, en, ld, q);

  input         clk, reset_n, en, ld;
  input [3:0]   d;
  output        q;

  // internal signals
  reg [3:0]     sr;

  always @ (posedge clk or negedge reset_n)
  begin

    if (!reset_n)
      //q = 1'b0; TODO: 10137 HDL Procedural Assignment error: object "q" on LHS of assignment must have variable data types
		sr = 4'b0000;

    else if (ld)
      sr = d;

    else if (en)
      sr = {sr[2:0], 1'b0};

  end

  assign q = sr[3];


endmodule
