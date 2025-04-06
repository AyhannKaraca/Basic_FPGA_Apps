`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.03.2025 20:44:33
// Design Name: 
// Module Name: half_adder
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


module half_adder(
	input  logic a_i,
	input  logic b_i,
	output logic sum_o,
	output logic c_o
    );
	
	assign sum_o = a_i ^ b_i;
	assign c_o   = a_i & b_i;
	
endmodule
