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
    input [31:0]Aluout,busB,
    input zero,
    input [4:0]rd,
    output br,
    output MemtoReg_out,
    output RegWrite_out,
    output [1:0]MemWrite_out,MemRead_out,
    output [31:0]Aluout_out,busB_out,
    output [4:0]rd_out
    );
    assign MemtoReg_out=MemtoReg;
    assign RegWrite_out=RegWrite;
    assign MemWrite_out=MemWrite;
    assign MemRead_out=MemRead;
    assign Aluout_out=Aluout;
    assign br=Branch&zero;
    assign rd_out=rd;
    assign busB_out=busB;
    //rst_DM rst1(Aluout,busB,data_sram_rdata,MemRead,MemWrite,data_sram_wen,data_sram_wdata,rdata);
endmodule
