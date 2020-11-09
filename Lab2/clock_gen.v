`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ryan Riahi
// 
// Create Date:    19:25:55 11/06/2020 
// Design Name: 
// Module Name:    clock_gen 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module clock_gen(
	input clk_in,
	input rst,
	output clk_div_2,
	output clk_div_4,
	output clk_div_8,
	output clk_div_16,
	output clk_div_28,
	output clk_div_5,
	output clk_div_32,
	output clk_percent_33,
	output clk_percent_33_2,
	output clk_or_33,
	output clk_div_100,
	output clk_div_200,
	output [7:0] toggle_counter
    );
	 
	 
	clock_div_two task_one(
		.clk_in	(clk_in),
		.rst	(rst),
		.clk_div_2(clk_div_2),
		.clk_div_4(clk_div_4),
		.clk_div_8(clk_div_8),
		.clk_div_16(clk_div_16)
		);
	clock_div_twenty_eight task_two(
		.clk_in	(clk_in),
		.rst	(rst),
		.clk_div_28(clk_div_28)
		);
	clock_div_five task_three(
		.clk_in	(clk_in),
		.rst	(rst),
		.clk_div_5(clk_div_5)
		);
	clock_strobe task_four(
		.clk_in	(clk_in),
		.rst	(rst),
		.toggle_counter (toggle_counter)
		);
	clock_div_thirty_two task_five(
		.clk_in	(clk_in),
		.rst	(rst),
		.clk_div_32(clk_div_32)
	);
	clock_percent_thirty_three task_six(
		.clk_in	(clk_in),
		.rst	(rst),
		.clk_percent_33(clk_percent_33),
		.clk_percent_33_2(clk_percent_33_2),
		.clk_or_33 (clk_or_33)
	);
	clock_div_two_hundred task_seven(
		.clk_in	(clk_in),
		.rst	(rst),
		.clk_div_100(clk_div_100),
		.clk_div_200(clk_div_200)
	);
endmodule

module clock_div_two(
	clk_in, rst, clk_div_2, clk_div_4, clk_div_8, clk_div_16);
	input clk_in;
	input rst;
	output reg clk_div_2;
	output reg clk_div_4;
	output reg clk_div_8;
	output reg clk_div_16;
	reg [3:0] a;
	
	always @ (posedge clk_in) begin
		//counter:
		if (rst)
			a <= 4'b0000;
		else
			a <= a + 1'b1;
		// set the values to the corresponding bits:
		clk_div_2 <= a[0];
		clk_div_4 <= a[1];
		clk_div_8 <= a[2];
		clk_div_16 <= a[3];
	end
endmodule

module clock_div_twenty_eight(
	clk_in, rst, clk_div_28
	);
	input clk_in;
	input rst;
	output reg clk_div_28;
	reg [3:0] a;

	always @ (posedge clk_in) begin
		if (rst) begin
			a <= 4'b0000;
			clk_div_28 <= 1'b0;
		end
		else begin
			a <= a + 1'b1;
			if (a[3:0] == 4'b1101) begin	// when the counter is 13 we flip the divide by 28 clock and reset the counter
				a <= 4'b0000;
				clk_div_28 <= ~clk_div_28;
			end
		end
	end			
endmodule

module clock_div_thirty_two(
	input clk_in, input rst, output reg clk_div_32
	);
	reg [3:0] a;

	always @ (posedge clk_in) begin
		if (rst) begin
			a <= 4'b0000;
			clk_div_32 <= 1'b0;
		end
		else begin
			a <= a + 1'b1;
			if (a[3:0] == 4'b0000) begin		// flip the divide by 32 clock whenever the counter overflows to 0000
				clk_div_32 <= ~clk_div_32;
			end
		end
	end	
		
endmodule

module clock_percent_thirty_three(
	input clk_in, input rst, output reg clk_percent_33, output reg clk_percent_33_2, output reg clk_or_33
	);
	reg [1:0] a;
	reg on;
	reg on2;
	reg [1:0] a2;
	// 33% duty cycle triggered on a positive edge:
	always @ (posedge clk_in) begin
		if (rst) begin
			a <= 2'b00;
			clk_percent_33 <= 1'b0;
			on <= 1'b0;
			clk_or_33 <= 1'b0;
		end
		else begin
			a <= a + 1'b1;
			if ((on == 1'b0 && a[1:0] == 2'b11) || (on == 1'b1 && a[1:0] == 2'b01)) begin		// if the signal is off and the counter is 3 or
				clk_percent_33 <= ~clk_percent_33;						// when the signal is on and the counter is 2,
				on <= ~on;									// we flip the 33% clocks
				a <= 2'b00;
			end
			clk_or_33 <= (clk_percent_33 || clk_percent_33_2);					// take the or of the two clocks to generate a 41% duty cycle clock
		end
	end		
	// 33% duty cycle triggered on a negative edge:
	always @ (negedge clk_in) begin
		if (rst) begin
			a2 <= 2'b00;
			clk_percent_33_2 <= 1'b0;
			on2 <= 1'b0;
			clk_or_33 <= 1'b0;
		end
		else begin
			a2 <= a2 + 1'b1;
			if ((on2 == 1'b0 && a2[1:0] == 2'b11) || (on2 == 1'b1 && a2[1:0] == 2'b01)) begin
				clk_percent_33_2 <= ~clk_percent_33_2;
				on2 <= ~on2;
				a2 <= 2'b00;
			end
			clk_or_33 <= (clk_percent_33 || clk_percent_33_2);
		end
	end
endmodule

module clock_div_five (
	input clk_in, input rst, output reg clk_div_5
	);

	reg [2:0] a;
	
	always @ (posedge clk_in or negedge clk_in) begin
		if (rst) begin
			a <= 4'b000;
			clk_div_5 = 1'b0;
		end
		else begin
			a <= a + 1'b1;
			if (a[2:0] == 3'b100) begin		// when the counter value is 4, we flip the divide by 5 clock and reset the counter
				a <= 3'b000;
				clk_div_5 <= ~clk_div_5;
			end
		end
	end
endmodule

module clock_div_two_hundred(
	input clk_in, input rst, output reg clk_div_100, output reg clk_div_200
	);
	reg [6:0] a;
	// divide by 100 clock:
	always @ (posedge clk_in) begin
		if (rst) begin
			a <= 7'b0000000;
			clk_div_100 <= 1'b0;
		end
		else begin
			a <= a + 1'b1;
			if (a[6:0] == 7'b1100100) begin			// when the counter is equal to 100, we reset it and flip the divide by 100 clock
				a <= 7'b0000000;
				clk_div_100 <= ~clk_div_100;
			end
			else
				clk_div_100 <= 1'b0;
		end
	end
	// divide by 200 clock:
	always @ (posedge clk_in) begin
		if (rst)
			clk_div_200 <= 1'b0;
		else begin
			if (clk_div_100)				// whenever the divide by 100 clock is active, we flip the divide by 200 clock
				clk_div_200 <= ~clk_div_200;
		end
	end
endmodule

module clock_strobe (
	input clk_in, input rst, output reg [7:0] toggle_counter
);
	reg strobe;
	reg [1:0] a;
	always @ (posedge clk_in) begin
		
		if (rst) begin
			a <= 4'b00;
			strobe <= 1'b0;
			toggle_counter <= 8'b00000000;
		end
		else begin
			a <= a + 1'b1;
			strobe <= a[1];		
			if (strobe) begin					// when strobe is active, we subtract by 5
				toggle_counter <= toggle_counter - 3'b101;
				strobe <= ~strobe;
			end
			else
				toggle_counter <= toggle_counter + 2'b10;	// otherwise we add 2
		end
	end
endmodule
