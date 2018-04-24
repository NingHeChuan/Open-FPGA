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
	//input 				send_en,//ʱ�ӷ�Ƶʹ��
	input 		[3:0]	baud_set,//ѡ������
	input 		[7:0] 	data_byte,//��Ҫ���͵��ź�
	output 	reg 		uart_state,//����״̬
	output	reg 		tx_done,//��־���ڽ����ź�
	output 	reg 		rs232_tx,//�����ź����
    //rfifo
    input               rfifo_empty,
    output  reg         rfifo_rd_en
    //input       [7:0]   rfifo_rd_data
    );

reg         send_en;
reg [15:0] 	bps_DR;//�������ʵļ���ֵ	 
reg 		bps_clk;//bpsʱ��
reg [15:0] 	div_cnt;//��Ƶ������
reg [3:0] 	bps_cnt;//bps������
reg [7:0] 	r_data_byte;//����Ҫ���͵��źżĴ���ʹ�÷����źſɿ���
parameter START_BIT = 0,//������ʼ�ź�λ0
				STOP_BIT = 1;//���ͽ����ź�Ϊ1
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

//��Ƶbps_clk
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

//Ҫ�����źŵļĴ�������֤������ź��ȶ�
always @(posedge clk or negedge rst_n)begin
	if(!rst_n)
		r_data_byte <= 8'b0;
	else if(send_en == 1)
		r_data_byte <= data_byte;
end

//ѡ���͵�����
always @(posedge clk or negedge rst_n)begin
	if(!rst_n)
		rs232_tx <= 0;
	else begin
		case(bps_cnt)
		0:rs232_tx <= 1;//����״̬�������������Ĭ��Ϊ1��
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

//�����ź�tx_done
always @(posedge clk or negedge rst_n)begin
	if(!rst_n)
		tx_done <= 0;
	else if(bps_cnt == 11)
		tx_done <= 1;
	else
		tx_done <= 0;
end

//UART_stateΪ1����ʾæ��0����
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
