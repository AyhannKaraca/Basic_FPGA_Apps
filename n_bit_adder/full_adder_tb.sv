`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.03.2025 20:54:41
// Design Name: 
// Module Name: full_adder_tb
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


module full_adder_tb();

logic a;
logic b;
logic ci;
logic co;
logic s;

full_adder DUT(
	.a_i  (a),
	.b_i  (b),
	.c_i  (ci),
	.c_o  (co),
	.sum_o(s)
);

initial begin
	#10
	a = 1;
	b = 1;
	ci = 1; // s=1 co=1
	#10;
	
	a = 1;
	b = 1;
	ci = 0; // s=0 co=1
	#10;
	
	a = 1; 
	b = 0;
	ci = 0; // s=1 co=0
	#10;
	
	
end



	
endmodule
