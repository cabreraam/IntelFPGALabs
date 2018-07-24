module mult_top(SW, HEX0, HEX2, HEX4, HEX5)

    input [7:0] SW;
    output [6:0] HEX0, HEX2, HEX4, HEX5;

    wire [3:0] a, b;
    wire [7:0] p;

    mult my_mult(.a(a), .b(b), .p(p));

    /* Display */
    char_7seg_hex a_disp (.C(a), .Display(HEX0));
    char_7seg_hex b_disp (.C(b), .Display(HEX2));
    char_7seg_hex p0_disp (.C(p[3:0]), .Display(HEX4));
    char_7seg_hex p1_disp(.C(p[7:4]), .Display(HEX5));

    assign a = SW[3:0]; assign b = SW[7:4];

endmodule
