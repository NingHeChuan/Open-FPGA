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
// 2018/8/19    NingHeChuan       1.0                     Original
//  
// *********************************************************************************

module TB_Top;

    reg                   clk;    //50Mhz
    reg                   rst_n;
    //IIC Signal
    wire                  i2c_sdat;
    wire                  i2c_sclk;
    //Seg Signal
    wire       [6:0]      out;
    wire                  dp;
	wire       [3:0]      an;      //所有的数码管的使能端
    //Other Signal
    reg                   wr_en;
    reg                   rd_en;

Top Top_inst(
    .clk                    (clk     ),    //50Mhz
    .rst_n                  (rst_n   ),
    .i2c_sdat               (i2c_sdat),
    .i2c_sclk               (i2c_sclk),
    .out                    (out     ),
    .dp                     (dp      ),
	.an                     (an      ),      //所有的数码管的使能端
    .wr_en                  (wr_en   ),
    .rd_en                  (rd_en   )
); 


EEPROM_AT24C64 EEPROM_AT24C64_inst(
    .scl                    (i2c_sclk), 
    .sda                    (i2c_sdat)
);

always #10 clk = ~clk;

initial begin
clk = 1'b0;
rst_n = 1'b0;
wr_en = 1'b0;
rd_en = 1'b0;
#500
rst_n = 1'b1;
wr_en = 1'b1;
#460000
wr_en = 1'b0;
#10000
rd_en = 1'b1;





end

endmodule
