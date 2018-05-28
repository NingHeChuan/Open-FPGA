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
// 2018/4/27    NingHeChuan       1.0                     Original
//  
// *********************************************************************************

module Auto_Write_Read
#(
    parameter   WR_RD_DATA     =   'd256
)   
(
    input                   clk,    //
    input                   rst_n,
    //wfifo signal
    input                   wfifo_wclk,
    input                   wfifo_wr_en,
    input           [15:0]  wfifo_wr_data,
    input                   wfifo_rclk,
    input                   wfifo_rd_en,
    output          [15:0]  wfifo_rd_data,
    output       reg        wr_trig,
    //rfifo signal
    input                   rfifo_wclk,
    input                   rfifo_wr_en,
    input           [15:0]  rfifo_wr_data,
    input                   rfifo_rclk,
    input                   rfifo_rd_en,
    output          [15:0]  rfifo_rd_data,
    output                  rd_trig,
    output       reg        rfifo_rd_ready
);

wire        [8:0]   wfifo_wrusedw;
//wire        [8:0]   wfifo_rdusedw;

wire        [8:0]   rfifo_wrusedw;
//wire        [8:0]   rfifo_rdusedw;

reg                 rfifo_wr_valid;
reg                 rd_flag=0;

/*
always @(posedge wfifo_wclk or negedge rst_n)begin
    if(rst_n == 1'b0)
        wr_trig <= 1'b0;
    else if(wfifo_wrusedw > WR_RD_DATA - 1'b1)
        wr_trig <= 1'b1;
    else
        wr_trig <= 1'b0;
        
end

always @(posedge rfifo_wclk or negedge rst_n)begin
    if(rst_n == 1'b0)
        rd_trig_r <= 1'b0;
    else if(rfifo_wrusedw < WR_RD_DATA - 1'b1 && rfifo_wr_valid == 1'b1)
        rd_trig_r <= 1'b1;
    else
        rd_trig_r <= 1'b0;
        
end
*/
reg     rd_trig_r;
reg     rd_trig_r1;
always @(posedge rfifo_wclk or negedge rst_n)begin
    if(rst_n == 1'b0)begin
        wr_trig <= 1'b0;
        rd_trig_r <= 1'b0;
    end
    else if(wfifo_wrusedw > WR_RD_DATA - 1'b1)begin
        wr_trig <= 1'b1;
        rd_trig_r <= 1'b0;
    end
    else if(rfifo_wrusedw < WR_RD_DATA - 1'b1 && rfifo_wr_valid == 1'b1)begin
        rd_trig_r <= 1'b1;
        wr_trig <= 1'b0;
    end
    else begin
        wr_trig <= 0;
        rd_trig_r <= 0;
    end
end



always  @(posedge rfifo_wclk) begin
        rd_trig_r1      <=      rd_trig_r;
    end
assign  rd_trig     =    rd_trig_r & ~rd_trig_r1;

reg     rd_trig_flag;
always  @(posedge rfifo_wclk or negedge rst_n) begin
        if(rst_n == 1'b0)
                rd_trig_flag    <=      1'b0;
        else if(rd_trig == 1'b1)
                rd_trig_flag    <=      1'b1;
end 

always  @(posedge rfifo_wclk or negedge rst_n)begin
    if(rst_n == 1'b0)
        rfifo_wr_valid <= 1'b0;
    else if(wr_trig == 1'b1)
        rfifo_wr_valid <= 1'b1;
    else 
        rfifo_wr_valid <= rfifo_wr_valid;
end

reg     [1:0]   rfifo_wr_en_r;
always @(posedge rfifo_wclk or negedge rst_n)begin
    if(!rst_n)
        rfifo_wr_en_r <= 2'b0;
    else
        rfifo_wr_en_r <= {rfifo_wr_en_r[0], rfifo_wr_en};
end

wire    rfifo_wr_en_nedge  =   ~rfifo_wr_en_r[0] & rfifo_wr_en_r[1];

always  @(posedge rfifo_wclk or negedge rst_n)begin
    if(rst_n == 1'b0)
        rfifo_rd_ready <= 1'b0;
    else if(rd_trig_flag == 1'b1 && rfifo_wrusedw > WR_RD_DATA - 1)
        rfifo_rd_ready <= 1'b1;
    else if(rd_flag == 1'b1)
        rfifo_rd_ready <= 1'b1;
    else 
        rfifo_rd_ready <= rfifo_rd_ready;
end
//-------------------------------------------------------
//
always @(posedge clk)begin
    if(rfifo_rd_ready == 1'b1)
        rd_flag <= 1'b1;
    else
        rd_flag <= rd_flag;
end

 


//-------------------------------------------------------
//wfifo_16x512
dfifo_16x512 wfifo_16x512_inst (
	.data                   ( wfifo_wr_data ),
	.rdclk                  ( wfifo_rclk ),
	.rdreq                  ( wfifo_rd_en ),
	.wrclk                  ( wfifo_wclk ),
	.wrreq                  ( wfifo_wr_en ),
	.q                      ( wfifo_rd_data ),
	.rdusedw                (  ),
	.wrusedw                ( wfifo_wrusedw )
	);

//-------------------------------------------------------
//rfifo_16x512
dfifo_16x512 rfifo_16x512_inst (
	.data                   ( rfifo_wr_data ),
	.rdclk                  ( rfifo_rclk ),
	.rdreq                  ( rfifo_rd_en ),
	.wrclk                  ( rfifo_wclk ),
	.wrreq                  ( rfifo_wr_en ),
	.q                      ( rfifo_rd_data ),
	.rdusedw                (  ),
	.wrusedw                ( rfifo_wrusedw )
	);


endmodule 
