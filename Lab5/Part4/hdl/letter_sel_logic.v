//dot = 0; dash = 1; don't care = 0, enumerated X

module letter_sel_logic(letter_in, size, letter_out);

  input [2:0] letter_in;
  output reg  [2:0] size;
  output reg [3:0] letter_out;

  always @ (letter_in)
  begin

    case (letter_in)

      3'b000: begin // A
        size <= 3'd2;
        letter_out <= 4'b0100; // * _ X X
      end
      3'b001: begin // B
        size <= 3'd4;
        letter_out <= 4'b1000; // _ * * *
      end
      3'b010: begin // C
        size <= 3'd4;
        letter_out <= 4'b1010; // _ * _ *
      end
      3'b011: begin // D
        size <= 3'd3;
        letter_out <= 4'b1000;// _ * * X
      end
      3'b100: begin // E
        size <= 3'd1;
        letter_out <= 4'b0000; // * X X X
      end
      3'b101: begin // F
        size <= 3'd4;
        letter_out <= 4'b0010; // * * _ *
      end
      3'b110: begin // G
        size <= 3'd3;
        letter_out <= 4'b1100; // _ _ * X
      end
      3'b111: begin // H
        size <= 3'd4;
        letter_out <= 4'b0000; // * * * * 
      end

    endcase

  end

endmodule
