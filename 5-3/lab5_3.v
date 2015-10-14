`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:50:47 08/24/2015 
// Design Name: 
// Module Name:    lab5_3 
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
module lab5_3(
	input clk,
	input rst_n,
	input in,
	input time_ctrl,
	output [3:0] ftsd_ctl,
	output [14:0] display,
	output [1:0]state,
	output [15:0]led,
	output enable_1,enable
	);

	wire [3:0] bcd;
	wire [1:0] clk_ctl;
	wire [3:0] ina,inb,inc,ind;
	wire clk_out;
	wire rst_out;
	wire cnt_h;
	//reset
	wire enable;
	wire pb_debounced;
	wire out_pulse;
	//mode
	wire enable_1;
	wire pb_debounced_1;
	wire out_pulse_1;
	
	
	
	
freq_div f1(
.clk_ctl(clk_ctl), // divided clock output
.clk(clk), // global clock input
.rst_n(1'b1), // active low reset
.cnt_h_out(cnt_h),
.clk_out(clk_out)
	);

bcd2ftsegdec b1( 
.display(display), // 14-segment display output
.bcd(bcd) // BCD input
	);

scan_ctl s1(
.ftsd_ctl(ftsd_ctl), // ftsd display control signal 
.ftsd_in(bcd), // output to ftsd display
.in0(ina), // 1st input
.in1(inb), // 2nd input
.in2(inc), // 3rd input
.in3(ind), // 4th input
.ftsd_ctl_en(clk_ctl) // divided clock for scan control
	);
	
dcounter a1(
.time_ctrl(enable_1),
.clk(clk_out),
.rst_n(rst_out),
.led(led),
.start(enable),
.ina(ina),
.inb(inb),
.inc(inc),
.ind(ind)
	);

	
fsm c1(
.count_enable(enable), // if counter is enabled
.in(out_pulse), //input control
.clk(clk), // global clock signal
.state(state),
.rst_n(rst_out) // low active reset
);

debounce_circuit d1(
.clk(cnt_h), // clock control
.rst_n(1'b1), // reset
.pb_in(in), //push button input
.pb_debounced(pb_debounced) // debounced push button output
);

one_pulse o1(
.clk(clk), // clock input
.rst_n(rst_out), //active low reset
.in_trig(pb_debounced), // input trigger
.out_pulse(out_pulse) // output one pulse
);

reset_out r1(
.clk(clk_out), // clock input
.rst_n(1'b1), //active low reset
.in_trig(pb_debounced), // input trigger
.out_pulse(rst_out) // output one pulse
    );
	 
	 
//****************************mode**************************
debounce_circuit mode_d1(
.clk(cnt_h), // clock control
.rst_n(1'b1), // reset
.pb_in(time_ctrl), //push button input
.pb_debounced(pb_debounced_1) // debounced push button output
);

one_pulse mode_o1(
.clk(clk), // clock input
.rst_n(rst_out), //active low reset
.in_trig(pb_debounced_1), // input trigger
.out_pulse(out_pulse_1) // output one pulse
);

fsm mode_c1(
.count_enable(enable_1), // if counter is enabled
.in(out_pulse_1), //input control
.clk(clk), // global clock signal
.state(state_1),
.rst_n(1'b1) // low active reset
);






endmodule
