`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:48:31 11/06/2020
// Design Name:   clock_gen
// Module Name:   /home/ise/Desktop/Lab2/testbench_105138860.v
// Project Name:  Lab2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: clock_gen
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
	reg clk_in;
	reg rst;

	// Outputs
	wire clk_div_2;
	wire clk_div_4;
	wire clk_div_8;
	wire clk_div_16;
	wire clk_div_28;
	wire clk_div_5;
	wire clk_div_32;
	wire clk_percent_33;
	wire clk_percent_33_2;
	wire clk_or_33;
	wire clk_div_100;
	wire clk_div_200;
	wire [7:0] toggle_counter;

	// Instantiate the Unit Under Test (UUT)
	clock_gen uut (
		.clk_in(clk_in), 
		.rst(rst), 
		.clk_div_2(clk_div_2), 
		.clk_div_4(clk_div_4), 
		.clk_div_8(clk_div_8), 
		.clk_div_16(clk_div_16), 
		.clk_div_28(clk_div_28), 
		.clk_div_5(clk_div_5), 
		.clk_div_32(clk_div_32),
		.clk_percent_33(clk_percent_33),
		.clk_percent_33_2 (clk_percent_33_2),
		.clk_or_33 (clk_or_33),
		.clk_div_100(clk_div_100),
		.clk_div_200(clk_div_200),
		.toggle_counter(toggle_counter)
	);

	initial begin
		// Initialize Inputs
		clk_in = 0;
		rst = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		rst = 1;
		#50
		rst = 0;
	end
	
	always begin
		#10
		clk_in = ~clk_in;
	end
      
endmodule

