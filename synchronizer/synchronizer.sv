`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.03.2025 00:52:24
// Design Name: 
// Module Name: synchronizer
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


module synchronizer#
(
	parameter int SYNC_FF_STAGE = 3
)( 
	input  logic clk_i,
	input  logic in_async_i,
	output logic out_sync_o
    );
	
	logic [SYNC_FF_STAGE-1:0] sync_ff;
	
	always_ff @(posedge clk_i) begin
		sync_ff <= {sync_ff[SYNC_FF_STAGE-2:0], in_async_i};
	end
	
	assign out_sync_o = sync_ff[SYNC_FF_STAGE-1];
	
	
	
	
endmodule
