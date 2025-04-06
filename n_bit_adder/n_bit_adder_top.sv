`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.03.2025 01:47:47
// Design Name: 
// Module Name: n_bit_adder_top
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


module n_bit_adder_top#(
    parameter int BIT = 7
)(
	input   logic sw[BIT+BIT-1:0],
	input   logic btnC,// carry in
	output  logic LED[BIT:0]
  );
  
  n_bit_adder #(.N(BIT)) n_bit_adder_Inst(
	.a_i(sw[BIT-1:0]),
	.b_i(sw[BIT+BIT-1:BIT]),
	.c_i(btnC),
	.res_o(LED[BIT:0])
  );
endmodule
