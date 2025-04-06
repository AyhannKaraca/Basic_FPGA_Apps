`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.03.2025 21:15:07
// Design Name: 
// Module Name: n_bit_adder
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


module n_bit_adder#(
    parameter int N = 4 // default 4 bit
)(
	input  logic a_i[N-1:0],
	input  logic b_i[N-1:0],
	input  logic c_i,
	output logic res_o[N:0] // N+1 bit	
  );
  
  logic [N:0] c;
  assign c[0] = c_i;
  assign c[N] = res_o[N];
  
  generate for(genvar i = 0; i<N; i++) begin
	 	full_adder full_adder_Inst(
			.a_i  (a_i[i]),
			.b_i  (b_i[i]),
			.c_i  (c[i]),
	        .c_o  (c[i+1]),
	        .sum_o(res_o[i])
		);
	end
  endgenerate

endmodule
