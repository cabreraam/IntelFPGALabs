/*
 * Description:
 * Design and implement a circuit that takes as input one of the
 * first eight letters of the alphabet and displays Morse code for it on a red
 * LED. Your circuit should use switches SW2-0 and pushbuttons KEY1-0 as inputs.
 *
 * Design Goals:
 * 1) When a user presses KEY[1], the circuit should display the Morse code
 *    for a letter specified by SW2-0 using 0.5 s pulses to represent dots, and
 *    1.5 s pulses for dashes.
 * 2) Pushbutton KEY0 should function as an asynchronous reset.
 */

// clk -> CLOCK_50
// reset_n -> KEY[0]
// disp_n -> KEY[1]
// letter -> SW[2:0]
// out -> LEDR[0]
/*module morse_a_h (clk, reset_n, disp_n, letter, out);

  input clk, reset_n;
  input [2:0] letter;
  output out;

  letter_sym_sr shift_reg (.d(), .clk(), .reset_n(), .en(), .ld(), .q());
  letter_size_reg size_reg (.d(), .clk(), .reset_n(), .en(), .ld(), .q());

endmodule*/
