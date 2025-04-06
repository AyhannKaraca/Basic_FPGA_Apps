`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2025 04:20:00
// Design Name: 
// Module Name: bcd_incrementor_tb
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


module bcd_incrementor_tb();
	
	logic 		clk_i	;
	logic 		rst_i	;
	logic 		stop_i	;
	logic [3:0]	an_o	;
	logic [6:0]	bcd_o	;
	logic     	dp_o	;
	logic     	overflow_o;

stopwatch_top DUT(

	.clk_i	 (clk_i	),
	.rst_i	 (rst_i	),
	.stop_i	 (stop_i),
	.an_o	 (an_o	),
	.bcd_o	 (bcd_o	),
	.dp_o	 (dp_o	),
	.overflow_o	 (overflow_o)
);

initial begin
	clk_i = 0;
	forever #5 clk_i = ~clk_i;
end

initial begin
	stop_i = 0;
	#1500;
	stop_i = 1;
	#100;
	stop_i = 0;
end

initial begin
rst_i = 1;
#10;
rst_i = 0;
#100000;

$stop;
end

endmodule
