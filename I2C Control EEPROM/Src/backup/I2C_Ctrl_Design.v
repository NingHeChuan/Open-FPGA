`timescale      1ns/1ps
// *********************************************************************************
// Project Name :       
// Author       : NingHeChuan
// Email        : ninghechuan@foxmail.com
// Blogs        : http://www.cnblogs.com/ninghechuan/
// File Name    : I2C_Design.v
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
// 2018/8/14    NingHeChuan       1.0                     Original
//  
// *********************************************************************************

module I2C_Ctrl_Design(
    input                   clk,
    input                   rst_n,
    input           [23:0]  i2c_config_data,
    input                   i2c_start,
    inout                   i2c_sdat,
    output      reg         i2c_sclk,
    output                  i2c_done,
    output      reg [7:0]   i2c_rd_data  
);

//-------------------------------------------------------
parameter       I2C_IDLE        =   'd0;
parameter       I2C_START       =   'd1;
parameter       I2C_WR_IDADDR   =   'd2;
parameter       I2C_WR_ACK1     =   'd3;
parameter       I2C_WR_REGADDR  =   'd4;
parameter       I2C_WR_ACK2     =   'd5;
parameter       I2C_WR_DATA     =   'd6;
parameter       I2C_WR_ACK3     =   'd7;
parameter       I2C_WR_STOP     =   'd9;
//-------------------------------------------------------
parameter       I2C_RD_IDADDR1  =   'd10;
parameter       I2C_RD_ACK1     =   'd11;
parameter       I2C_RD_REGADDR  =   'd12;
parameter       I2C_RD_ACK2     =   'd13;
parameter       I2C_RD_START    =   'd1;
parameter       I2C_RD_IDADDR2  =   'd10;
parameter       I2C_RD_ACK3     =   'd11;
parameter       I2C_RD_DATA     =   'd17;
parameter       I2C_RD_NPACK    =   'd18;
parameter       I2C_RD_STOP     =   'd19;
//i2c_sclk freq
parameter       I2C_FREQ        =   500;    //50Mhz/100Khz/2 = 250
parameter       TRANSFER        =   125;
parameter       CAPTURE         =   375;

//-------------------------------------------------------
reg     [3:0]   pre_state;
reg     [3:0]   next_state;
//
reg             i2c_sdat_r;
wire            bir_en;
//
wire            transfer_en;
wire            capture_en;
reg     [7:0]   sclk_cnt;
//
reg     [3:0]   tran_cnt;
//
wire    [7:0]   device_addr = i2c_config_data[23:16];
wire    [7:0]   reg_addr    = i2c_config_data[15:8];
wire    [7:0]   wr_data     = i2c_config_data[7:0];

//-------------------------------------------------------
//i2c_sclk
always @(posedge clk or negedge rst_n)begin
    if(rst_n == 1'b0)
        sclk_cnt <= 'd0;
    else if(sclk_cnt == I2C_FREQ - 1'b1)
        sclk_cnt <= 'd0;
    else 
        sclk_cnt <= sclk_cnt + 1'b1;
end

always @(posedge clk or negedge rst_n)begin
    if(rst_n == 1'b0)
        i2c_sclk <= 1'b1;
    else if(sclk_cnt == (I2C_FREQ >> 1) - 1'b1)
        i2c_sclk <= ~i2c_sclk;
    else 
        i2c_sclk <= i2c_sclk;
end
//
assign  transfer_en = (TRANSFER == I2C_FREQ - 1'b1)? 1'b1: 1'b0;
assign  capture_en  = (CAPTURE == I2C_FREQ - 1'b1)? 1'b1: 1'b0;

//-------------------------------------------------------
always @(posedge clk or negedge rst_n)begin
    if(rst_n == 1'b0)
        tran_cnt <= 'd7;
    else if(tran_cnt == 'd0)
        tran_cnt <= 'd7;
    else if(((next_state == I2C_WR_IDADDR || next_state == I2C_WR_REGADDR || next_state == I2C_WR_DATA) && (transfer_en == 1'b1)) || ((next_state == I2C_RD_DATA) && (capture_en == 1'b1))
        tran_cnt <= tran_cnt - 1'b1;
    else 
        tran_cnt <= tran_cnt;
end

//-------------------------------------------------------
//FSM step1
always @(posedge clk or negedge rst_n)begin
    if(rst_n == 1'b0)
        pre_state <= I2C_IDLE;
    else
        pre_state <= next_state;
    end
end

//FSM step2
always @(*)begin
    next_state = I2C_IDLE;
    case(pre_state)
    I2C_IDLE:
        if(i2c_start == 1'b1)
            next_state <= I2C_START;
        else 
            next_state <= I2C_IDLE;
    I2C_START:
        if(transfer_en == 1'b1)
            next_state <= I2C_WR_IDADDR;
        else 
            next_state <= I2C_START;
    I2C_WR_IDADDR:
        if(transfer_en == 1'b1 && tran_cnt == 'd0)
            next_state <= I2C_WR_ACK1;
        else 
            next_state <= I2C_WR_IDADDR;
    I2C_WR_ACK1:
        if(device_addr[0] == 1'b1 && capture_en == 1'b1 && ack1 == 1'b0)
        else if(capture_en == 1'b1 && ack1 == 1'b0)
            next_state <= I2C_WR_REGADDR;
        else 
            next_state <= I2C_START;
    I2C_WR_REGADDR:
        if(transfer_en == 1'b1 && tran_cnt == 'd0)
            next_state <= I2C_WR_ACK2;
        else
            next_state <= I2C_WR_REGADDR;
    I2C_WR_ACK2:
        if(capture_en == 1'b1 && ack2 == 1'b0)
            next_state <= I2C_WR_DATA;
        else 
            next_state <= I2C_START;
    I2C_WR_DATA:
        if(transfer_en == 1'b1 && tran_cnt == 'd0)
            next_state <= I2C_WR_ACK3;
        else 
            next_state <= I2C_WR_DATA;
    I2C_WR_ACK3:
        if(device_addr[0] == 1'b1 && capture_en == 1'b1 && ack3 == 1'b0)
            next_state <= I2C_WR_IDADDR;
        else if(transfer_en == 1'b1 && ack3 == 1'b0)
            next_state <= I2C_STOP;
        else 
            next_state <= I2C_START;
    I2C_RD_DATA:
    I2C_NPACK:
    I2C_STOP:
    default:
    endcase
end

//FSM step3


//-------------------------------------------------------
assign  bir_en = ()? 1'b1: 1'b0;
assign  i2c_sdat = (bir_en == 1'b1)? i2c_sdat_r: 'bz;




endmodule 
