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
// 2018/5/2    NingHeChuan       1.0                     Original
//  
// *********************************************************************************

module TB_Uart_Pic_Sdram_VGA;

reg                   clk_24M;
reg                   rst_n;

wire                    lcd_hs;         //行同步信号
wire                    lcd_vs;         //场同步信号
wire                    lcd_blank;
wire                    lcd_dclk;  	//lcd pixel clock
wire      [15:0]              lcd_data;

//UART_Byte_Tx ports	
reg 			mclk;
//reg 			rst_n;	
reg 			send_en;//时钟分频使能	
wire 	[3:0] 	baud_set = 0;//选择波特率	
reg 	[7:0] 	data_byte;//需要发送的信号	
//wire	 	 	uart_state;//串口状态	
wire	 	 	tx_done;//标志串口结束信号	
wire	 	 	rs232_tx;//串口信号输出


//-------------------------------------------------------
//SDRAM signal
wire            sdram_clk;
wire            sdram_cke;
wire            sdram_cs_n;
wire            sdram_ras_n;
wire            sdram_cas_n;
wire            sdram_we_n;
wire    [1:0]   sdram_bank;
wire    [11:0]  sdram_addr;
wire    [15:0]  sdram_data;
wire    [1:0]   sdram_dqm;

Uart_Pic_Sdram_VGA Uart_Pic_Sdram_VGA_inst(
    .clk_24M            (clk_24M    ),
    .rst_n              (rst_n      ),
    .rs232_rx           (rs232_tx   ),
    .sdram_clk          (sdram_clk  ),
    .sdram_cke          (sdram_cke  ),
    .sdram_cs_n         (sdram_cs_n ),
    .sdram_ras_n        (sdram_ras_n),
    .sdram_cas_n        (sdram_cas_n),
    .sdram_we_n         (sdram_we_n ),
    .sdram_bank         (sdram_bank ),
    .sdram_addr         (sdram_addr ),
    .sdram_data         (sdram_data ),
    .sdram_dqm          (sdram_dqm  ),
    .lcd_hs             (lcd_hs     ),         //行同步信号
	.lcd_vs             (lcd_vs     ),         //场同步信号
    .lcd_blank          (lcd_blank  ),
    .lcd_dclk           (lcd_dclk   ),   	//lcd pixel clock
    .lcd_data           (lcd_data   )
);

defparam    sdram_model_plus_inst.addr_bits = 12;
defparam    sdram_model_plus_inst.data_bits = 16;
defparam    sdram_model_plus_inst.col_bits  = 8;
defparam    sdram_model_plus_inst.mem_sizes = 1048576 - 1;   //1M
    

sdram_model_plus sdram_model_plus_inst(
    .Dq                     (sdram_data), 
    .Addr                   (sdram_addr), 
    .Ba                     (sdram_bank), 
    .Clk                    (sdram_clk),    
    .Cke                    (sdram_cke), 
    .Cs_n                   (sdram_cs_n), 
    .Ras_n                  (sdram_ras_n),
    .Cas_n                  (sdram_cas_n), 
    .We_n                   (sdram_we_n), 
    .Dqm                    (sdram_dqm),
    .Debug                  (1'b1)      //仿真模型在调试模式下把debug定义为1
);


//UART_Byte_Tx
UART_Byte_Tx uut_UART_Byte_Tx(
	.mclk					(mclk),
	.rst_n					(rst_n),	
	.send_en				(send_en),//时钟分频使能	
	.baud_set				(baud_set),//选择波特率	
	.data_byte				(data_byte),//需要发送的信号	
	.uart_state				(),//串口状态	
	.tx_done				(tx_done),//标志串口结束信号	
	.rs232_tx				(rs232_tx)//串口信号输出   
 );

always #10 mclk = ~mclk;
always #20 clk_24M = ~clk_24M;

integer i; 

initial begin
	clk_24M = 0;
	mclk = 0;
	rst_n = 0;
	send_en = 0;
	data_byte = 0;

#100; rst_n = 1'b1;
#210000
	send_en = 1;
	for(i = 1; i <= 512; i = i + 1)begin
		#7040 data_byte = i;
	end

end


endmodule
