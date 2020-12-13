`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:59:00 12/11/2020
// Design Name:   vending_machine
// Module Name:   /home/ise/Desktop/vending_machine/testbench.v
// Project Name:  vending_machine
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: vending_machine
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
	reg CARD_IN;
	reg VALID_TRAN;
	reg [3:0] ITEM_CODE;
	reg KEY_PRESS;
	reg DOOR_OPEN;
	reg RELOAD;
	reg CLK;
	reg RESET;

	// Outputs
	wire VEND;
	wire INVALID_SEL;
	wire FAILED_TRAN;
	wire [2:0] COST;

	// Instantiate the Unit Under Test (UUT)
	vending_machine uut (
		.CARD_IN(CARD_IN), 
		.VALID_TRAN(VALID_TRAN), 
		.ITEM_CODE(ITEM_CODE), 
		.KEY_PRESS(KEY_PRESS), 
		.DOOR_OPEN(DOOR_OPEN), 
		.RELOAD(RELOAD), 
		.CLK(CLK), 
		.RESET(RESET), 
		.VEND(VEND), 
		.INVALID_SEL(INVALID_SEL), 
		.FAILED_TRAN(FAILED_TRAN), 
		.COST(COST)
	);

	initial begin
		// Initialize Inputs
		CARD_IN = 0;
		VALID_TRAN = 0;
		ITEM_CODE = 0;
		KEY_PRESS = 0;
		DOOR_OPEN = 0;
		RELOAD = 0;
		CLK = 0;
		RESET = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		// Succesful vending of item 17:
		RESET <= 1;
		#20;
		RESET <= 0;
		#20;
		RELOAD <= 1;
		#20;
		RELOAD <= 0;
		#20;
		CARD_IN <= 1;
		#20;
		CARD_IN <= 0;
		#20;
		ITEM_CODE <= 4'b0001;
		KEY_PRESS <= 1;
		#20;
		KEY_PRESS <= 0;
		ITEM_CODE <= 4'b0111;
		#20;
		KEY_PRESS <= 1;
		#20;
		KEY_PRESS <= 0;
		#20;
		VALID_TRAN <= 1;
		#20;
		VALID_TRAN <= 0;
		#20;
		DOOR_OPEN <= 1;
		#20;
		DOOR_OPEN <= 0;
		#100;
		
		// Invalid input into machine:
		CARD_IN <= 1;
		#20;
		CARD_IN <= 0;
		#20;
		ITEM_CODE <= 4'b0010;
		KEY_PRESS <= 1;
		#20;
		KEY_PRESS <= 0;
		ITEM_CODE <= 4'b1111;
		#20;
		KEY_PRESS <= 1;
		#20;
		KEY_PRESS <= 0;
		#20;
		#100;
		
		// Credit card not accepted by machine:	
		CARD_IN <= 1;
		#20;
		CARD_IN <= 0;
		#20;
		ITEM_CODE <= 4'b0000;
		KEY_PRESS <= 1;
		#20;
		KEY_PRESS <= 0;
		ITEM_CODE <= 4'b0001;
		#20;
		KEY_PRESS <= 1;
		#20;
		KEY_PRESS <= 0;
		#20;
		#200;
		
		// Successful vending of item 4 without door opening:
		CARD_IN <= 1;
		#20;
		CARD_IN <= 0;
		#20;
		ITEM_CODE <= 4'b0000;
		KEY_PRESS <= 1;
		#20;
		KEY_PRESS <= 0;
		ITEM_CODE <= 4'b0100;
		#20;
		KEY_PRESS <= 1;
		#20;
		KEY_PRESS <= 0;
		#20;
		VALID_TRAN <= 1;
		#20;
		VALID_TRAN <= 0;
		#20;
	end
	
	always @ (*) begin
		#10;
		CLK <= ~CLK;
	end
      
endmodule
