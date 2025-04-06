`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2025 03:15:11
// Design Name: 
// Module Name: bcd_incrementor
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


module bcd_incrementor(
	input  logic 		clk_i		,
	input  logic 		rst_i		,
	input  logic 		incr_i		,
	input  logic 		stop_i		,
	output logic [3:0] 	seg0		,
	output logic [3:0] 	seg1		,
	output logic 		incr_o		
  );

  logic [3:0] seg0_cnt; 
  logic [3:0] seg0_cnt_d;
  
  logic seg0_cnt_exp;
  
  logic [3:0] seg1_cnt; 
  logic [3:0] seg1_cnt_d;
  
  
  
  assign seg0_cnt_exp = (seg0_cnt == 4'd9 && incr_i);
  assign incr_o 	  = (seg1_cnt == 4'd9 && seg0_cnt_exp);
  
  assign seg0_cnt_d = (stop_i) 			 			? seg0_cnt + 4'b0: 
					  (seg0_cnt == 4'd9 && incr_i) 	?  4'd0:
					  (incr_i) 			 			? seg0_cnt + 4'b1:
													  seg0_cnt + 4'b0;
 
  
  assign seg1_cnt_d = (stop_i) 										  ? seg1_cnt + 4'b0:
					  (seg1_cnt == 4'd9 && seg0_cnt == 4'd9 && incr_i)? 		   4'd0:
					  (seg0_cnt_exp) 								  ? seg1_cnt + 4'b1:
																	    seg1_cnt + 4'b0;
  
  
  always_ff @ (posedge clk_i or posedge rst_i) begin : UPDATE_SEG0CNT
	if(rst_i)begin
		seg0_cnt <= '0;
	end else begin
		seg0_cnt <= seg0_cnt_d;
	end
   end

  always_ff @ (posedge clk_i or posedge rst_i) begin : UPDATE_SEG1CNT
	if(rst_i)begin
		seg1_cnt <= '0;
	end else begin
		seg1_cnt <= seg1_cnt_d;
	end	
   end
   
   assign seg0 = seg0_cnt;
   assign seg1 = seg1_cnt;
	
endmodule
