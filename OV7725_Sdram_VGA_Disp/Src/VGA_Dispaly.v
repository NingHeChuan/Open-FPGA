`timescale      1ns/1ps
// *********************************************************************************
// Project Name :       
// Author       : NingHeChuan
// Email        : ninghechuan@foxmail.com
// Blogs        : http://www.cnblogs.com/ninghechuan/
// File Name    : .v
// Module Name  :
// Called By    :
// Abstract     :
//
// CopyRight(c) 2018, NingHeChuan Studio.. 
// All Rights Reserved
//
// *********************************************************************************
// Modification History:
// Date         By              Version                 Change Description
// -----------------------------------------------------------------------
// 2018/5/1    NingHeChuan       1.0                     Original
//  
// *********************************************************************************

`include "Lcd_Para.v"	
module VGA_Dispaly(
	input 					clk,        //25Mhz
	input 					rst_n,		
	input 			[11:0]	lcd_x,
	input 			[11:0]	lcd_y,
    input        	[11:0] 	hcnt,
    input        	[11:0] 	vcnt,
	input 			[15:0]	dina,
    input                   rfifo_rd_ready,
    output                  disp_en,
	output 	     	[15:0] 	lcd_data
    );

assign  disp_en = ((hcnt >= `H_SYNC + `H_BACK - 2 && hcnt < `H_SYNC + `H_BACK + `H_DISP - 2) &&
						(vcnt >= `V_SYNC + `V_BACK  && vcnt < `V_SYNC + `V_BACK + `V_DISP))? 1'b1: 1'b0;


//assign  disp_en =(lcd_x >= `H_START && lcd_x < `H_END && lcd_y >= `V_START && lcd_y < `V_END)?
                  //1'b1: 1'b0;

//assign  lcd_data =(disp_en == 1'b1)? {dina[7:5], dina[7:6], dina[4:2], dina[4:2], dina[1:0], dina[1:0], dina[1]}: 16'b0;

assign  lcd_data =(disp_en == 1'b1)? dina: 16'b0;
/*
always @(posedge clk or negedge rst_n)begin
	if(!rst_n)
		lcd_data <= 16'b0;
	else if(disp_en == 1'b1)
		//lcd_data <= {dina[7:5], 2'b11, dina[4:2], 3'b111, dina[1:0], 3'b111};
		lcd_data <= {dina[7:5], dina[7:6], dina[4:2], dina[4:2], dina[1:0], dina[1:0], dina[1]};
		//lcd_data <= {dina[7:3], dina[7:2], dina[7:3]};
	else
		lcd_data <= 16'b0;
end*/
 
//-----------------------------------------------------------------------
//lcd_data		
/*
always @(posedge clk or negedge rst_n)begin
	if(!rst_n)
		lcd_data <= 16'b0;
	else if(lcd_x > `H_START && lcd_x <= `H_END && lcd_y > `V_START && lcd_y <= `V_END && rfifo_rd_ready == 1'b1)
		//lcd_data <= {dina[7:5], 2'b11, dina[4:2], 3'b111, dina[1:0], 3'b111};
		lcd_data <= {dina[7:5], dina[7:6], dina[4:2], dina[4:2], dina[1:0], dina[1:0], dina[1]};
		//lcd_data <= {dina[7:3], dina[7:2], dina[7:3]};
	else
		lcd_data <= 16'b0;
end
*/
	
endmodule
		
		
		
		
		
	
