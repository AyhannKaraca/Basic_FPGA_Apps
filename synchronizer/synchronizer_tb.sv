`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.03.2025 16:02:58
// Design Name: 
// Module Name: synchronizer_tb
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


module synchronizer_tb(

    );
	
	logic clk;
	logic async_in;
	logic sync_out;
	
	synchronizer DUT(
		.clk_i		(clk),	
		.in_async_i (async_in),
		.out_sync_o (sync_out)
	);
	
	initial begin
		clk = 0;
		forever #5 clk = ~clk;
	end
	
	initial begin
		async_in = 0;
		#22;
		async_in = 1;
		#12;
		async_in = 0;
		#10;
		async_in = 1;
		#7;
		async_in = 0;
		#11;
		async_in = 1;
		#13;
		async_in = 0;
		#8;
		async_in = 1;
		#6;
		async_in = 0;
		#4;
		async_in = 1;
		#14;
		async_in = 0;
		#13;
		async_in = 1;
		#7;
		async_in = 0;
		#100;
		$stop;
		
	end
endmodule
