`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.03.2025 02:12:23
// Design Name: 
// Module Name: debounce_tb
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


module debounce_tb();

logic clk;
logic deb_in;
logic deb_out;

debounce DUT(
	.clk_i		(clk),
	.deb_in_i	(deb_in),
	.deb_out_o	(deb_out)
);

initial begin
	clk = 0;
	forever #5 clk = ~clk;
end


initial begin
	deb_in = 0;
	#20us;
	deb_in = 1;
	#850us;
	deb_in = 0;
	#150us;
	deb_in = 1;
	#1200us;
	deb_in = 0;
	#1200us;
	deb_in = 1;
	#500us;
	deb_in = 0;
	#500us;
	deb_in = 1;
	#1500us;
	deb_in = 0;
	#800us;
	deb_in = 1;
	#250us;
	deb_in = 0;
	#1020us;
	deb_in = 0;
	#20us;
	$stop;
end



endmodule
