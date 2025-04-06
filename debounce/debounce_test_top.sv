`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.03.2025 01:39:39
// Design Name: 
// Module Name: debounce_test_top
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


module debounce_test_top#(
	parameter int c_clk_freq = 100_000_000, 
	parameter int c_deb_freq = 50, 		
	parameter bit c_initval = 0
)
(
	input logic clk_i,
	input logic [1:0] sw_i,
	input logic rst_i, 	//reset counters
	output logic [15:0] LED
);

logic d1;
logic q1;

logic q2;

logic [7:0] cnt_sw0;
logic [7:0] cnt_sw1;



debounce #(
	.c_clk_freq(c_clk_freq),
	.c_deb_freq(c_deb_freq),
	.c_initval (c_initval )
)
debounce_Inst(
	.clk_i		(clk_i),
    .deb_in_i	(sw_i[0]),
    .deb_out_o  (d1)

);



always_ff @ (posedge clk_i) begin
	if(rst_i)begin
		cnt_sw0 <= '0;
		cnt_sw1 <= '0;
	end else begin
		q1 <= d1;
		q2 <= sw_i[1];
		if(d1 && !q1)
			cnt_sw0 <= cnt_sw0 + 1'b1;
		if(sw_i[1] && !q2)
			cnt_sw1 <= cnt_sw1 + 1'b1;
	end
end

assign LED[7:0] = cnt_sw0;
assign LED[15:8] = cnt_sw1;

endmodule
