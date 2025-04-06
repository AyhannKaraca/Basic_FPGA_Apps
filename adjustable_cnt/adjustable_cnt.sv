`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.03.2025 23:44:36
// Design Name: 
// Module Name: adjustable_cnt
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


module adjustable_cnt#
(
	parameter int CNT_BIT = 8
)(
	input logic clk_i, //100Mhz // 10ns
	input logic rstn_i,
	input logic [2:0] set_speed_i,
	output logic [CNT_BIT-1:0] cnt_o 
    );
	
	
	logic [31:0] timer_lim;
	assign timer_lim =  (set_speed_i == 3'b000) ? 32'd200_000_000 :
						(set_speed_i == 3'b001) ? 32'd100_000_000 :
						(set_speed_i == 3'b010) ? 32'd 50_000_000 :
						(set_speed_i == 3'b011) ? 32'd 25_000_000 :
						(set_speed_i == 3'b100) ? 32'd 12_500_000 :
						(set_speed_i == 3'b101) ? 32'd  5_750_000 :
												  32'd100_000_000 ;	


	logic [31:0] timer;
	logic [31:0] timer_d;
	assign timer = timer_d;
	
	logic [CNT_BIT-1:0] cnt_d;
	assign cnt_o = cnt_d;

	logic timer_exp;
	assign timer_exp = (timer_lim-1 <= timer) ? 1'b1 : 1'b0;

	
	always_ff @(posedge clk_i or negedge rstn_i) begin
		if(!rstn_i) begin
			cnt_d 	<= '0;
			timer_d <= '0;
		end else if(timer_exp) begin
			cnt_d 	<= cnt_o + 1'b1;
			timer_d <= '0;
		end else begin
			timer_d <= timer + 1'b1;
		end
	end
	
	
endmodule
