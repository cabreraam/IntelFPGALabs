`timescale 1ns/1ns
`include "../../hdl/state_machine.v"

module state_machine_tb();

	// DUT inputs
	reg clk, reset_n, w;
	// DUT outputs
	wire [3:0] state_output;
	wire z;

	state_machine dut (
		.clk(clk),
		.reset_n(reset_n),
		.w(w),
		.z(z),
		.state_output(state_output)	
	);

	// clock
	always begin
		clk = 1; #10; clk = 0; #10; // 100MHz Clock	
	end

	initial begin

		$dumpfile("state_machine.vcd");
		$dumpvars(0, state_machine_tb);

		reset_n = 1'b0; w = 1'b0;
		#15; 
		reset_n = 1'b1;
		#10;


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

endmodule
