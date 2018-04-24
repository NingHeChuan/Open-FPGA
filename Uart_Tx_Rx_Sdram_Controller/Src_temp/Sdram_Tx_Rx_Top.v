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
    input                   clk,
    input                   rst_n,
    input                   rs232_rx,
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

);

//Uart_Byte_Rx
wire        [3:0]	baud_set;
wire        		rs232_rx;
wire        		uart_state;
wire        		rx_done;
wire        [7:0] 	data_byte;




//Sdram_Top
wire                wr_trig;
wire                rd_trig;

//-------------------------------------------------------
//Uart_Byte_Rx
Uart_Byte_Rx Uart_Byte_Rx_inst(
	.clk                    (clk),//50Mhz
	.rst_n                  (rst_n),
	.baud_set               ('d4),
	.rs232_rx               (rs232_rx),
	.uart_state             (uart_state),
	.rx_done                (rx_done),
	.data_byte              (data_byte)
    );

fifo8x16 wfifo8x16_inst (
	.clock                  ( clock_sig ),
	.data                   ( data_sig ),
	.rdreq                  ( rdreq_sig ),
	.wrreq                  ( wrreq_sig ),
	.empty                  ( empty_sig ),
	.q                      ( q_sig )
	);

fifo8x16 rfifo8x16_inst (
	.clock                  ( clock_sig ),
	.data                   ( data_sig ),
	.rdreq                  ( rdreq_sig ),
	.wrreq                  ( wrreq_sig ),
	.empty                  ( empty_sig ),
	.q                      ( q_sig )
	);

Sdram_Top Sdram_Top_inst(
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
    input                   rd_trig
);

endmodule 
