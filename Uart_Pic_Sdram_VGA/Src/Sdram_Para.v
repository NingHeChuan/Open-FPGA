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
// 2018/4/18    NingHeChuan       1.0                     Original
//  
// *********************************************************************************

//Sdram_Top state machine
`define   IDLE           5'b00001
`define   ARBIT          5'b00010
`define   A_REF          5'b00100
`define   READ           5'b01000
`define   WRITE          5'b10000

//Sdram command
/*
                cs_n    ras_n   cas_n   we_n
CMD_PREGE       0       0       1       0
CMD_A_REF       0       0       0       1
CMD_NOP         0       1       1       1
CMD_MRS         0       0       0       0 
CMD_ACT         0       0       1       1
CMD_WRITE       0       1       0       0

*/
`define       CMD_PREGE         4'b0010
`define       CMD_A_REF         4'b0001
`define       CMD_NOP           4'b0111
`define       CMD_MRS           4'b0000
`define       CMD_ACT           4'b0011
`define       CMD_WRITE         4'b0100
`define       CMD_READ          4'b0101

//-------------------------------------------------------
//Sdram Write state machine
`define   S_IDLE           5'b00001
`define   S_WREQ           5'b00010
`define   S_RREQ           5'b00011
`define   S_ACTROW         5'b00100
`define   S_WRITE          5'b00101
`define   S_READ           5'b00110
`define   S_PREGE          5'b00111

