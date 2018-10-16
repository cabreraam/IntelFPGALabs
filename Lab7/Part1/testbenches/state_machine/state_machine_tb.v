`timescale 1ns/1ns
`include "state_machine.v"

module state_machine_tb();

	parameter n = 8;

	reg clk, reset_n, w;
	reg [3:0] i;

	wire z;

	state_machine dut (
		.clk(clk),
		.reset_n(reset_n),
		.w(w),
		.z(z)
	);

  // This is the logic that simulates a clock signal if your module requires
  // clk signal
	always begin
		clk = 1; #10; clk = 0; #10;
	end

	initial begin

		$dumpfile("state_machine.vcd");
		$dumpvars(0, state_machine_tb);

		
		reset_n = 1'b0; w = 1'b0; 
		#35;
		reset_n = 1'b1; 


		#20; // 2ns

		/* shift 4 1's in, then 0 */
		/* A->F->G->H->I->A */
		w = 1'b1;
		#100;
		w = 1'b0;
		#20;

		/* shift 3 1's in, then 0 */
		/* A->F->G->H->A */
		w = 1'b1;
		#60;
		w = 1'b0;
		#20;

		/* shift 2 1's in, then 0 */
		/* A->F->G->A */
		w = 1'b1;
		#40;
		w = 1'b0;
		#20;

		/* shift 1 1 in, then 0 */
		/* A->F->A */
		w = 1'b1;
		#20;
		w = 1'b0;
		#20;

		/* reset counter */
		w = 1'b1;
		#20;
		w = 1'b0;
		#20;

		/* shift 4 0's in, then 1 */
		/* A->B->C->D->E->A */
		w = 1'b0;
		#80;
		w = 1'b1;
		#20;

		/* shift 3 0's in, then 1 */
		/* A->B->C->D->E->A */
		w = 1'b0;
		#60;
		w = 1'b1;
		#20;

		/* shift 2 0's in, then 1 */
		/* A->B->C->D->E->A */
		w = 1'b0;
		#40;
		w = 1'b1;
		#20;

		/* shift 1 0's in, then 1 */
		/* A->B->C->D->E->A */
		w = 1'b0;
		#20;
		w = 1'b1;
		#20;

	end

initial begin
  #100000 $finish;
end

initial begin
  //#50 b = 4'b0100;
  //#50 b = 4'b0001;
end

endmodule
