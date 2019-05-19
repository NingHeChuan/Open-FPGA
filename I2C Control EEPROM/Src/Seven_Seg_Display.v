`timescale 1ns / 1ps

module Seven_Seg_Display(
    input               clk,
    input               rst_n,
    input       [3:0]   data_four,
    input       [3:0]   data_three,
    input       [3:0]   data_two,
    input       [3:0]   data_one,
    output  reg [6:0]   out,
    output  reg    [3:0]   an,//所有的数码管的使能端
    output  reg         dp
    );

//assign an = 4'b0000;
wire [3:0] aen;     //数码管使能信号
reg [1:0] s;        //数码管显示选择
reg [18:0] cnt;     //数码管扫描时钟计数
reg [3:0]  disp_data;

parameter CLK190 = 19'd263157;
//parameter CLK190 = 19'd263;

always @(posedge clk or negedge rst_n)begin
   if(!rst_n)
   	cnt <= 19'b0;
   else if(cnt == CLK190 - 1'b1)
   	cnt <= 19'b0;
   else 
   	cnt <= cnt + 1'b1;	
end
	 
//灯的状态没5.2毫秒刷新一次
always @(posedge clk or negedge rst_n)begin
   if(!rst_n)
   	s <= 2'b0;
   else if(cnt == CLK190 - 1'b1)
   	s <= s + 1'b1;	
end

assign aen = 4'b1111;

always @(*)begin
   an  = 4'b1111;
   if(aen[s] == 1)
   	an[s]  = 1'b0;
end

//-------------------------------------------------------
//disp_data
always @(posedge clk or negedge rst_n)begin
	if(!rst_n)
		disp_data <=4'd0;
	else 
   	case(s)
    0: begin 
        disp_data <= data_one;
        dp <= 1'b1;
    end
    1: begin
        disp_data <= data_two;
        dp <= 1'b1;
    end
    2: begin 
        disp_data <= data_three;
        dp <= 1'b1;
    end
    3: begin
        disp_data <= data_four;
        dp <= 1'b1;
    end
    default: begin 
        disp_data <= 4'd0;
        dp <= 1'b1;
    end
   	endcase
end

//-------------------------------------------------------
//
 always @(posedge clk or negedge rst_n)begin
	if(!rst_n)
		out <= 7'b0000_001;
	else begin
			case(disp_data)
				4'h0: out <= 7'b0000_001;
				4'h1: out <= 7'b1001_111;
				4'h2: out <= 7'b0010_010;
				4'h3: out <= 7'b0000_110;
				4'h4: out <= 7'b1001_100;
				4'h5: out <= 7'b0100_100;
				4'h6: out <= 7'b0100_000;
				4'h7: out <= 7'b0001_111;
				4'h8: out <= 7'b0000_000;
				4'h9: out <= 7'b0000_100;
                4'ha: out <= 7'b1110_010;
                4'hb: out <= 7'b1100_110;
                4'hc: out <= 7'b1011_100;
                4'hd: out <= 7'b0110_100;
                4'he: out <= 7'b1110_000;
                4'hf: out <= 7'b1111_111;
				default: out <= 7'b0000_001;
			endcase
		end
 end
 	 
endmodule
