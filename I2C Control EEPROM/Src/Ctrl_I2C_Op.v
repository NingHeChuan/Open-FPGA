`timescale      1ns/1ps
// *********************************************************************************
// Project Name :       
// Author       : NingHeChuan
// Email        : ninghechuan@foxmail.com
// Blogs        : http://www.cnblogs.com/ninghechuan/
// File Name    : Ctrl_I2C_Op.v
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
// 2018/8/19    NingHeChuan       1.0                     Original
//  
// *********************************************************************************

module Ctrl_I2C_Op(
    input                   clk,
    input                   rst_n,
    input                   wr_en,
    input                   rd_en,
    input                   i2c_done,
    output    reg           i2c_start,
    output    reg [31:0]    eeprom_config_data
);

wire    [7:0]   wr_device_addr  = 8'hA0;             //8'hA0写器件地址，8'hA1读器件地址
wire    [7:0]   rd_device_addr  = 8'hA1;  
wire    [7:0]   reg_addr1       = 8'b0000_0000;
wire    [7:0]   reg_addr2       = 8'b0000_0111;
wire    [7:0]   wr_data         = 8'h88;
//
reg     [1:0]   wr_en_r;
reg     [1:0]   rd_en_r;
wire            wr_pose;
wire            rd_pose;


//-------------------------------------------------------
always @(posedge clk or negedge rst_n)begin
    if(rst_n == 1'b0)
        eeprom_config_data <= 'b0;
    else if(wr_en)
        eeprom_config_data <= {wr_device_addr, reg_addr1, reg_addr2, wr_data};
    else if(rd_en)
        eeprom_config_data <= {rd_device_addr, reg_addr1, reg_addr2, wr_data};
    else 
        eeprom_config_data <= eeprom_config_data;
end

//-------------------------------------------------------
//wr_en_r
always @(posedge clk or negedge rst_n)begin
    if(rst_n == 1'b0)begin
        wr_en_r <= 2'b0;
        rd_en_r <= 2'b0;
    end
    else begin
        wr_en_r <= {wr_en_r[0], wr_en};
        rd_en_r <= {rd_en_r[0], rd_en};
    end
end

assign  wr_pose = ~wr_en_r[1] & wr_en_r[0];
assign  rd_pose = ~rd_en_r[1] & rd_en_r[0];


//-------------------------------------------------------
always @(posedge clk or negedge rst_n)begin
    if(rst_n == 1'b0)
        i2c_start <= 1'b0;
    else if(i2c_done == 1'b1)
        i2c_start <= 1'b0;
    else if(wr_pose || rd_pose)
        i2c_start <= 1'b1;
    else 
        i2c_start <= i2c_start;        
end





endmodule
