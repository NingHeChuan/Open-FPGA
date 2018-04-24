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

reg         clk;
reg         rst_n;
reg         wr_trig;
reg         rd_trig;

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
    .wr_trig                (wr_trig),
    .rd_trig                (rd_trig)
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
    wr_trig = 1'b0;
    rd_trig = 1'b0;
    #100;
    rst_n = 1'b1;
    #215000
    wr_trig = 1'b1;
    #20
    wr_trig = 1'b0;
    #10000
    rd_trig = 1'b1;
    #20
    rd_trig = 1'b0;
end

always #10 clk = ~clk;

endmodule
