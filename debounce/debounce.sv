`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.03.2025 15:58:14
// Design Name: 
// Module Name: debounce
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


typedef enum logic [2:0] {S_INIT, S_ZERO, S_ZERO_TO_ONE, S_ONE, S_ONE_TO_ZERO} states_t;

module debounce#
(
	parameter int c_clk_freq = 100_000_000, 	//10ns
	parameter int c_deb_freq = 1000, 			// 100_000_000/1000 = 100_000 * 10ns = 1_000_000ns = 1ms
	parameter bit c_initval = 0,
	localparam int c_timerlim = c_clk_freq/c_deb_freq
)(
	input logic  clk_i		,
	input logic  deb_in_i	,
	output logic deb_out_o
  );
  
  states_t state = S_INIT;
  states_t next_state = S_INIT;
  
  logic timer_exp;
  logic [31:0] timer;
  logic [31:0] timer_d;
  
  assign timer_d = state inside {S_ZERO,S_ONE} 					? '0:
					(state == S_INIT) 			&& (timer_exp) 	? '0:
					(state == S_ZERO_TO_ONE) 	&& (timer_exp) 	? '0:
					(state == S_ONE_TO_ZERO) 	&& (timer_exp) 	? '0:
														timer + 32'b1;
	
	
	
  assign timer_exp = (timer == c_timerlim-1);
  
  
  always_comb begin : STATE_UPDATE
  case(state)
	S_INIT			: next_state = (c_initval)				? S_ONE		   	: S_ZERO;																	
	S_ZERO			: next_state = (deb_in_i) 				? S_ZERO_TO_ONE	: S_ZERO;
	S_ZERO_TO_ONE	: next_state = (deb_in_i && !timer_exp) ? S_ZERO_TO_ONE	:
								   (deb_in_i && timer_exp)	? S_ONE 		: S_ZERO;
	S_ONE			: next_state = (!deb_in_i)				? S_ONE_TO_ZERO	: S_ONE;
	S_ONE_TO_ZERO	: next_state = (!deb_in_i && !timer_exp)? S_ONE_TO_ZERO :
								   (!deb_in_i && timer_exp) ? S_ZERO 		: S_ONE;
	default			: next_state = 							  S_INIT;	
  endcase
  end
  
  always_ff @(posedge clk_i) begin : STATE_UPDATE_FF
	state <= next_state;
  end
  
  always_ff @(posedge clk_i) begin : TIMER_UPDATE
	timer <= timer_d;
  end
  
  always_comb begin : OUTPUT_UPDATE
	case(state)
	S_INIT			: deb_out_o = c_initval;
	S_ZERO			: deb_out_o = 0;
	S_ZERO_TO_ONE	: deb_out_o = 0;
	S_ONE			: deb_out_o = 1;
	S_ONE_TO_ZERO	: deb_out_o = 1;
	default			: deb_out_o = c_initval;
  endcase
  end
  
endmodule
