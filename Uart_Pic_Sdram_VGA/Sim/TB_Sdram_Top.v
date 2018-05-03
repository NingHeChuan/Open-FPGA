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

module TB_Sdram_Top;

reg             clk;
reg             rst_n;
//wfifo signal
reg             wfifo_wclk;   
reg             wfifo_wr_en;  
reg   [15:0]    wfifo_wr_data;
//rfifo signal
reg             rfifo_rclk;

wire            disp_en;
wire             rfifo_rd_en = disp_en;
wire    [15:0]  rfifo_rd_data;
wire            rfifo_rd_ready;


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

Sdram_Top Sdram_Top_inst(
    .clk                    (clk),
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
    .sdram_dqm              (sdram_dqm),
    .wfifo_wclk             (wfifo_wclk),
    .wfifo_wr_en            (wfifo_wr_en),
    .wfifo_wr_data          (wfifo_wr_data),
    .rfifo_rclk             (rfifo_rclk),
    .rfifo_rd_en            (rfifo_rd_en),
    .rfifo_rd_data          (rfifo_rd_data),
    .rfifo_rd_ready         (rfifo_rd_ready)
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

initial begin
    clk  = 1'b1;
    rst_n = 1'b0;
    #100;
    rst_n = 1'b1;

end

always #5 clk = ~clk;

initial begin
    wfifo_wclk = 1'b1;
    
    wfifo_wr_en = 1'b0;
    #210000
    wfifo_wr_en = 1'b1;
    #10240
    wfifo_wr_en = 1'b0;
end

always @(posedge wfifo_wclk or negedge rst_n)begin
    if(rst_n == 1'b0)
        wfifo_wr_data <= 'd0;
    else if(wfifo_wr_data == 255)
        wfifo_wr_data <= 'd0;
    else if(wfifo_wr_en == 1'b1)
        wfifo_wr_data <= wfifo_wr_data + 1'b1;
    end

always #10 wfifo_wclk = ~wfifo_wclk;

initial begin
rfifo_rclk = 1'b0;
//rfifo_rd_en = 1'b0;
//#225000
//rfifo_rd_en = 1'b1;


end

/*
always @(posedge rfifo_rclk or negedge rst_n)begin
    if(rst_n == 1'b0)
        rfifo_rd_en <= 1'b0;
    else if(rfifo_rd_ready == 1'b1) 
        rfifo_rd_en <= disp_en;
    else 
        rfifo_rd_en <= 1'b0;
end
*/


always #20 rfifo_rclk = ~rfifo_rclk;


//VGA_Drive
wire            lcd_hs;
wire            lcd_vs;
wire            lcd_blank;
wire            lcd_dclk;
wire    [15:0]  lcd_data;
wire     [11:0]	lcd_x;
wire     [11:0]	lcd_y;


wire    [11:0] 	hcnt;
wire    [11:0] 	vcnt;
//VGA_Dispaly
wire     [7:0]	dina = rfifo_rd_data[7:0];




//-------------------------------------------------------
//VGA_Drive
VGA_Drive VGA_Drive_inst(
	.clk                    (rfifo_rclk),//25Mhz
	.rst_n                  (rst_n & rfifo_rd_ready),
	.lcd_hs                 (lcd_hs),//行同步信号
	.lcd_vs                 (lcd_vs),//场同步信号
    .lcd_blank              (lcd_blank),
    .lcd_dclk               (lcd_dclk),
	.lcd_x                  (lcd_x),
	.lcd_y                  (lcd_y),
    .hcnt                   (hcnt),
    .vcnt                   (vcnt)
    );	
//-------------------------------------------------------
//VGA_Dispaly
VGA_Dispaly VGA_Dispaly_inst(
	.clk                    (rfifo_rclk),//25Mhz
	.rst_n                  (rst_n & rfifo_rd_ready), 		
	.lcd_x                  (lcd_x),
	.lcd_y                  (lcd_y),
    .hcnt                   (hcnt),
    .vcnt                   (vcnt),
	.dina                   (dina),
    .rfifo_rd_ready         (rfifo_rd_ready),
    .disp_en                (disp_en),
	.lcd_data               (lcd_data)
);

endmodule
