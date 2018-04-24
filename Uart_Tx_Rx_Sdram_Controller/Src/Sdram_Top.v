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
module Sdram_Top(
    input                   clk,
    input                   rst_n,
    //SDRAM signal
    output                  sdram_clk,
    output                  sdram_cke,
    output                  sdram_cs_n,
    output                  sdram_ras_n,
    output                  sdram_cas_n,
    output                  sdram_we_n,
    output          [1:0]   sdram_bank,
    output      reg [11:0]  sdram_addr,
    inout           [15:0]  sdram_data,
    output           [1:0]   sdram_dqm,
    //
    input                   wr_trig,
    input                   rd_trig,
    //wfifo
    output                       wfifo_rd_en,
    input              [7:0]    wfifo_rd_data,
    output                      rfifo_wr_en,
    output              [7:0]   rfifo_wr_data
);

reg     [3:0]   sdram_cmd;
//state machine
reg     [4:0]   pre_state;
reg     [4:0]   next_state;

//Sdram_Init
wire    [11:0]  init_addr;
wire    [3:0]   init_cmd;
wire            init_end;
//Sdram_Refresh
wire            ref_rq;
reg             ref_en;
wire    [3:0]   ref_cmd;
wire    [11:0]  ref_addr;
wire            ref_end;
//Sdram_Write
wire            wr_rq;
reg             wr_en;
wire    [3:0]   wr_cmd;
wire    [11:0]  wr_addr;
wire            wr_end_flag;
wire    [1:0]   wr_bank_addr;
wire    [15:0]  wr_data;
//Sdram_Read
reg             rd_en;
wire    [3:0]   rd_cmd;
wire    [11:0]  rd_addr;
wire            rd_rq;
wire            rd_end_flag;
wire    [1:0]   rd_bank_addr;
wire    [15:0]  rd_data;

//-------------------------------------------------------
always @(posedge clk or negedge rst_n)begin
    if(rst_n == 1'b0)
        pre_state <= `IDLE;
    else 
        pre_state <= next_state;
end

always @(*)begin
    if(rst_n == 1'b0)
        next_state <= `IDLE;
    else begin
        case(pre_state)
        `IDLE:begin
            if(init_end == 1'b1)
                next_state <= `ARBIT;
            else 
                next_state <= `IDLE;
        end
        `ARBIT:begin
            if(ref_en == 1'b1)
                next_state <= `A_REF;
            else if(wr_en == 1'b1)
                next_state <= `WRITE;
            else if(rd_en == 1'b1)
                next_state <= `READ;
            else
                next_state <= `ARBIT;
        end
        `A_REF:begin
            if(ref_end == 1'b1)
                next_state <= `ARBIT;
            else 
                next_state <= `A_REF;
        end
        `WRITE:begin
            if(wr_end_flag == 1'b1)
                next_state <= `ARBIT;
            else 
                next_state <= `WRITE;
        end
        `READ:begin
            if(rd_end_flag == 1'b1)
                next_state <= `ARBIT;
            else 
                next_state <= `READ;
        end
        default:
            next_state <= `IDLE;
        endcase
    end
end

//-------------------------------------------------------
assign  sdram_cke = 1'b1;
//assign  sdram_addr = (pre_state == IDLE)? init_addr: ref_addr;
assign  {sdram_cs_n, sdram_ras_n, sdram_cas_n, sdram_we_n} = sdram_cmd;
assign  sdram_dqm = 2'b00;
assign  sdram_clk = clk;
assign  sdram_bank = (pre_state == `WRITE)? wr_bank_addr: rd_bank_addr;
assign  sdram_data = (pre_state == `WRITE)? wr_data: 16'bz;

always @(posedge clk or negedge rst_n)begin
    if(rst_n == 1'b0)begin
        sdram_addr <= 12'b0;
        sdram_cmd <= 4'b0111;
    end
    else if(next_state == `IDLE)begin
        sdram_addr <= init_addr;
        sdram_cmd <= init_cmd;
    end
    else if(next_state == `A_REF)begin
        sdram_addr <= ref_addr;
        sdram_cmd <= ref_cmd;
    end
    else if(next_state == `WRITE)begin
        sdram_addr <= wr_addr;
        sdram_cmd <= wr_cmd;
    end
    else if(next_state == `READ)begin
        sdram_addr <= rd_addr;
        sdram_cmd <= rd_cmd;
    end
    else begin
        sdram_addr <= 12'b0;
        sdram_cmd <= 4'b0111;
    end
end
//-------------------------------------------------------
//ref_en
always @(posedge clk or negedge rst_n)begin
    if(rst_n == 1'b0)
        ref_en <= 1'b0;
    else if((next_state == `ARBIT) && (ref_rq == 1'b1))
        ref_en <= 1'b1;
    else 
        ref_en <= 1'b0;
end
//-------------------------------------------------------
//wr_en
always @(posedge clk or negedge rst_n)begin
    if(rst_n == 1'b0)
        wr_en <= 1'b0;
    else if((next_state == `ARBIT) && (wr_rq == 1'b1) && ref_rq == 1'b0)
        wr_en <= 1'b1;
    else 
        wr_en <= 1'b0;
end

//-------------------------------------------------------
//rd_en
always @(posedge clk or negedge rst_n)begin
    if(rst_n == 1'b0)
        rd_en <= 1'b0;
    else if((next_state == `ARBIT) && (rd_rq == 1'b1) && ref_rq == 1'b0 && wr_rq == 1'b0)
        rd_en <= 1'b1;
    else 
        rd_en <= 1'b0;
end

//-------------------------------------------------------
//Sdram_Init
Sdram_Init
#(  .ADDR_WIDTH             ('d12)
)
Sdram_Init_inst(
    .clk                    (clk),
    .rst_n                  (rst_n),
    .sdram_addr             (init_addr),
    .sdram_cmd              (init_cmd),
    .init_end               (init_end)

);
//-------------------------------------------------------
//Sdram_Refresh
Sdram_Refresh 
#(  .ADDR_WIDTH             ('d12)
)
Sdram_Refresh_inst(
    .clk                    (clk),
    .rst_n                  (rst_n),
    .init_end               (init_end),   //初始化完成标志
    .ref_en                 (ref_en),
    .sdram_cmd              (ref_cmd),
    .ref_addr               (ref_addr),
    .ref_rq                 (ref_rq),
    .ref_end                (ref_end)
);
//-------------------------------------------------------
//Sdram_Write
Sdram_Write
#(  .DATA_WIDTH             ('d16),
    .ADDR_WIDTH             ('d12),
    .ROW_DEPTH              ('d1),
    .COL_DEPTH              ('d4),
    .BURST_LENGTH           ('d4),       //burst length
    .ACT_DEPTH              ('d1),
    .BREAK_PRE              ('d1) 
)
Sdram_Write_inst(
    .clk                    (clk),
    .rst_n                  (rst_n),
    .wr_trig                (wr_trig),
    .wr_en                  (wr_en),
    .ref_rq                 (ref_rq),
    .wr_cmd                 (wr_cmd),
    .wr_addr                (wr_addr),
    .wr_rq                  (wr_rq),
    .wr_end_flag            (wr_end_flag),
    .wr_bank_addr           (wr_bank_addr),
    .wr_data                (wr_data),
    .wfifo_rd_en            (wfifo_rd_en),
    .wfifo_rd_data          (wfifo_rd_data)
);
//-------------------------------------------------------
//Sdram_Read
Sdram_Read
#(  .DATA_WIDTH             ('d16),
    .ADDR_WIDTH             ('d12),
    .ROW_DEPTH              ('d1),
    .COL_DEPTH              ('d4),
    .BURST_LENGTH           ('d4),       //burst length
    .ACT_DEPTH              ('d1),
    .BREAK_PRE              ('d1) 
)
Sdram_Read_inst(
    .clk                    (clk),
    .rst_n                  (rst_n),
    .rd_trig                (rd_trig),
    .rd_en                  (rd_en),
    .ref_rq                 (ref_rq),
    .rd_cmd                 (rd_cmd),
    .rd_addr                (rd_addr),
    .rd_rq                  (rd_rq),
    .rd_end_flag            (rd_end_flag),
    .rd_bank_addr           (rd_bank_addr),
    .rd_data                (sdram_data),
    .rfifo_wr_en            (rfifo_wr_en),
    .rfifo_wr_data          (rfifo_wr_data)
);


endmodule 
