`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.03.2025 00:40:42
// Design Name: 
// Module Name: adjustable_cnt_top
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


module adjustable_cnt_top#
(
	parameter int CNT_BIT_LENGTH = 8,
	parameter int SYNC_FF_NUM = 3
)(
	input   logic 						clk_i,
	input   logic 						rstn_i, //sw15
	input   logic [2:0] 				sw,
	output  logic [CNT_BIT_LENGTH-1:0] 	LED
  );
	
	logic [2:0] sync_out;
	
	synchronizer #(.SYNC_FF_STAGE(SYNC_FF_NUM)) synchronizer_Inst1(
		.clk_i     (clk_i),
		.in_async_i(sw[0]),
		.out_sync_o(sync_out[0])
	);
	
	synchronizer #(.SYNC_FF_STAGE(SYNC_FF_NUM)) synchronizer_Inst2(
		.clk_i     (clk_i),
		.in_async_i(sw[1]),
		.out_sync_o(sync_out[1])
	);	
	
	synchronizer #(.SYNC_FF_STAGE(SYNC_FF_NUM)) synchronizer_Inst3(
		.clk_i     (clk_i),
		.in_async_i(sw[2]),
		.out_sync_o(sync_out[2])
	);	
	
	
  
	adjustable_cnt #(.CNT_BIT(CNT_BIT_LENGTH)) adjustable_cnt_Inst(
		.clk_i     	(clk_i), //100Mhz // 10ns
		.rstn_i    	(rstn_i),
		.set_speed_i(sync_out),
		.cnt_o  	(LED)
	);
  
endmodule
