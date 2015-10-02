`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:16:22 08/23/2015 
// Design Name: 
// Module Name:    fsm 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
`define STAT_DEF 2'b00
`define STAT_COUNT 2'b01
`define STAT_PAUSE 2'b10
`define ENABLED 1
`define DISABLED 0
module fsm(
count_enable, // if counter is enabled
in, //input control
clk, // global clock signal
state,
rst_n // low active reset
);
// outputs
output count_enable; // if counter is enabled
output [1:0]state;
// inputs
input clk; // global clock signal
input rst_n; // low active reset
input in; //input control
reg count_enable; // if counter is enabled
reg [1:0]state; // state of FSM
reg [1:0]next_state; // next state of FSM

// FSM state decision
always @(*)
	case (state)
		`STAT_DEF:
		if (in)
		begin
			next_state = `STAT_COUNT;
			count_enable = 1'd1;
		end
		else
		begin
			next_state = `STAT_DEF;
			count_enable = 1'd0;
		end
		`STAT_COUNT:
		if (in)
		begin
			next_state = `STAT_PAUSE;
			count_enable = 1'd0;
		end
		else
		begin
			next_state = `STAT_COUNT;
			count_enable = 1'd1;
		end
		`STAT_PAUSE:
		if (in)
		begin
			next_state = `STAT_COUNT;
			count_enable = 1'd1;
		end
		else
		begin
			next_state = `STAT_PAUSE;
			count_enable = 1'd0;
		end
		default:
		begin
			next_state = `STAT_DEF;
			count_enable = 1'd0;
		end
	endcase
	
// FSM state transition
always @(posedge clk or negedge rst_n)
	if (~rst_n)
		state <= `STAT_DEF;
	else
		state <= next_state;
		
endmodule
