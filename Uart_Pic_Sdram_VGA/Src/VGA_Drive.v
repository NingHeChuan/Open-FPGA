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
module VGA_Drive(
	input 					clk,//25Mhz
	input 					rst_n,
	output 	reg 			lcd_hs,//行同步信号
	output 	reg 			lcd_vs,//场同步信号
    output			        lcd_blank,
    output			        lcd_dclk,   	//lcd pixel clock
	output 			[11:0]	lcd_x,
	output 			[11:0]	lcd_y,
    output     reg 	[11:0] 	hcnt,
    output     reg 	[11:0] 	vcnt


    );				

assign  lcd_blank   =   lcd_hs & lcd_vs;
assign  lcd_dclk    =   ~clk;


reg 			lcd_vsen;//行扫描结束信号，场扫描使能信号
reg 			lcd_vidon;


//行扫描计数
always @(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		hcnt <= 12'b0;
		lcd_vsen <= 1'b0;
	end
	else if(hcnt == `H_TOTAL - 1'b1)begin
		hcnt <= 12'b0;
		lcd_vsen <= 1'b1;
	end
	else begin
		hcnt <= hcnt + 1'b1;
		lcd_vsen <= 1'b0;
	end
end

//产生lcd_hs
always @(*)begin
	if(hcnt < `H_SYNC)
		lcd_hs = 1'b0;
	else 
		lcd_hs = 1'b1;
	end

//场扫描计数
always @(posedge clk or negedge rst_n) begin
	if(!rst_n)
		vcnt <= 12'd0;
	else if(lcd_vsen == 1)begin
		if(vcnt == `V_TOTAL - 1'b1)
			vcnt <= 12'd0;
		else 
			vcnt <= vcnt + 1'b1;
		end
	else 
		vcnt <= vcnt;
	end

//产生lcd_vs信号
always @(*)begin
	if(vcnt < `V_SYNC)
		lcd_vs = 1'b0;
	else 
		lcd_vs = 1'b1;
	end

always @(*)begin
	if(hcnt >= (`H_BACK + `H_SYNC - 1) &&
	hcnt < (`H_BACK + `H_SYNC + `H_DISP - 1) && 
	vcnt >= (`V_BACK + `V_SYNC) &&
	vcnt < (`H_BACK + `V_SYNC + `V_DISP))
		lcd_vidon = 1'b1;
	else 
		lcd_vidon = 1'b0;
	end
			
//LCD显示状态下行、列计数
assign lcd_x 	= lcd_vidon?(hcnt - (`H_BACK + `H_SYNC - 1)):12'b0;
assign lcd_y 	= lcd_vidon?(vcnt - (`V_BACK + `V_SYNC - 1)):12'b0;


endmodule
