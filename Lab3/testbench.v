`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:56:43 11/27/2020
// Design Name:   parking_meter
// Module Name:   /home/ise/Desktop/Parking_Meter/testbench.v
// Project Name:  Parking_Meter
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: parking_meter
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testbench;

	// Inputs
	reg add1;
	reg add2;
	reg add3;
	reg add4;
	reg rst1;
	reg rst2;
	reg rst;
	reg clk;

	// Outputs
	wire [6:0] led_seg;
	wire [3:0] val1;
	wire [3:0] val2;
	wire [3:0] val3;
	wire [3:0] val4;

	// Instantiate the Unit Under Test (UUT)
	parking_meter uut (
		.add1(add1), 
		.add2(add2), 
		.add3(add3), 
		.add4(add4), 
		.rst1(rst1), 
		.rst2(rst2), 
		.rst(rst), 
		.clk(clk), 
		.led_seg(led_seg),
		.val1(val1),
		.val2(val2),
		.val3(val3),
		.val4(val4)
	);

	initial begin
		// Initialize Inputs
		add1 = 0;
		add2 = 0;
		add3 = 0;
		add4 = 0;
		rst1 = 0;
		rst2 = 0;
		rst = 0;
		clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
      rst = 1;
		#50000000;
		rst = 0;
		#50000000;
		add2 = 1;
		#50000000;
		add2 = 0;
		#50000000;
		#50000000;
		#50000000;
		#50000000;
		rst1 = 1;
		#50000000;
		rst1 = 0;
		#50000000;
		rst2 = 1;
		#50000000;
		rst2 = 0;
		#50000000;
		add1 = 1;
		#50000000;
		add1 = 0;
	end
	
	always begin
		#50000000;    //100 hz
		clk = ~clk;
	end 
endmodule

