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
// 2018/4/29    NingHeChuan       1.0                     Original
//  
// *********************************************************************************

module Uart_Pic_Sdram_VGA(
    input                   clk_24M,
    input                   rst_n,
    input           		rs232_rx,
    //Sdram signal
    output                  sdram_clk,
    output                  sdram_cke,
    output                  sdram_cs_n,
    output                  sdram_ras_n,
    output                  sdram_cas_n,
    output                  sdram_we_n,
    output          [1:0]   sdram_bank,
    output           [11:0] sdram_addr,
    inout           [15:0]  sdram_data,
    //output           [1:0]  sdram_dqm,//just test
    //VGA signal
    output 	 			    lcd_hs,//行同步信号
	output 	     			lcd_vs,//场同步信号
    output			        lcd_blank,
    output			        lcd_dclk,   	//lcd pixel clock
    output 		 	[15:0] 	lcd_data
);


//Clk_Pll
wire            clk_50M;
wire            clk_100M;
wire            clk_25M;
//Uart_Byte_Rx
wire    [3:0]	baud_set = 4'd4;
//wire    [3:0]	baud_set = 4'd0;    //just test
wire    		uart_state;
wire    		rx_done;
wire    [7:0] 	uart_data;
//Sdram_Top
//wfifo signal 
wire            disp_en;
wire            wfifo_wclk = clk_50M;
wire            wfifo_wr_en = rx_done;
wire    [15:0]  wfifo_wr_data = {8'b0000_0000, uart_data};    //rfifo signal
wire            rfifo_rclk = clk_25M;
wire            rfifo_rd_en = disp_en;
wire    [15:0]  rfifo_rd_data;
wire            rfifo_rd_ready;
//VGA_Drive
wire     [11:0]	lcd_x;
wire     [11:0]	lcd_y;
wire    [11:0] 	hcnt;
wire    [11:0] 	vcnt;
//VGA_Dispaly
wire     [7:0]	dina = rfifo_rd_data[7:0];
//-------------------------------------------------------
//Clk_Pll
Clk_Pll	Clk_Pll_inst (
	.inclk0                 ( clk_24M ),//24Mhz
	.c0                     ( clk_100M ),//100Mhz
	.c1                     ( clk_50M ),//50Mhz
	.c2                     ( clk_25M )//25Mhz
	);

//-------------------------------------------------------
//
Uart_Byte_Rx Uart_Byte_Rx_inst(
    .clk                    (clk_50M),//50Mhz
    .rst_n                  (rst_n),
    .baud_set               (baud_set),
    .rs232_rx               (rs232_rx),
    .uart_state             (),
    .rx_done                (rx_done),
    .data_byte              (uart_data)
    );

Sdram_Top Sdram_Top_inst(
    .clk                    (clk_100M),//100Mhz
    .rst_n                  (rst_n),
    .sdram_clk              (sdram_clk),//100Mhz
    .sdram_cke              (sdram_cke),
    .sdram_cs_n             (sdram_cs_n),
    .sdram_ras_n            (sdram_ras_n),
    .sdram_cas_n            (sdram_cas_n),
    .sdram_we_n             (sdram_we_n),
    .sdram_bank             (sdram_bank),
    .sdram_addr             (sdram_addr),
    .sdram_data             (sdram_data),
    .sdram_dqm              (),        //just test
    .wfifo_wclk             (wfifo_wclk),
    .wfifo_wr_en            (wfifo_wr_en),
    .wfifo_wr_data          (wfifo_wr_data),
    .rfifo_rclk             (rfifo_rclk),
    .rfifo_rd_en            (rfifo_rd_en),
    .rfifo_rd_data          (rfifo_rd_data),
    .rfifo_rd_ready         (rfifo_rd_ready)
);
//-------------------------------------------------------
//VGA_Drive
VGA_Drive VGA_Drive_inst(
	.clk                    (clk_25M),//25Mhz
	.rst_n                  (rst_n & rfifo_rd_ready),
	.lcd_hs                 (lcd_hs),//行同步信号
	.lcd_vs                 (lcd_vs),//场同步信号
    .lcd_blank              (lcd_blank),
    .lcd_dclk               (lcd_dclk),
    .hcnt                   (hcnt),
    .vcnt                   (vcnt),
	.lcd_x                  (lcd_x),
	.lcd_y                  (lcd_y)
    );	
//-------------------------------------------------------
//VGA_Dispaly
VGA_Dispaly VGA_Dispaly_inst(
	.clk                    (clk_25M),//25Mhz
	.rst_n                  (rst_n & rfifo_rd_ready), 		
	.lcd_x                  (lcd_x),
	.lcd_y                  (lcd_y),
	.dina                   (dina),
    .rfifo_rd_ready         (rfifo_rd_ready),
    .hcnt                   (hcnt),
    .vcnt                   (vcnt),
    .disp_en                (disp_en),
	.lcd_data               (lcd_data)
);

endmodule
