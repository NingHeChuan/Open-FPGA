`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: NingHeChuan
// 
// Create Date:    15:47:10 11/25/2016 
// Design Name: 
// Module Name:    UART_Byte_Tx 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Uart_Byte_Tx(
	input 				clk,//50Mhz
	input 				rst_n,
	//input 				send_en,//时钟分频使能
	input 		[3:0]	baud_set,//选择波特率
	input 		[7:0] 	data_byte,//需要发送的信号
	output 	reg 		uart_state,//串口状态
	output	reg 		tx_done,//标志串口结束信号
	output 	reg 		rs232_tx,//串口信号输出
    //rfifo
    input               rfifo_empty,
    output  reg         rfifo_rd_en
    //input       [7:0]   rfifo_rd_data
    );

reg         send_en;
reg [15:0] 	bps_DR;//各波特率的计数值	 
reg 		bps_clk;//bps时钟
reg [15:0] 	div_cnt;//分频计数器
reg [3:0] 	bps_cnt;//bps计数器
reg [7:0] 	r_data_byte;//生成要发送的信号寄存器使得发送信号可控制
parameter START_BIT = 0,//发送起始信号位0
				STOP_BIT = 1;//发送结束信号为1
//-------------------------------------------------------
//rfifo_rd_en
always  @(posedge clk or negedge rst_n)begin
    if(rst_n == 1'b0)
        rfifo_rd_en <= 1'b0;
    else if(rfifo_empty == 1'b0 && send_en == 1'b0)
        rfifo_rd_en <= 1'b1;
    else 
        rfifo_rd_en <= 1'b0;
end
//-------------------------------------------------------
//send_en
always  @(posedge clk or negedge rst_n)begin
    if(rst_n == 1'b0)
        send_en <= 1'b0;
    else if(tx_done == 1'b1)
        send_en <= 1'b0;
    else if(rfifo_empty == 1'b0)
        send_en <= 1'b1;
    else 
        send_en <= send_en;
end

//DR_LUT
always @(posedge clk or negedge rst_n)begin
	if(!rst_n)
		bps_DR <= 16'b0;	
	else begin
		case(baud_set)
		//0: bps_DR <= 5207;//bps_9600
		0: bps_DR <= 31;//bps_9600 just test
		1: bps_DR <= 2603;//bps_19200
		2: bps_DR <= 1302;//bps_38400
		3: bps_DR <= 867;//bps_57600
		4: bps_DR <= 432;//bps_115200
		default: bps_DR <= 5207;//bps_9600
		endcase
	end
end

//分频bps_clk
always @(posedge clk, negedge rst_n)begin
	if(!rst_n)begin
		bps_clk <= 1'b0;
		div_cnt <= 1'b0;
	end
	else if(uart_state)begin
		if(div_cnt == bps_DR)begin
			bps_clk <= 1;
			div_cnt <= 0;
		end
		else begin
			bps_clk <= 0;
			div_cnt <= div_cnt + 1;
		end
	end
end

//bps_cnt
always @(posedge clk or negedge rst_n) begin
	if(!rst_n)
		bps_cnt <= 0;
	else if(tx_done)
		bps_cnt <= 0;
	else begin
		if (bps_cnt == 11)
			bps_cnt <= 0;
		else if(bps_clk)
			bps_cnt <= bps_cnt + 1;
		else 
			bps_cnt <= bps_cnt;
	end
end

//要发送信号的寄存器，保证给予的信号稳定
always @(posedge clk or negedge rst_n)begin
	if(!rst_n)
		r_data_byte <= 8'b0;
	else if(send_en == 1)
		r_data_byte <= data_byte;
end

//选择发送的数据
always @(posedge clk or negedge rst_n)begin
	if(!rst_n)
		rs232_tx <= 0;
	else begin
		case(bps_cnt)
		0:rs232_tx <= 1;//串口状态在其他情况都是默认为1的
		1:rs232_tx <= START_BIT;
		2:rs232_tx <= r_data_byte[0];
		3:rs232_tx <= r_data_byte[1];
		4:rs232_tx <= r_data_byte[2];
		5:rs232_tx <= r_data_byte[3];
		6:rs232_tx <= r_data_byte[4];
		7:rs232_tx <= r_data_byte[5];
		8:rs232_tx <= r_data_byte[6];
		9:rs232_tx <= r_data_byte[7];
		10:rs232_tx <= STOP_BIT;
		default:rs232_tx <= 1;
		endcase
	end
end

//结束信号tx_done
always @(posedge clk or negedge rst_n)begin
	if(!rst_n)
		tx_done <= 0;
	else if(bps_cnt == 11)
		tx_done <= 1;
	else
		tx_done <= 0;
end

//UART_state为1是显示忙，0空闲
always @(posedge clk or negedge rst_n)begin
	if(!rst_n)
		uart_state <= 0;
	else if(tx_done)
		uart_state <= 0;
	else if(send_en)
		uart_state <= 1;
	else 
		uart_state <= uart_state;
end
			
endmodule
