`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   03:03:45 10/24/2020
// Design Name:   FPCVT
// Module Name:   /home/ise/Desktop/Lab1/testbench_105138860.v
// Project Name:  Lab1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: FPCVT
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testbench_105138860;

	// Inputs
	reg [12:0] D;

	// Outputs
	wire S;
	wire [2:0] E;
	wire [4:0] F;

	// Instantiate the Unit Under Test (UUT)
	FPCVT uut (
		.D(D), 
		.S(S), 
		.E(E), 
		.F(F)
	);

	initial begin
		// Initialize Inputs
		D = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		//0
		D = 13'b0000000000000;
		#10;
		//1
		D = 13'b0000000000001;
		#10;
		//-1
		D = 13'b1111111111111;
		#10;
		//108
		D = 13'b0000000110110;
		#10;
		//109
		D = 13'b0000001101101;
		#10;
		//110
		D = 13'b0000001101110;
		#10;
		//-3986
		D = 13'b1000001101110;
		#10;
		//-1938
		D = 13'b1100001101110;
		#10;
		//4095
		D = 13'b0111111111111;
		#10;
		//-4096
		D = 13'b1000000000000;
		#10;
	end
      
endmodule
