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
// 2018/4/17    NingHeChuan       1.0                     Original
//  
// *********************************************************************************

`include "Sdram_Para.v"

module Sdram_Write
#(  parameter   DATA_WIDTH  =   16,
    parameter   ADDR_WIDTH  =   12,
    parameter   ROW_DEPTH   =   2,
    parameter   COL_DEPTH   =   256,
    parameter   BURST_LENGTH =   4,       //burst length
    parameter   ACT_DEPTH    =  4,
    parameter   BREAK_PRE   =   4,
    parameter   BURST_WIDTH =   2
)
(
    input                       clk,
    input                       rst_n,
    input                       wr_trig,
    input                       wr_en,
    input                       ref_rq,
    output          reg [3:0]   wr_cmd,
    output          reg [ADDR_WIDTH - 1:0]  wr_addr,
    output                      wr_rq,
    output          reg         wr_end_flag,
    output          reg    [1:0]   wr_bank_addr,
    output              [DATA_WIDTH - 1:0]  wr_data,
    //wfifo
    output                       wfifo_rd_en,
    input               [DATA_WIDTH - 1:0]    wfifo_rd_data

);

//-------------------------------------------------------
reg     [4:0]   break_cnt;

reg     [3:0]   act_cnt;
reg             act_end;

reg             wr_end;
reg             wr_flag;
reg     [5:0]   col_cnt;
reg     [BURST_WIDTH - 1:0]   burst_cnt;
reg     [BURST_WIDTH - 1:0]   burst_cnt_t;

reg             row_end;
wire     [7:0]   col_addr;
reg     [ADDR_WIDTH - 1:0]  row_addr;

//state machine
reg     [4:0]   pre_state;
reg     [4:0]   next_state;

//-------------------------------------------------------
//step 1
always @(posedge clk or negedge rst_n)begin
    if(rst_n == 1'b0)
        pre_state <= `S_IDLE;
    else 
        pre_state <= next_state;
end

//-------------------------------------------------------
//step 2
always @(*)begin
    if(rst_n == 1'b0)
        next_state = `S_IDLE;
    else begin
        case(pre_state)
        `S_IDLE:begin
            if(wr_trig == 1'b1)
                next_state = `S_WREQ;
            else 
                next_state = `S_IDLE;
        end
        `S_WREQ:begin
            if(wr_en == 1'b1)
                next_state = `S_ACTROW;
            else 
                next_state = `S_WREQ;
        end
        `S_ACTROW:begin
            if(act_end == 1'b1)
                next_state = `S_WRITE;
            else 
                next_state = `S_ACTROW;
        end
        `S_WRITE:begin
            if(wr_end == 1'b1)
                next_state = `S_PREGE;
            else if(ref_rq == 1'b1 && burst_cnt_t == BURST_LENGTH - 1'b1 && wr_flag == 1'b1)
                next_state <= `S_PREGE;
            else if(row_end == 1'b1)
                next_state <= `S_PREGE;
            else
                next_state = `S_WRITE;
        end
        `S_PREGE:begin
            if(break_cnt == BREAK_PRE - 1'b1 && ref_rq == 1'b1 && wr_flag == 1'b1)
                next_state = `S_WREQ;
            else if(wr_flag == 1'b1 && wr_end == 1'b0 && ref_rq == 1'b0 && break_cnt == BREAK_PRE - 1'b1)
                next_state = `S_ACTROW;
            else if(break_cnt == BREAK_PRE - 1'b1)
                next_state = `S_IDLE;
        end
        default:
            next_state = `S_IDLE;
        endcase
    end
end
//-------------------------------------------------------
//wr_cmd
always @(posedge clk or negedge rst_n)begin
    if(rst_n == 1'b0)
        wr_cmd <= `CMD_NOP;
    else begin
        case(next_state)
        `S_IDLE: wr_cmd <= `CMD_NOP;
        `S_ACTROW:begin
            if(act_cnt == 0)
                wr_cmd <= `CMD_ACT;
            else
                wr_cmd <= `CMD_NOP;
        end

        `S_WRITE: begin
            if(burst_cnt == 'd0)
                wr_cmd <= `CMD_WRITE;
            else 
                wr_cmd <= `CMD_NOP;
         end
        `S_PREGE:begin
            if(break_cnt == 'd0)
                wr_cmd <= `CMD_PREGE;
            else 
                wr_cmd <= `CMD_NOP;
        end
        default: wr_cmd <= `CMD_NOP;
        endcase
    end
end
//-------------------------------------------------------
//wr_addr
always @(posedge clk or negedge rst_n)begin
    if(rst_n == 1'b0)
        wr_addr <= 12'd0;
    else begin
        case(next_state)
        `S_ACTROW: begin
            if(act_cnt == 'd0)
                wr_addr <= row_addr;
            else
                wr_addr <= 12'b0000_0000_0000;
        end
        `S_WRITE: wr_addr <= {3'b000, col_addr};
        `S_PREGE: wr_addr <= 12'b0100_0000_0000;
        default: wr_addr <= 12'b0000_0000_0000;
        endcase
    end
end
//-------------------------------------------------------
//break_cnt 
always @(posedge clk or negedge rst_n) begin
	if(!rst_n)
		break_cnt <= 'd0;
	else if(next_state == `S_PREGE)
		break_cnt <= break_cnt + 1'b1;
	else 
		break_cnt <= 'd0;
end

//-------------------------------------------------------
//wr_rq
/*always @(posedge clk or negedge rst_n)begin
    if(rst_n == 1'b0)
        wr_rq <= 1'b0;
    else if(pre_state == `S_WREQ)
        wr_rq <= 1'b1;
    else
        wr_rq <= 1'b0;
end*/
assign  wr_rq = (pre_state == `S_WREQ)? 1'b1: 1'b0;

//-------------------------------------------------------
//act_cnt
always @(posedge clk or negedge rst_n)begin
    if(rst_n == 1'b0)
        act_cnt <= 4'd0;
    else if(next_state == `S_ACTROW)
        act_cnt <= act_cnt + 1'b1;
    else
        act_cnt <= 4'd0;
end
//-------------------------------------------------------
//act_end
always @(posedge clk or negedge rst_n)begin
    if(rst_n == 1'b0)
        act_end <= 1'b0;
    else if(act_cnt == ACT_DEPTH - 1'b1)
        act_end <= 1'b1;
    else 
        act_end <= 1'b0;
end


//-------------------------------------------------------
//wr_flag
always @(posedge clk or negedge rst_n)begin
    if(rst_n == 1'b0)
        wr_flag <= 1'b0;
    else if(row_end == 1'b1)
        wr_flag <= 1'b0;
    else if(wr_en == 1'b1)
        wr_flag <= 1'b1;
    else if(col_addr == COL_DEPTH - 1'b1 && row_addr == ROW_DEPTH - 1'b1)
        wr_flag <= 1'b0;
end

//-------------------------------------------------------
always @(posedge clk or negedge rst_n)begin
    if(rst_n == 1'b0)
        burst_cnt <= 2'd0;
    else if(burst_cnt == BURST_LENGTH - 1'b1)
        burst_cnt <= 2'd0;
    else if(next_state == `S_WRITE)
        burst_cnt <= burst_cnt + 1'b1;
    else
        burst_cnt <= burst_cnt;
end

//-------------------------------------------------------
//col_cnt
always @(posedge clk or negedge rst_n)begin
    if(rst_n == 1'b0)
        col_cnt <= 6'd0;
    else if(col_addr == COL_DEPTH - 1'b1)
        col_cnt <= 6'd0;
    else if(burst_cnt == BURST_LENGTH - 1'b1)
        col_cnt <= col_cnt + 1'b1;
    else
        col_cnt <= col_cnt;
end

//assign  col_addr = {col_cnt, burst_cnt};
assign  col_addr = burst_cnt;
//assign  row_end =   (col_addr == COL_DEPTH - 1'b1)? 1'b1: 1'b0;

//-------------------------------------------------------
//row_addr
always @(posedge clk or negedge rst_n)begin
    if(rst_n == 1'b0)
        row_addr <= 12'd0;
    else if(col_addr == COL_DEPTH - 1'b1 && row_addr == ROW_DEPTH - 1'b1)
        row_addr <= 12'd0;
    else if(row_end == 1'b1 && wr_flag == 1'b1)
        row_addr <= row_addr + 1'b1;
    else 
        row_addr <= row_addr;
end

//-------------------------------------------------------
//row_end
always @(posedge clk or negedge rst_n)begin
    if(rst_n == 1'b0)
        row_end <= 1'b0;
    else if(col_addr == COL_DEPTH - 1'b1)
        row_end <= 1'b1;
    else 
        row_end <= 1'b0;
end
//-------------------------------------------------------
//wr_end
always @(posedge clk or negedge rst_n)begin
    if(rst_n == 1'b0)
        wr_end <= 1'b0;
    else if(row_end == 1'b1)
        wr_end <= 1'b1;
    else if(ref_rq == 1'b1 && burst_cnt_t == BURST_LENGTH - 1'b1)
        wr_end <= 1'b1;
    else if(col_addr == COL_DEPTH - 1'b1 && row_addr == ROW_DEPTH - 1'b1)
        wr_end <= 1'b1;
    else
        wr_end <= 1'b0;
end

//-------------------------------------------------------
//wr_end delay 2clk
reg     wr_end_flag_r;
always  @(posedge clk or negedge rst_n)begin
    if(rst_n == 1'b0)begin
        wr_end_flag <= 1'b0;
        wr_end_flag_r <= 1'b0;
    end
    else begin
        wr_end_flag_r <= wr_end;
        wr_end_flag <= wr_end_flag_r;
    end
end

//assign wr_end_flag = wr_end;

//----------------------------------------------------
//burst_cnt delay 2clk
reg    [BURST_WIDTH - 1:0] burst_cnt_r;
always @(posedge clk or negedge rst_n)begin
    if(rst_n == 1'b0)begin
        burst_cnt_t <= 2'b0;
        burst_cnt_r <= 2'b0;
    end
    else begin
        burst_cnt_r <= burst_cnt;
        burst_cnt_t <= burst_cnt_r;
    end

end
/*
always @(*)begin
	case(burst_cnt_t)
		0:		wr_data <= 'd3;
		1:		wr_data <= 'd5;
		2:		wr_data <= 'd7;
		3:		wr_data <= 'd9;
		endcase
end
*/
always  @(posedge clk or negedge rst_n)begin
    if(rst_n == 1'b0)begin
        wr_bank_addr <= 2'b00;
    end
    else if(col_addr == COL_DEPTH - 1'b1 && row_addr == ROW_DEPTH - 1'b1)begin
        wr_bank_addr <= ~wr_bank_addr;
    end
end


//-------------------------------------------------------
assign  wfifo_rd_en =   (pre_state == `S_WRITE)? 1'b1: 1'b0;
assign  wr_data     =   wfifo_rd_data;
//assign  wr_bank_addr = 2'b00;


endmodule
