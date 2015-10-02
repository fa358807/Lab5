`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:05:22 08/23/2015 
// Design Name: 
// Module Name:    downcounter_2d 
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
`define BCD_BIT_WIDTH 4
`define BCD_ZERO 0
`define BCD_THREE 3
`define BCD_FIVE 5
`define BCD_NINE 9
`define ENABLED 1
`define DISABLED 0
`define INCREMENT 1'b1

module downcounter_2d(
digit1, // 2nd digit of the down counter
digit0, // 1st digit of the down counter
clk, // global clock
rst_n, // active low reset
en // enable/disable for stopwatch
);
output [`BCD_BIT_WIDTH-1:0] digit1;
output [`BCD_BIT_WIDTH-1:0] digit0;
input clk; // global clock
input rst_n; // active low reset
input en; // enable/disable for stopwatch
wire br0, br1; // borrow indicator
wire decrease_enable;
assign decrease_enable = en &&
(~((digit0==`BCD_ZERO) &&
(digit1==`BCD_ZERO) &&
(digit2==`BCD_ZERO)));

// 30 sec down counter
downcounter aa0(
.value(digit0), // counter value
.borrow(br0), // borrow indicator for counter to next stage
.clk(clk), // global clock signal
.rst_n(rst_n), // low active reset
.decrease(decrease_enable), // decrease input from previous stage of counter
.init_value(`BCD_ZERO), // initial value for the counter
.limit(`BCD_NINE), // limit for the counter
.en(ctl[0]) // enable/disable of the counter
);

downcounter aa1(
.value(digit1), // counter value
.borrow(br1), // borrow indicator for counter to next stage
.clk(clk), // global clock signal
.rst_n(rst_n), // low active reset
.decrease(br0), // decrease input from previous stage of counter
.init_value(`BCD_THREE), // initial value for the counter
.limit(`BCD_FIVE), // limit for the counter
.en(ctl[1]) // enable/disable of the counter
);
