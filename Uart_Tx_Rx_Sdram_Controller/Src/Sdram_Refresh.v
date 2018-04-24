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
// 2018/4/16    NingHeChuan       1.0                     Original
//  
// *********************************************************************************
`include "Sdram_Para.v"
module Sdram_Refresh
#(  parameter   ADDR_WIDTH  =   12
)
(
    input                   clk,
    input                   rst_n,
    input                   init_end,   //初始化完成标志
    input                   ref_en,
    output      reg [3:0]   sdram_cmd,
    output          [ADDR_WIDTH - 1:0]  ref_addr,
    output      reg         ref_rq,
    output                  ref_end
);
//-------------------------------------------------------
/*
                cs_n    ras_n   cas_n   we_n
CMD_PREGE       0       0       1       0
CMD_A_REF       0       0       0       1
CMD_NOP         0       1       1       1
CMD_MRS         0       0       0       0  

burst length = 4    addr    =   12'b0100_0110_0010
*/

localparam       DELAY_15US      =   10'd750;


reg     [13:0]  cnt_15us;
reg     [2:0]   cnt_cmd;
reg             ref_flag;

//-------------------------------------------------------
//cnt_15us
always @(posedge clk or negedge rst_n)begin
    if(rst_n == 1'b0)
        cnt_15us <= 13'd0;
    else if(cnt_15us == DELAY_15US - 1'b1)
        cnt_15us <= 13'd0;
    else if(init_end == 1'b1)
        cnt_15us <= cnt_15us + 1'b1;
end

always @(posedge clk or negedge rst_n)begin
    if(rst_n == 1'b0) 
        ref_rq <= 1'b0;
    else if(cnt_15us == DELAY_15US - 1'b1)
        ref_rq <= 1'b1;
    else// if(ref_end == 1'b1)
        ref_rq <= 1'b0;
end
//assign  ref_rq = (cnt_15us == DELAY_15US - 1'b1)? 1'b1: 1'b0;

always @(posedge clk or negedge rst_n)begin
    if(rst_n == 1'b0)
        ref_flag <= 1'b0;
    else if(ref_en == 1'b1)
        ref_flag <= 1'b1;
    else if(ref_end == 1'b1)
        ref_flag <= 1'b0;
end

//-------------------------------------------------------
//cnt_cmd
always @(posedge clk or negedge rst_n)begin
    if(rst_n == 1'b0)
        cnt_cmd <= 3'd0;
    else if(ref_end == 1'b1)
        cnt_cmd <= 3'd0;
    else if(ref_flag == 1'b1)
        cnt_cmd <= cnt_cmd + 1'b1;

end

//-------------------------------------------------------
//sdram_cmd
always @(posedge clk or negedge rst_n)begin
    if(rst_n == 1'b0)
        sdram_cmd <= `CMD_NOP;
    else begin
        case(cnt_cmd)
        3'd1 : sdram_cmd <= `CMD_NOP;
        3'd2 : sdram_cmd <= `CMD_A_REF;
        3'd3 : sdram_cmd <= `CMD_NOP;
        3'd4 : sdram_cmd <= `CMD_NOP;
        3'd5 : sdram_cmd <= `CMD_NOP;
        3'd6 : sdram_cmd <= `CMD_NOP;
        default: sdram_cmd <= `CMD_NOP;
        endcase
    end
end

assign  ref_end = (cnt_cmd > 3'd6)? 1'b1: 1'b0;
assign  ref_addr = 12'b0100_0000_0000;







endmodule
