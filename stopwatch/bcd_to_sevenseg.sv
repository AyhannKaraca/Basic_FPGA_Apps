`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2025 02:14:07
// Design Name: 
// Module Name: bcd_to_sevenseg
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module bcd_to_sevenseg(
	input logic 		is_dp_on_i	,
	input logic [3:0] 	decimal_i	,
	output logic [6:0] 	bcd_o		,
	output logic 		dp_o
    );
	
	assign dp_o = (is_dp_on_i) ? 1'b0 : 1'b1;
	
	always_comb begin
		case(decimal_i)
			4'd0: 	 bcd_o = 7'b1000000; 
			4'd1: 	 bcd_o = 7'b1111001; 
			4'd2: 	 bcd_o = 7'b0100100; 
			4'd3: 	 bcd_o = 7'b0110000; 
			4'd4: 	 bcd_o = 7'b0011001; 
			4'd5: 	 bcd_o = 7'b0010010; 
			4'd6: 	 bcd_o = 7'b0000010; 
			4'd7: 	 bcd_o = 7'b1111000; 	 
			4'd8: 	 bcd_o = 7'b0000000; 	
			4'd9: 	 bcd_o = 7'b0010000; 
			default: bcd_o = 7'b1111111;
		endcase
	end

endmodule
