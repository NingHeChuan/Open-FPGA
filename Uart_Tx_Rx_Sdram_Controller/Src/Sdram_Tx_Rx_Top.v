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
// 2018/4/20    NingHeChuan       1.0                     Original
//  
// *********************************************************************************

module Sdram_Tx_Rx_Top(
    input                   clk_24M,
    //input                   clk_50M,//just test
    input                   rst_n,
    input                   rs232_rx,
    output                  rs232_tx,
    //SDRAM signal
    output                  sdram_clk,
    output                  sdram_cke,
    output                  sdram_cs_n,
    output                  sdram_ras_n,
    output                  sdram_cas_n,
    output                  sdram_we_n,
    output          [1:0]   sdram_bank,
    output          [11:0]  sdram_addr,
    //output           [1:0]   sdram_dqm,//just test
    inout           [15:0]  sdram_data
    
);

//Clk_PLL
wire                clk_50M;

//Uart_Byte_Rx
wire        [3:0]   baud_set_rx = 'd4;
wire        		rx_done;
wire        [7:0] 	data_byte;
//Uart_Byte_Tx
//wire        	    send_en;        //时钟分频使能
//wire        [7:0] 	data_byte;      //需要发送的信号
//wire        		uart_state;     //串口状态
wire        		tx_done;        //标志串口结束信号
wire        [3:0]   baud_set_tx = 'd4;

//Cmd_Decode
wire                wfifo_wr_en;
wire        [7:0]   wfifo_wr_data;

wire                wfifo_rd_en;
wire        [7:0]   wfifo_rd_data;

//
wire                rfifo_wr_en;
wire        [7:0]   rfifo_wr_data;
wire                rfifo_rd_en;
wire        [7:0]   rfifo_rd_data;
wire                rfifo_empty;

//Sdram_Top
wire                sdram_wr_trig;
wire                sdram_rd_trig;

Clk_PLL	Clk_PLL_inst (
	.inclk0 ( clk_24M ),
	.c0 ( clk_50M )
	);

//-------------------------------------------------------
//Uart_Byte_Rx
Uart_Byte_Rx Uart_Byte_Rx_inst(
	.clk                    (clk_50M),//50Mhz
	.rst_n                  (rst_n),
	.baud_set               (baud_set_rx),
	.rs232_rx               (rs232_rx),
	.uart_state             (),
	.rx_done                (rx_done),
	.data_byte              (data_byte)
    );
//-------------------------------------------------------
//Uart_Byte_Tx
Uart_Byte_Tx Uart_Byte_Tx_inst(
	.clk                    (clk_50M),           //50Mhz
	.rst_n                  (rst_n),
	//.send_en                (send_en),           //时钟分频使能
	.baud_set               (baud_set_tx),           //选择波特率
	.data_byte              (rfifo_rd_data),           //需要发送的信号
	.uart_state             (),           //串口状态
	.tx_done                (tx_done),           //标志串口结束信号
	.rs232_tx               (rs232_tx),            //串口信号输出
    .rfifo_empty            (rfifo_empty),
    .rfifo_rd_en            (rfifo_rd_en)
    );

//-------------------------------------------------------
//Cmd_Decode
Cmd_Decode Cmd_Decode_inst(
    .clk                    (clk_50M),
    .rst_n                  (rst_n),
    .rx_done                (rx_done),
    .uart_data              (data_byte),
    .wr_trig                (sdram_wr_trig),
    .rd_trig                (sdram_rd_trig),
    .wfifo_wr_en            (wfifo_wr_en),
    .wfifo_data             (wfifo_wr_data)
);

//-------------------------------------------------------
//wfifo8x16
fifo8x16 wfifo8x16_inst (
	.clock                  ( clk_50M ),
	.data                   ( wfifo_wr_data ),
	.rdreq                  ( wfifo_rd_en ),
	.wrreq                  ( wfifo_wr_en ),
	.empty                  (  ),
	.q                      ( wfifo_rd_data )
	);

//-------------------------------------------------------
//rfifo8x16
fifo8x16 rfifo8x16_inst (
	.clock                  ( clk_50M ),
	.data                   ( rfifo_wr_data ),
	.rdreq                  ( rfifo_rd_en ),
	.wrreq                  ( rfifo_wr_en ),
	.empty                  ( rfifo_empty ),
	.q                      ( rfifo_rd_data )
	);
//-------------------------------------------------------
//Sdram_Top
Sdram_Top Sdram_Top_inst(
    .clk                    (clk_50M),
    .rst_n                  (rst_n),
    .sdram_clk              (sdram_clk),
    .sdram_cke              (sdram_cke),
    .sdram_cs_n             (sdram_cs_n),
    .sdram_ras_n            (sdram_ras_n),
    .sdram_cas_n            (sdram_cas_n),
    .sdram_we_n             (sdram_we_n),
    .sdram_bank             (sdram_bank),
    .sdram_addr             (sdram_addr),
    .sdram_data             (sdram_data),
    .sdram_dqm              (),
    .wr_trig                (sdram_wr_trig),
    .rd_trig                (sdram_rd_trig),
    .wfifo_rd_en            (wfifo_rd_en),
    .wfifo_rd_data          (wfifo_rd_data),
    .rfifo_wr_en            (rfifo_wr_en),
    .rfifo_wr_data          (rfifo_wr_data)
);

endmodule 
