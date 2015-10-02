`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:16:41 08/13/2015 
// Design Name: 
// Module Name:    dcounter 
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
module dcounter(
	input time_ctrl,
	input clk,rst_n,start,
	output [3:0]ina,inb,inc,ind,
	output reg [15:0]led
    );
	reg [3:0]min1,min0,sec1,sec0;
	reg [3:0]in3,in2,in1,in0;
	reg [3:0]ina,inb,inc,ind;		

always @(*)begin
		case(time_ctrl)
			/*2'd0:
			begin
					min1<=4'd0;min0<=4'd0;sec1<=4'd1;sec0<=4'd5;
			end
			*/
			1'd0:	
			begin
					min1<=4'd0;min0<=4'd0;sec1<=4'd3;sec0<=4'd0;
			end
					
			1'd1:	
			begin
					min1<=4'd0;min0<=4'd1;sec1<=4'd0;sec0<=4'd0;	
			end
			
			/*2'd3:	
			begin
					min1<=4'd0;min0<=4'd5;sec1<=4'd0;sec0<=4'd0;
			end
			*/								
		endcase
end

		
always @(*)
	begin
			ina<=in3;
			inb<=in2;
			inc<=in1;
			ind<=in0;
	end	
	
always @(posedge clk or negedge rst_n)
begin
	if(~rst_n)begin
	in3<=min1;
	in2<=min0;
	in1<=sec1;
	in0<=sec0;
	end
	else
	begin
		if(start)begin
			if(in3==4'd0 && in2==4'd0 && in1==4'd0 && in0==4'd0)begin
				led<=16'b1111_1111_1111_1111;
			end
			else if(in3==4'd0 && in2==4'd0 && in1==4'd0 && in0!=4'd0)begin
				in0<=ind-4'd1;
				led<=16'b0000_0000_0000_0000;
			end		
			else if(in3==4'd0 && in2==4'd0 && in1!=4'd0 && in0==4'd0)begin
				in0<=4'd9;
				in1<=inc-4'd1;
				led<=16'b0000_0000_0000_0000;
			end		
			else if(in3==4'd0 && in2==4'd0 && in1!=4'd0 && in0!=4'd0)begin
				in0<=ind-4'd1;
				led<=16'b0000_0000_0000_0000;
			end		
			else if(in3==4'd0 && in2!=4'd0 && in1==4'd0 && in0==4'd0)begin
				in2<=inb-4'd1;
				in1<=4'd5;
				in0<=4'd9;
				led<=16'b0000_0000_0000_0000;
			end		
			else if(in3==4'd0 && in2!=4'd0 && in1==4'd0 && in0!=4'd0)begin
				in0<=ind-4'd1;
				led<=16'b0000_0000_0000_0000;
			end		
			else if(in3==4'd0 && in2!=4'd0 && in1!=4'd0 && in0==4'd0)begin
				in0<=4'd9;
				in1<=inc-4'd1;
				led<=16'b0000_0000_0000_0000;
			end
			else if(in3==4'd0 && in2!=4'd0 && in1!=4'd0 && in0!=4'd0)begin
				in0<=ind-4'd1;
				led<=16'b0000_0000_0000_0000;
			end
		   else
		   begin
		   led<=16'b0000_0000_0000_0000;
		   end		
	 end	
	else
	
	    led<=16'b0000_0000_0000_0000;
	
end
end
	
endmodule

