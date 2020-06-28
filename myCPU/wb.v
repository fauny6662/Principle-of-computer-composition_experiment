`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/12 23:50:22
// Design Name: 
// Module Name: wb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module wb(
    input clk,reset,
    input 
    MemtoReg,
    RegWrite,
    input [31:0]Aluout, rdata,//读内存实际得到的数据
    input [4:0]rd,
    input mfc0,
    input [31:0]except_data,
    output RegWrite_out,
    output reg [31:0]dataout,
    output [4:0]rd_out
    );
    always @(*)
        begin
            if(mfc0 == 1)
                dataout = except_data;
            else if(MemtoReg == 1)
                dataout = rdata;
            else dataout = Aluout;
        end
    assign RegWrite_out=RegWrite;
    assign rd_out=rd;
endmodule
