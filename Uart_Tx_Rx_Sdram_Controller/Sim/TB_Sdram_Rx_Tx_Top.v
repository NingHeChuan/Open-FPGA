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

module TB_Sdram_Rx_Tx_Top;

reg         clk;
reg         rst_n;
wire                 rs232_rx;
 wire                rs232_tx;
 reg    send_en;

reg     [7:0]   data_byte;

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


Sdram_Tx_Rx_Top Sdram_Tx_Rx_Top_inst(
    //.clk_24M                    (clk),
    .clk_50M                (clk),//just test 
    .rst_n                  (rst_n),
    .rs232_rx               (rs232_rx),
    .rs232_tx               (rs232_tx),
    .sdram_clk              (sdram_clk),
    .sdram_cke              (sdram_cke),
    .sdram_cs_n             (sdram_cs_n),
    .sdram_ras_n            (sdram_ras_n),
    .sdram_cas_n            (sdram_cas_n),
    .sdram_we_n             (sdram_we_n),
    .sdram_bank             (sdram_bank),
    .sdram_addr             (sdram_addr),
    .sdram_data             (sdram_data),
    .sdram_dqm              (sdram_dqm)
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
Uart_Byte_Tx_test Uart_Byte_Tx_test_inst(
	.clk					(clk),
	.rst_n					(rst_n),	
	.send_en				(send_en),//时钟分频使能	
	.baud_set				(4'd4),//选择波特率	
	.data_byte				(data_byte),//需要发送的信号	
	.uart_state				(),//串口状态	
	.tx_done				(),//标志串口结束信号	
	.rs232_tx				(rs232_rx)//串口信号输出   
 );


initial begin
    clk  = 1'b1;
    rst_n = 1'b0;
    data_byte = 0;
    send_en = 1'b0;
    #100;
    rst_n = 1'b1;
    //tx_byte();
    
    #95000 data_byte = 8'h55;send_en = 1'b1;
	#95000 data_byte = 8'h01;
	#95000 data_byte = 8'h02;
	#95000 data_byte = 8'h03;
	#95000 data_byte = 8'h04;
	#95000 data_byte = 8'haa;
    #95000
    send_en = 1'b0;

end

always #10 clk = ~clk;


/*initial $readmemh("./tx_data.txt", mema);

task tx_byte();
    integer i;
    for(i = 0; i < 6; i = i + 1)begin
        tx_bit(mema[i]);
    end
endtask

task tx_bit(
    input       [7:0]   data
);

integer     i;
for (i = 0; i < 10; i = i + 1)begin
    case(i)
        0:rs232_rx <= 1'b0;
        1: rs232_rx <= data[0];
        2: rs232_rx <= data[1];
        3: rs232_rx <= data[2];
        4: rs232_rx <= data[3];
        5: rs232_rx <= data[4];
        6: rs232_rx <= data[5];
        7: rs232_rx <= data[6];
        8: rs232_rx <= data[7];
        9: rs232_rx <= 1'b1;
    endcase
    #8680;

end
endtask*/


endmodule
