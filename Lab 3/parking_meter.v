`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UZLA
// Engineer: Ryan Riahi
// 
// Create Date:    21:00:09 11/26/2020 
// Design Name: 
// Module Name:    parking_meter 
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
module parking_meter(add1, add2, add3, add4, rst1, rst2, rst, clk, led_seg, val1, val2, val3, val4);
	input add1, add2, add3, add4, rst1, rst2, rst, clk;
	output reg [3:0] val1;
	output reg [3:0] val2;
	output reg [3:0] val3;
	output reg [3:0] val4;
	output reg [6:0] led_seg;
	reg [6:0] led_seg1;
	reg [6:0] led_seg2;
	reg [6:0] led_seg3;
	reg [6:0] led_seg4;

	reg [3:0] an;
	reg [13:0] counter;
	reg flash;
	reg [6:0] second;

	always @ (posedge clk or negedge clk) begin
		if (rst) begin		// reset everything to 0
			an <= 4'b0001;
			val1 <= 4'b0000;
			val2 <= 4'b0000;
			val3 <= 4'b0000;
			val4 <= 4'b0000;
			counter <= 14'b00000000000000;
			flash <= 1'b0;
			second <= 7'b0000000;
			led_seg <= 7'b0000000;
		end
		if (rst1) begin		// reset to 16 seconds
			counter <= 14'b00000000010000;
		end
		if (rst2) begin		// reset to 150 seconds
			counter <= 14'b00000010010110;
		end
		if (add1) begin		// add 60 seconds to parking meter
			counter <= counter + 14'b00000000111100;
		end
		if (add2) begin		// add 120 seconds to parking meter
			counter <= counter + 14'b00000001111000;
		end
		if (add3) begin		// add 180 seconds to parking meter
			counter <= counter + 14'b00000010110100;
		end
		if (add4) begin		// add 300 seconds to parking meter
			counter <= counter + 14'b00000100101100;
		end
	end
	
	always @ (posedge clk) begin
		second <= second + 1'b1;
		if (counter == 0) begin			// if counter is at 0, flash with a period of 1 sec and 50% duty cycle
			flash = ~flash;
		end
		else if (counter > 0) begin	// else, countdown the clock and flash at appropriate times
			counter <= counter - 1'b1;
			if (counter < 14'b00000010110100 && counter % 2 == 0) begin
				flash = 1'b1;
			end
			else begin
				flash = ~flash;
			end
		end
		// here we set the values for val, which are the digits in the display
		val4 <= counter % 10;
		val3 <= (counter/10) % 10;
		val2 <= (counter/100) % 10;
		val1 <= (counter/1000) % 10;
	end

	always @ (*) begin	// multiplexer to determine what segments of the led are lit. 1 = on, 0 = off
		case (val4)
			4'b0000: led_seg4 <= 7'b1111110;  // display 0
			4'b0001: led_seg4 <= 7'b0110000;  // display 1
			4'b0010: led_seg4 <= 7'b1101101;  // display 2
			4'b0011: led_seg4 <= 7'b1111001;  // display 3
			4'b0100: led_seg4 <= 7'b0110011;  // display 4
			4'b0101: led_seg4 <= 7'b1011011;  // display 5
			4'b0110: led_seg4 <= 7'b1011111;  // display 6
			4'b0111: led_seg4 <= 7'b1110000;  // display 7
			4'b1000: led_seg4 <= 7'b1111111;  // display 8
			4'b1001: led_seg4 <= 7'b1111011;  // display 9
			default: led_seg4 <= 7'b0000000;  // display nothing
		endcase
	end

	always @ (*) begin	// multiplexer to determine what segments of the led are lit. 1 = on, 0 = off
		case (val3)
			4'b0000: led_seg3 <= 7'b1111110;  // display 0
			4'b0001: led_seg3 <= 7'b0110000;  // display 1
			4'b0010: led_seg3 <= 7'b1101101;  // display 2
			4'b0011: led_seg3 <= 7'b1111001;  // display 3
			4'b0100: led_seg3 <= 7'b0110011;  // display 4
			4'b0101: led_seg3 <= 7'b1011011;  // display 5
			4'b0110: led_seg3 <= 7'b1011111;  // display 6
			4'b0111: led_seg3 <= 7'b1110000;  // display 7
			4'b1000: led_seg3 <= 7'b1111111;  // display 8
			4'b1001: led_seg3 <= 7'b1111011;  // display 9
			default: led_seg3 <= 7'b0000000;  // display nothing
		endcase
	end

	always @ (*) begin	// multiplexer to determine what segments of the led are lit. 1 = on, 0 = off
		case (val2)
			4'b0000: led_seg2 <= 7'b1111110;  // display 0
			4'b0001: led_seg2 <= 7'b0110000;  // display 1
			4'b0010: led_seg2 <= 7'b1101101;  // display 2
			4'b0011: led_seg2 <= 7'b1111001;  // display 3
			4'b0100: led_seg2 <= 7'b0110011;  // display 4
			4'b0101: led_seg2 <= 7'b1011011;  // display 5
			4'b0110: led_seg2 <= 7'b1011111;  // display 6
			4'b0111: led_seg2 <= 7'b1110000;  // display 7
			4'b1000: led_seg2 <= 7'b1111111;  // display 8
			4'b1001: led_seg2 <= 7'b1111011;  // display 9
			default: led_seg2 <= 7'b0000000;  // display nothing
		endcase
	end

	always @ (*) begin	// multiplexer to determine what segments of the led are lit. 1 = on, 0 = off
		case (val1)
			4'b0000: led_seg1 <= 7'b1111110;  // display 0
			4'b0001: led_seg1 <= 7'b0110000;  // display 1
			4'b0010: led_seg1 <= 7'b1101101;  // display 2
			4'b0011: led_seg1 <= 7'b1111001;  // display 3
			4'b0100: led_seg1 <= 7'b0110011;  // display 4
			4'b0101: led_seg1 <= 7'b1011011;  // display 5
			4'b0110: led_seg1 <= 7'b1011111;  // display 6
			4'b0111: led_seg1 <= 7'b1110000;  // display 7
			4'b1000: led_seg1 <= 7'b1111111;  // display 8
			4'b1001: led_seg1 <= 7'b1111011;  // display 9
			default: led_seg1 <= 7'b0000000;  // display nothing
		endcase
	end
	
	always @ (posedge clk or negedge clk) begin		// always block for seven segment display
		if (flash) begin					// only display when flash is on
			if (an[0]) begin
				led_seg <= led_seg4;
			end
			else if (an[1]) begin
				led_seg <= led_seg3;
			end	
			else if (an[2]) begin
				led_seg <= led_seg2;
			end
			else if (an[3]) begin
				led_seg <= led_seg1;
			end
			an <= {an[2:0], an[3]};
		end
		else begin
			led_seg <= 7'b0000000;
		end
	end
endmodule
