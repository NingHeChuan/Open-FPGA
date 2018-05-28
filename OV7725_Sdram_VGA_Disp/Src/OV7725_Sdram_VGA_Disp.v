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

module OV7725_Sdram_VGA_Disp(
    input                   clk_24M,
    input                   rst_n,
    //cmos interface
	output			cmos_sclk,		//cmos i2c clock
	inout			cmos_sdat,		//cmos i2c data
	input			cmos_vsync,		//cmos vsync
	input			cmos_href,		//cmos hsync refrence
	input			cmos_pclk,		//cmos pxiel clock
	output			cmos_xclk,		//cmos externl clock
	input	[7:0]	cmos_data,		//cmos data
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

localparam	CLOCK_MAIN	=	100_000000;
localparam	CLOCK_CMOS	=	24_000000;
//Clk_Pll
wire            clk_50M;
wire            clk_100M;
wire            clk_25M;
//
wire	[7:0]	i2c_config_index;
wire	[15:0]	i2c_config_data;
wire	[7:0]	i2c_config_size;
wire			i2c_config_done;
wire	[7:0]	i2c_rdata;		//i2c register data
//
wire			cmos_init_done = i2c_config_done & sdram_init_end;	///cmos camera init done
wire			cmos_frame_vsync;	//cmos frame data vsync valid signal
wire			cmos_frame_href;	//cmos frame data href vaild  signal
wire	[15:0]	cmos_frame_data;	//cmos frame data output: {cmos_data[7:0]<<8, cmos_data[7:0]}	
wire			cmos_frame_clken;	//cmos frame data output/capture enable clock
wire	[7:0]	cmos_fps_rate;		//cmos image output rate
//Sdram_Top
//wfifo signal 
wire            disp_en;
wire            wfifo_wclk = cmos_pclk;
wire            wfifo_wr_en = cmos_frame_clken;
wire    [15:0]  wfifo_wr_data = cmos_frame_data;    //rfifo signal
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
wire     [15:0]	dina = rfifo_rd_data;
//-------------------------------------------------------
//Clk_Pll
Clk_Pll	Clk_Pll_inst (
	.inclk0                 ( clk_24M ),//24Mhz
	.c0                     ( clk_100M ),//100Mhz
	.c1                     ( clk_50M ),//50Mhz
	.c2                     ( clk_25M )//25Mhz
	);



//----------------------------------------------
//i2c timing controller module

i2c_timing_ctrl
#(
	.CLK_FREQ	(CLOCK_MAIN),	//100 MHz
	.I2C_FREQ	(400_000)		//10 KHz(<= 400KHz)
)
u_i2c_timing_ctrl
(
	//global clock
	.clk				(clk_100M),		//100MHz
	.rst_n				(rst_n),	//system reset
			
	//i2c interface
	.i2c_sclk			(cmos_sclk),	//i2c clock
	.i2c_sdat			(cmos_sdat),	//i2c data for bidirection

	//i2c config data
	.i2c_config_index	(i2c_config_index),	//i2c config reg index, read 2 reg and write xx reg
	.i2c_config_data	({8'h42, i2c_config_data}),	//i2c config data
	.i2c_config_size	(i2c_config_size),	//i2c config data counte
	.i2c_config_done	(i2c_config_done),	//i2c config timing complete
	.i2c_rdata			(i2c_rdata)			//i2c register data while read i2c slave
);

//----------------------------------------------
//I2C Configure Data of OV7725/OV7670
//I2C_OV7670_RGB565_Config	u_I2C_OV7670_RGB565_Config
I2C_OV7725_RGB565_Config	u_I2C_OV7725_RGB565_Config
(
	.LUT_INDEX		(i2c_config_index),
	.LUT_DATA		(i2c_config_data),
	.LUT_SIZE		(i2c_config_size)
);


//--------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------
//cmos video image capture

CMOS_Capture_RGB565	
#(
	.CMOS_FRAME_WAITCNT		(4'd10)				//Wait n fps for steady(OmniVision need 10 Frame)
)
u_CMOS_Capture_RGB565
(
	//global clock
	.clk_cmos				(clk_24M),			//24MHz CMOS Driver clock input
	.rst_n					(rst_n & cmos_init_done),	//global reset

	//CMOS Sensor Interface
	.cmos_pclk				(cmos_pclk),  		//24MHz CMOS Pixel clock input
	.cmos_xclk				(cmos_xclk),		//24MHz drive clock
	.cmos_data				(cmos_data),		//8 bits cmos data input
	.cmos_vsync				(cmos_vsync),		//L: vaild, H: invalid
	.cmos_href				(cmos_href),		//H: vaild, L: invalid
	
	//CMOS SYNC Data output
	.cmos_frame_vsync		(cmos_frame_vsync),	//cmos frame data vsync valid signal
	.cmos_frame_href		(cmos_frame_href),	//cmos frame data href vaild  signal
	.cmos_frame_data		(cmos_frame_data),	//cmos frame RGB output: {{R[4:0],G[5:3]}, {G2:0}, B[4:0]}	
	.cmos_frame_clken		(cmos_frame_clken),	//cmos frame data output/capture enable clock
	
	//user interface
	.cmos_fps_rate			(cmos_fps_rate)		//cmos image output rate
);
    
//-------------------------------------------------------
//
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
    .rfifo_rd_ready         (rfifo_rd_ready),
    .init_end               (sdram_init_end)
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
