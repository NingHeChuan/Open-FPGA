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

module TB_Cmd_Decode;
    reg                  clk;
    reg                  rst_n;
    reg                  rx_done;
    reg          [7:0]   uart_data;
    wire                  wr_trig;
    wire                  rd_trig;
    wire                  wfifo_wr_en;
    wire          [7:0]   wfifo_data;


Cmd_Decode Cmd_Decode_inst(
    .clk                    (clk),
    .rst_n                  (rst_n),
    .rx_done                (rx_done),
    .uart_data              (uart_data),
    .wr_trig                (wr_trig),
    .rd_trig                (rd_trig),
    .wfifo_wr_en            (wfifo_wr_en),
    .wfifo_data             (wfifo_data)
);

always #10 clk = ~clk;

initial begin
clk = 1'b0;
rst_n = 1'b0;
rx_done = 1'b0;
uart_data = 'h00;
#100

rst_n = 1'b1;
rx_done = 1'b1;
uart_data = 'h55;
#20
rx_done = 1'b0;
#100
rx_done = 1'b1;
uart_data = 'h01;
#20
rx_done = 1'b0;
#100
rx_done = 1'b1;
uart_data = 'h02;
#20
rx_done = 1'b0;
#100
rx_done = 1'b1;
uart_data = 'h03;
#20
rx_done = 1'b0;
#100
rx_done = 1'b1;
uart_data = 'h04;
#20
rx_done = 1'b0;
#100
rx_done = 1'b1;
uart_data = 'haa;
#20
rx_done = 1'b0;

end





endmodule 
