`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2025 05:27:10
// Design Name: 
// Module Name: stopwatch_top
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


module stopwatch_top#(
	parameter int c_clk_freq = 100_000_000, //10ns
	localparam int c_ms_freq = 100,
	localparam int c_refresh_rate = 1000,
	localparam int timer_lim = c_clk_freq/c_refresh_rate
)(
	input  logic 		clk_i	,
    input  logic 		rst_i	,
	input  logic 		stop_i	,
	output logic [3:0]	an_o	,
	output logic [6:0]	bcd_o	,
	output logic     	dp_o	,
	output logic     	locked_o,
	output logic     	overflow_o	
  );
  
  
  logic timer_exp_ms;
  logic timer_exp_sec;
  
  logic [3:0] 	seg0;
  logic [3:0] 	seg1;
  logic [3:0] 	seg2;
  logic [3:0] 	seg3; 
  
  logic [6:0] 	bcd0;
  logic [6:0] 	bcd1;
  logic [6:0] 	bcd2;
  logic [6:0] 	bcd3;
  
  logic 	 	dp0;
  logic 	 	dp1;
  logic 	 	dp2;
  logic 	 	dp3; 
  
  logic CLK_200MHZ;
  logic locked;
  assign locked_o = locked;
  
  
  clk_wiz_0 CLK_200MHZ_ip
   (
    // Clock out ports
    .CLK_200MHZ(CLK_200MHZ),     // output CLK_200MHZ
    // Status and control signals
    .reset(rst_i), // input reset
    .locked(locked),       // output locked
   // Clock in ports
    .clk_in1(clk_i)      // input clk_in1
);
  
  
  
  
  
  timer_expiry #(
		.c_clk_freq(c_clk_freq),
		.c_tim_freq(c_ms_freq)
  ) timer_expiry_ms_Inst(
		.clk_i (CLK_200MHZ	),
		.rst_i (rst_i	),
		.incr_o(timer_exp_ms ) 
  );
  
  bcd_incrementor bcd_incrementor_ms_Inst(
		.clk_i	(CLK_200MHZ)	,
        .rst_i	(rst_i)	,
        .stop_i	(stop_i)	,
        .incr_i (timer_exp_ms),
        .seg0	(seg0),
        .seg1	(seg1),  
        .incr_o	(timer_exp_sec)  
  );
  
  
  bcd_incrementor bcd_incrementor_sec_Inst(
		.clk_i	(CLK_200MHZ)	,
        .rst_i	(rst_i)	,
		.stop_i	(stop_i)	,
        .incr_i (timer_exp_sec),
        .seg0	(seg2),
        .seg1	(seg3),	  
		.incr_o	(overflow_o) 
  );
  
  bcd_to_sevenseg bcd_to_sevenseg_ms_Inst1(
		.is_dp_on_i(1'b0),
		.decimal_i (seg0),
		.bcd_o     (bcd0),	
		.dp_o      (dp0)
  );
  
  bcd_to_sevenseg bcd_to_sevenseg_ms_Inst2(
		.is_dp_on_i(1'b0),
		.decimal_i (seg1),
		.bcd_o     (bcd1),	
		.dp_o      (dp1)
  );
  
  bcd_to_sevenseg bcd_to_sevenseg_sec_Inst1(
		.is_dp_on_i(1'b1),
		.decimal_i (seg2),
		.bcd_o     (bcd2),	
		.dp_o      (dp2)
  );
  
  bcd_to_sevenseg bcd_to_sevenseg_sec_Inst2(
		.is_dp_on_i(1'b0),
		.decimal_i (seg3),
		.bcd_o     (bcd3),	
		.dp_o      (dp3)
  );
  
  
  
  logic [31:0] timer;
  logic [31:0] timer_d;
  logic 	   timer_exp;
  logic [1:0]  digits;
  logic [1:0]  digits_d;
  
  assign timer_exp = (timer == timer_lim); 
  assign timer_d = (timer_exp) ? '0 : timer + 32'b1;
  
  assign digits_d = (timer_exp) ? digits + 2'b01: digits + 2'b00;
  
  assign an_o = (digits == 2'b00) ? 4'b1110:
				(digits == 2'b01) ? 4'b1101:
				(digits == 2'b10) ? 4'b1011:
				(digits == 2'b11) ? 4'b0111:
									4'b1111;
									
  assign bcd_o = (digits == 2'b00) ? bcd0:
				 (digits == 2'b01) ? bcd1:
				 (digits == 2'b10) ? bcd2:
				 (digits == 2'b11) ? bcd3:
									 bcd0;
									 
  assign dp_o =  (digits == 2'b00) ? dp0:
				 (digits == 2'b01) ? dp1:
				 (digits == 2'b10) ? dp2:
				 (digits == 2'b11) ? dp3:
									 dp0;										 
  
  
  
  always_ff @(posedge CLK_200MHZ or posedge rst_i)begin : TIMER_UPDATE
	if(rst_i)begin
		timer <= '0;
	end else begin
		timer <= timer_d;
	end
  end
  
  always_ff @(posedge CLK_200MHZ or posedge rst_i)begin : DIGIT_UPDATE
	if(rst_i)begin
		digits <= '0;
	end else begin
		digits <= digits_d;
	end
  end
    
endmodule
