

module multiplier(a, b, p);

    input [3:0] a, b;
    output [7:0] p;

    /* internal signals */
    /* ANDs */
    wire a0b0, a1b0, a2b0, a3b0;
    wire a0b1, a1b1, a2b1, a3b1;
    wire a0b2, a1b2, a2b2, a3b2;
    wire a0b3, a1b3, a2b3, a3b4;

    /* full adder signals */
    wire [3:0] s_r1, s_r2, s_r3;
    wire [3:0] co_r1, co_r2, co_r3;

    /* Need an individual adder for row 1, 2, 3 */
    full_add_1_bit r1c1 (.a(a1b0), .b(a0b1), .c_in(1'b0), .sum(s_r1[0]), 
        .c_out(co_r1[0]));
    full_add_1_bit r1c2 (.a(a2b0), .b(a1b1), .c_in(co_r1[0]), .sum(s_r1[1]),
        .c_out(co_r1[1]));
    full_add_1_bit r1c3 (.a(a3b0), .b(a2b1), .c_in(co_r1[1]), .sum(s_r1[2]),
        .c_out(co_r1[2]));
    full_add_1_bit r1c4 (.a(1'b0), .b(a3b1), .c_in(co_r1[2]), .sum(s_r1[3]),
        .c_out(co_r1[3]));

    full_add_1_bit r2c2 (.a(s_r1[1]), .b(a0b2), .c_in(1'b0), .sum(s_r2[0]), 
        .c_out(co_r2[0]));
    full_add_1_bit r2c3 (.a(s_r1[2]), .b(a1b2), .c_in(co_r2[0]), .sum(s_r2[1]), 
        .c_out(co_r2[1]));
    full_add_1_bit r2c4 (.a(s_r1[3]), .b(a2b2), .c_in(co_r2[1]), .sum(s_r2[2]), 
        .c_out(co_r2[2]));
    full_add_1_bit r2c5 (.a(co_r1[3]), .b(a3b2), .c_in(co_r2[2]), .sum(s_r2[3]), 
        .c_out(co_r2[3]));

    full_add_1_bit r3c2 (.a(s_r2[1]), .b(a0b3), .c_in(1'b0), .sum(s_r3[0]), 
        .c_out(c0_r3[0]));
    full_add_1_bit r3c3 (.a(s_r2[2]), .b(a1b3), .c_in(c0_r3[0]), .sum(s_r3[1]), 
        .c_out(c0_r3[1]));
    full_add_1_bit r3c4 (.a(s_r2[3]), .b(a2b3), .c_in(c0_r3[1]), .sum(s_r3[2]), 
        .c_out(c0_r3[2]));
    full_add_1_bit r3c5 (.a(co_r2[3]), .b(a3b3), .c_in(c0_r3[2]), .sum(s_r3[3]), 
        .c_out(c0_r3[3]));

    /* assign full adder internal signals to appropriate output signals */
    /* comb. logic for all bitwise ANDs */
    always @ (a or b)
    begin
        a0b0 <= a[0] & b[0]; a1b0 <= a[1] & b[0]; 
        a2b0 <= a[2] & b[0]; a3b0 <= a[3] & b[0]; 

        a0b1 <= a[0] & b[1]; a1b1 <= a[1] & b[1]; 
        a2b1 <= a[2] & b[1]; a3b1 <= a[3] & b[1]; 

        a0b2 <= a[0] & b[2]; a1b2 <= a[1] & b[2]; 
        a2b2 <= a[2] & b[2]; a3b2 <= a[3] & b[2]; 

        a0b3 <= a[0] & b[3]; a1b2 <= a[1] & b[3]; 
        a2b3 <= a[2] & b[3]; a3b2 <= a[3] & b[3]; 
    end

   /* comb. logic for output signals */
   assign p[0] = a0b0; 
   assign p[1] = s_r1[0]; 
   assign p[2] = s_r2[0]; 
   assign p[7:3] = s_r3[3:0]; 


endmodule
