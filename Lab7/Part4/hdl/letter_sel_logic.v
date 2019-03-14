//dot = 0; dash = 1; don't care = 0, enumerated X
// CHANGING THIS from LAB5. Passing in state from moore_fsm
// instead of directly taking input from switches. This results
// in changing letter_in[2:0] --> input_state[4:0]
module letter_sel_logic(input_state, size, letter_out);

  input [4:0] input_state;
  output reg  [2:0] size;
  output reg [3:0] letter_out;

  always @ (input_state)
  begin

    case (input_state)

      5'h1: begin // A
        size <= 3'd2;
        letter_out <= 4'b0100; // * _ X X
      end
      5'h2: begin // B
        size <= 3'd4;
        letter_out <= 4'b1000; // _ * * *
      end
      5'h3: begin // C
        size <= 3'd4;
        letter_out <= 4'b1010; // _ * _ *
      end
      5'h4: begin // D
        size <= 3'd3;
        letter_out <= 4'b1000;// _ * * X
      end
      5'h5: begin // E
        size <= 3'd1;
        letter_out <= 4'b0000; // * X X X
      end
      5'h6: begin // F
        size <= 3'd4;
        letter_out <= 4'b0010; // * * _ *
      end
      5'h7: begin // G
        size <= 3'd3;
        letter_out <= 4'b1100; // _ _ * X
      end
      5'h8: begin // H
        size <= 3'd4;
        letter_out <= 4'b0000; // * * * * 
      end
		default: begin
		  size <= 3'd0;
		  letter_out <= 4'b0000;
		end
    endcase

  end

endmodule
