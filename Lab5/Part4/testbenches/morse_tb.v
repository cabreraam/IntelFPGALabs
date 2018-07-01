`timescale 1ns/1ns
`include "../../Part1/hdl/modulo_counter.v"
`include "../hdl/display_logic_new.v"
`include "../hdl/letter_sel_logic.v"
`include "../hdl/letter_size_reg.v"
`include "../hdl/letter_sym_sr.v"
`include "../hdl/morse_a_h_top.v"

module morse_tb();

  reg CLOCK_50;
  reg [1:0] KEY; //KEY[0] = reset; KEY[1] = load
  reg [2:0] SW;

  morse_a_h_top dut (.KEY(KEY),
                .CLOCK_50(CLOCK_50),
                .SW(SW),
                .LEDR()
                );

  // generate clock
  always begin
    CLOCK_50 = 1; #10; CLOCK_50 = 0; #10; // 20 ns period (50MHz CLK)
  end

  initial begin

    $dumpfile("anthony.vcd");
    $dumpvars(0, morse_tb);

    KEY = 2'b11; SW = 3'b0;
    #2; // 2ns
    KEY[0] = 1'b0; //Press RESET
    #20; //22 ns
    KEY[0] = 1'b1; // Release RESET
    #20; //42 ns
    KEY[1] = 1'b0; // Press LOAD
    #20; //64 ns
    KEY[1] = 1'b1; // Release LOAD
  end

  initial begin
    #1000000 $finish;
  end

endmodule
