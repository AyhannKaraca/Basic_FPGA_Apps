`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2025 05:17:50
// Design Name: 
// Module Name: timer_expiry
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


module timer_expiry#(
	parameter int c_clk_freq = 100_000_000, //10ns
	parameter int c_tim_freq = 100,
	localparam int c_timerlim = c_clk_freq/c_tim_freq //10ns*1_000_000 = 10ms
)(
	input  logic clk_i			,
	input  logic rst_i			,
	output logic incr_o 		
  );
  
  logic [31:0] timer;  
  logic [31:0] timer_d;

  assign incr_o = (timer==c_timerlim-1);
  
  assign timer_d = (incr_o) ? '0 : timer + 32'b1; 
  
  
  always_ff @ (posedge clk_i or posedge rst_i) begin : UPDATE_TIMER
	if(rst_i)begin
		timer <= '0;
	end else begin
		timer <= timer_d;
	end
   end
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
	endmodule
