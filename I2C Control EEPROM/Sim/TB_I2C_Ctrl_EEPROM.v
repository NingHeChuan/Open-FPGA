`timescale      1ns/1ps
// *********************************************************************************
// Project Name :       
// Author       : NingHeChuan
// Email        : ninghechuan@foxmail.com
// Blogs        : http://www.cnblogs.com/ninghechuan/
// File Name    : TB_I2C_Ctrl_EEPROM.v
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
// 2018/8/16    NingHeChuan       1.0                     Original
//  
// *********************************************************************************

module TB_I2C_Ctrl_EEPROM;
    reg                   clk;
    reg                   rst_n;
    reg           [31:0]  eeprom_config_data;
    reg                   i2c_start;          //1 valid
    wire                  i2c_sdat;
    wire                  i2c_sclk;
    wire                  i2c_done;
    wire          [7:0]   i2c_rd_data;


wire    [7:0]   wr_device_addr = 8'hA0;             //8'hA0写器件地址，8'hA1读器件地址
wire    [7:0]   rd_device_addr = 8'hA1;  
wire    [7:0]   reg_addr1   = 8'b0000_0000;
wire    [7:0]   reg_addr2   = 8'b0000_1111;
wire    [7:0]   wr_data     = 8'b0000_1111;


I2C_Ctrl_EEPROM I2C_Ctrl_EEPROM_inst(
    .clk                    (clk               ),
    .rst_n                  (rst_n             ),
    .eeprom_config_data     (eeprom_config_data),
    .i2c_start              (i2c_start         ),          //1 valid
    .i2c_sdat               (i2c_sdat          ),
    .i2c_sclk               (i2c_sclk          ),
    .i2c_done               (i2c_done          ),
    .i2c_rd_data            (i2c_rd_data       )
);

EEPROM_AT24C64 EEPROM_AT24C64_inst(
    .scl                    (i2c_sclk), 
    .sda                    (i2c_sdat)
);

always #10 clk = ~clk;

initial begin
clk = 1'b0;
rst_n = 1'b0;
i2c_start = 1'b0;
eeprom_config_data = 'b0;
#490
rst_n = 1'b1;
i2c_start = 1'b1;
eeprom_config_data = {wr_device_addr, reg_addr1, reg_addr2, wr_data};
#46000
i2c_start = 1'b0;
#10000
i2c_start = 1'b1;
eeprom_config_data = {rd_device_addr, reg_addr1, reg_addr2, wr_data};


end

endmodule
