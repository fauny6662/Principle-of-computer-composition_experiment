`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/12 22:46:30
// Design Name: 
// Module Name: mem
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


module mem(
    input clk,reset,
    input Branch,
    MemtoReg,
    input [1:0]MemWrite,MemRead,
    input RegWrite,
    input [31:0]Aluout,busB,data_sram_rdata,
    input zero,
    input [4:0]rd,
    output [3:0] data_sram_wen,
    output [31:0] data_sram_wdata, rdata,//内存中实际读出的数据
    output br,
    output MemtoReg_out,
    output RegWrite_out,
    output [31:0]Aluout_out,
    output [4:0]rd_out
    );
    assign MemtoReg_out=MemtoReg;
    assign RegWrite_out=RegWrite;
    assign Aluout_out=Aluout;
    assign br=Branch&zero;
    assign rd_out=rd;
    rst_DM rst1(Aluout,busB,data_sram_rdata,MemRead,MemWrite,data_sram_wen,data_sram_wdata,rdata);
endmodule
