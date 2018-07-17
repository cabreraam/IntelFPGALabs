

module multiplier(a, b, p);

    input [3:0] a, b;
    output [7:0] p;

    wire a0b0, a1b0, a2b0, a3b0;
    wire a0b1, a1b1, a2b1, a3b1;
    wire a0b2, a1b2, a2b2, a3b2;
    wire a0b3, a1b3, a2b3, a3b4;

    always @ (a or b)
    begin
        a0b0 = a[0] & b[0]; a1b0 = a[1] & b[0]; 
        a2b0 = a[2] & b[0]; a3b0 = a[3] & b[0]; 

        a0b1 = a[0] & b[1]; a1b1 = a[1] & b[1]; 
        a2b1 = a[2] & b[1]; a3b1 = a[3] & b[1]; 

        a0b2 = a[0] & b[2]; a1b2 = a[1] & b[2]; 
        a2b2 = a[2] & b[2]; a3b2 = a[3] & b[2]; 

        a0b3 = a[0] & b[3]; a1b2 = a[1] & b[3]; 
        a2b3 = a[2] & b[3]; a3b2 = a[3] & b[3]; 
    end

    full_add_1_bit r1

    

endmoudle
