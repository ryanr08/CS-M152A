`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UZLA
// Engineer: Ryan Riahi
// 
// Create Date:    00:18:43 12/10/2020 
// Design Name: 
// Module Name:    vending_machine 
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
module vending_machine(
    input CARD_IN,
    input VALID_TRAN,
    input [3:0] ITEM_CODE,
    input KEY_PRESS,
    input DOOR_OPEN,
    input RELOAD,
    input CLK,
    input RESET,
    output reg VEND,
    output reg INVALID_SEL,
    output reg FAILED_TRAN,
    output reg [2:0] COST
    );
	 
	 parameter IDLE = 4'b0000;
	 parameter RST = 4'b0001;
	 parameter RE_LOAD = 4'b0010;
	 parameter GET_CODE = 4'b0011;
	 parameter CHECK_VALID = 4'b0100;
	 parameter INVALID = 4'b0101;
	 parameter FAILED = 4'b0110;
	 parameter DISPLAY = 4'b0111;
	 parameter VEND_ITEM = 4'b1000;
	 
	 reg [3:0] current_state;
	 reg [3:0] next_state;
	 
	 reg [3:0] S0;
	 reg [3:0] S1;
	 reg [3:0] S2;
	 reg [3:0] S3;
	 reg [3:0] S4;
	 reg [3:0] S5;
	 reg [3:0] S6;
	 reg [3:0] S7;
	 reg [3:0] S8;
	 reg [3:0] S9;
	 reg [3:0] S10;
	 reg [3:0] S11;
	 reg [3:0] S12;
	 reg [3:0] S13;
	 reg [3:0] S14;
	 reg [3:0] S15;
	 reg [3:0] S16;
	 reg [3:0] S17;
	 reg [3:0] S18;
	 reg [3:0] S19;
	 
	 reg counter_on;
	 reg [2:0] counter;
	 reg [1:0] digit_count;
	 
	 reg [3:0] digit1;
	 reg [3:0] digit2;
	 reg door_was_open;
	 
	 // always block to update state : sequential - triggered by clock
	 always @ (posedge CLK) begin		
		if (RESET)
			current_state <= RST;
		else
			current_state <= next_state;
	 end
	 
	 always @ (posedge CLK) begin
		if (current_state == RST) begin	// reset all values to zero
			S0 <= 0000;
			S1 <= 0000;
			S2 <= 0000;
			S3 <= 0000;
			S4 <= 0000;
			S5 <= 0000;
			S6 <= 0000;
			S7 <= 0000;
			S8 <= 0000;
			S9 <= 0000;
			S10 <= 0000;
			S11 <= 0000;
			S12 <= 0000;
			S13 <= 0000;
			S14 <= 0000;
			S15 <= 0000;
			S16 <= 0000;
			S17 <= 0000;
			S18 <= 0000;
			S19 <= 0000;
			counter <= 3'b000;
			digit_count <= 2'b00;
			door_was_open <= 0;
		end
		else if (current_state == RE_LOAD) begin	// Set the number of items in each slot to 10
			S0 <= 10;
			S1 <= 10;
			S2 <= 10;
			S3 <= 10;
			S4 <= 10;
			S5 <= 10;
			S6 <= 10;
			S7 <= 10;
			S8 <= 10;
			S9 <= 10;
			S10 <= 10;
			S11 <= 10;
			S12 <= 10;
			S13 <= 10;
			S14 <= 10;
			S15 <= 10;
			S16 <= 10;
			S17 <= 10;
			S18 <= 10;
			S19 <= 10;
		end
		else if (current_state == VEND_ITEM) begin	// decrement count of vended item
			counter_on <= 1'b1;
			if (digit1 == 0 && digit2 == 0)
				S0 <= S0 - 1'b1;
			else if (digit1 == 0 && digit2 == 1)
				S1 <= S1 - 1'b1;
			else if (digit1 == 0 && digit2 == 2)
				S2 <= S2 - 1'b1;
			else if (digit1 == 0 && digit2 == 3)
				S3 <= S3 - 1'b1;
			else if (digit1 == 0 && digit2 == 4)
				S4 <= S4 - 1'b1;
			else if (digit1 == 0 && digit2 == 5)
				S5 <= S5 - 1'b1;
			else if (digit1 == 0 && digit2 == 6)
				S6 <= S6 - 1'b1;
			else if (digit1 == 0 && digit2 == 7)
				S7 <= S7 - 1'b1;
			else if (digit1 == 0 && digit2 == 8)
				S8 <= S8 - 1'b1;
			else if (digit1 == 0 && digit2 == 9)
				S9 <= S9 - 1'b1;
			else if (digit1 == 1 && digit2 == 0)
				S10 <= S10 - 1'b1;
			else if (digit1 == 1 && digit2 == 1)
				S11 <= S11 - 1'b1;
			else if (digit1 == 1 && digit2 == 2)
				S12 <= S12 - 1'b1;
			else if (digit1 == 1 && digit2 == 3)
				S13 <= S13 - 1'b1;
			else if (digit1 == 1 && digit2 == 4)
				S14 <= S14 - 1'b1;
			else if (digit1 == 1 && digit2 == 5)
				S15 <= S15 - 1'b1;
			else if (digit1 == 1 && digit2 == 6)
				S16 <= S16 - 1'b1;
			else if (digit1 == 1 && digit2 == 7)
				S17 <= S17 - 1'b1;
			else if (digit1 == 1 && digit2 == 8)
				S18 <= S18 - 1'b1;
			else if (digit1 == 1 && digit2 == 9)
				S19 <= S19 - 1'b1;
		end
		else if (current_state == GET_CODE || current_state == DISPLAY) begin		// start the counter on specific states
			counter_on <= 1'b1;
		end
		else
			counter_on <= 1'b0;																	// otherwise reset counter
	 end
	 
	 always @ (posedge CLK) begin		// always block for counting clk cyclesfe
		if (counter_on == 1'b1)
			counter <= counter + 1'b1;
		else
			counter <= 3'b000;
	 end
	 
	 // always block to decide next_state : combinational- triggered by state/input
	 always @ (*) begin
		case (current_state)
			RST : begin
				next_state = IDLE;
			end
			RE_LOAD : begin
				next_state = IDLE;
			end
			IDLE : begin
				if (RELOAD)
					next_state = RE_LOAD;
				else if (CARD_IN)
					next_state = GET_CODE;		
				else
					next_state = IDLE;
			end
			GET_CODE : begin
				if (counter > 3'b101)				// if the counter counts more than 5 clock cycles, return to IDLE state
					next_state = IDLE;
				else if (KEY_PRESS && digit_count == 2'b10) begin		// read the second digit in
					digit2 = ITEM_CODE;
					digit_count = 2'b00;
					next_state = CHECK_VALID;
				end
				else if (KEY_PRESS && digit_count == 2'b00) begin		// read the first digit in
					digit1 = ITEM_CODE;
					digit_count = 2'b01;
					counter <= 3'b000;
				end
				else if (KEY_PRESS == 0 && digit_count == 2'b01)
					digit_count = 2'b10;
			end
			CHECK_VALID : begin
				if ((digit1 != 0 && digit1 != 1) || digit2 > 9)			// check if the inputted digit is between 00 and 19
					next_state = INVALID;
				else begin															// check if the selected item has pieces remaining
					if ((digit1 == 0 && digit2 == 0 && S0 > 0) ||
						 (digit1 == 0 && digit2 == 1 && S1 > 0) ||
						 (digit1 == 0 && digit2 == 2 && S2 > 0) ||
						 (digit1 == 0 && digit2 == 3 && S3 > 0) ||
						 (digit1 == 0 && digit2 == 4 && S4 > 0) ||
						 (digit1 == 0 && digit2 == 5 && S5 > 0) ||
						 (digit1 == 0 && digit2 == 6 && S6 > 0) ||
						 (digit1 == 0 && digit2 == 7 && S7 > 0) ||
						 (digit1 == 0 && digit2 == 8 && S8 > 0) ||
						 (digit1 == 0 && digit2 == 9 && S9 > 0) ||
						 (digit1 == 1 && digit2 == 0 && S10 > 0) ||
						 (digit1 == 1 && digit2 == 1 && S11 > 0) ||
						 (digit1 == 1 && digit2 == 2 && S12 > 0) ||
						 (digit1 == 1 && digit2 == 3 && S13 > 0) ||
						 (digit1 == 1 && digit2 == 4 && S14 > 0) ||
						 (digit1 == 1 && digit2 == 5 && S15 > 0) ||
						 (digit1 == 1 && digit2 == 6 && S16 > 0) ||
						 (digit1 == 1 && digit2 == 7 && S17 > 0) ||
						 (digit1 == 1 && digit2 == 8 && S18 > 0) ||
						 (digit1 == 1 && digit2 == 9 && S19 > 0))
						next_state = DISPLAY;
					else
						next_state = INVALID;
				end
			end
			INVALID : begin
				next_state = IDLE;
			end
			DISPLAY : begin
				if (counter > 3'b101)						// if counter counts past 5 clk cycles, go to FAILED state
					next_state = FAILED;
				else if (VALID_TRAN == 1'b1)
					next_state = VEND_ITEM;
			end
			FAILED : begin
				next_state = IDLE;
			end
			VEND_ITEM : begin
				if (counter > 3'b101)
					next_state = IDLE;
				else if (DOOR_OPEN)
					door_was_open = 1'b1;
				else if (DOOR_OPEN == 1'b0 && door_was_open) begin			// if door was opened and closed, go to IDLE state
					door_was_open = 1'b0;
					next_state = IDLE;
				end
			end
		endcase
	 end
	 
	 //always block to decide outputs : triggered by state/inputs
	 always @ (*) begin	
		case(current_state)
			IDLE,
			RE_LOAD,
			RST,
			GET_CODE,
			CHECK_VALID : begin
				VEND = 0;
				INVALID_SEL = 0;
				FAILED_TRAN = 0;
				COST = 3'b000;
			end
			INVALID : begin
				INVALID_SEL = 1;
				VEND = 0;
				FAILED_TRAN = 0;
				COST =3'b00;
			end
			FAILED : begin
				FAILED_TRAN = 1;
				INVALID_SEL = 0;
				VEND = 0;
				COST = 3'b000;
			end
			VEND_ITEM : begin
				VEND = 1;
				INVALID_SEL = 0;
				FAILED_TRAN = 0;
				COST = 3'b000;
			end
			DISPLAY : begin	// determine the cost of the inputted item
				if (digit1 == 0 && digit2 >= 0 && digit2 <= 3)
					COST = 3'b001;
				else if (digit1 == 0 && digit2 >= 4 && digit2 <= 7)
					COST = 3'b010;
				else if (digit1 == 0 && digit2 >= 8 && digit2 <=9)
					COST = 3'b011;
				else if (digit1 == 1 && (digit2 == 0 || digit2 == 1))
					COST = 3'b011;
				else if (digit1 == 1 && digit2 >= 2 && digit2 <= 5)
					COST = 3'b100;
				else if (digit1 == 1 && (digit2 == 6 || digit2 == 7))
					COST = 3'b101;
				else if (digit1 == 1 && (digit2 == 8 || digit2 == 9))
					COST = 3'b110;
				INVALID_SEL = 0;
				FAILED_TRAN = 0;
				VEND = 0;
			end
		endcase
	 end
	 
endmodule
