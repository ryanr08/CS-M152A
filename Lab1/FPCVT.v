`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UZLA
// Engineer: Ryan Riahi
// 
// Create Date:    23:19:39 10/23/2020 
// Design Name: 
// Module Name:    FPCVT 
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
module FPCVT(D, S, E, F);

	// set up for input and output wires:
	input wire [12:0] D;

	output S;
	output reg [2:0] E;
	output reg [4:0] F;
	
	assign S = D[12];		// assign the sign bit

	reg [12:0] SM; // Sign magnitude register
	reg sixth_bit;

	always @ (D) begin
	
		// convert D to sign magnitude:
		if (S == 1'b0)	
			assign SM = D[12:0];
		else
			assign SM = {~D[12:0] + 1'b1};
		
		// handle overflow
		if (SM[12] == 1'b1)
			assign SM = ~SM[12:0];
		
		// Leading zero counter/extractor:
		casex(SM[12:5])
			{8'b00000000}: begin assign E=3'b000; assign F = SM[4:0]; assign sixth_bit=1'b0; end
			{8'b00000001}: begin assign E=3'b001; assign F = SM[5:1]; assign sixth_bit=SM[0]; end
			{8'b0000001x}: begin assign E=3'b010; assign F = SM[6:2]; assign sixth_bit=SM[1]; end
			{8'b000001xx}: begin assign E=3'b011; assign F = SM[7:3]; assign sixth_bit=SM[2]; end
			{8'b00001xxx}: begin assign E=3'b100; assign F = SM[8:4]; assign sixth_bit=SM[3]; end
			{8'b0001xxxx}: begin assign E=3'b101; assign F = SM[9:5]; assign sixth_bit=SM[4]; end
			{8'b001xxxxx}: begin assign E=3'b110; assign F = SM[10:6]; assign sixth_bit=SM[5]; end
			{8'b01xxxxxx}: begin assign E=3'b111; assign F = SM[11:7]; assign sixth_bit=SM[6]; end
		endcase
		
		// Rounding:
		if (sixth_bit == 1'b1) begin
			assign F = {F[4:0] + 1'b1};	// round up if sixth bit is 1
			if (F[4:0] == 5'b00000) begin	// Handle overflow of significand
				assign F = 5'b10000;
				assign E = {E[2:0] + 1'b1};
				if (E == 3'b000) begin		// Handle exception when exponent overflows as well
					assign E = 3'b111;
					assign F = 5'b11111;
				end
			end
		end
	end
endmodule
