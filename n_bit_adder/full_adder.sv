`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.03.2025 20:47:52
// Design Name: 
// Module Name: full_adder
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


module full_adder(
	input  logic a_i,
	input  logic b_i,
	input  logic c_i,
	output logic c_o,
	output logic sum_o
    );
	
	logic c1;
	logic c2;
	logic s;
	
	half_adder half_adder_Inst1(
		.a_i  (a_i),
		.b_i  (b_i),
		.sum_o(s),
		.c_o  (c1)
	);
	
	half_adder half_adder_Inst2(
		.a_i  (s),
		.b_i  (c_i),
		.sum_o(sum_o),
		.c_o  (c2)
	);
	
	assign c_o = c1 | c2;
	
endmodule
