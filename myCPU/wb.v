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
    input [1:0]MemWrite,MemRead,
    input [31:0]Aluout,busB,data_sram_rdata,
    input [4:0]rd,
    output RegWrite_out,
    output [31:0]dataout,
    output [4:0]rd_out
    );
    // wire [31:0]busA,busB;
    wire [31:0]rdata;//内存中实际读出的数据
    rst_DM rst1(Aluout,busB,data_sram_rdata,MemRead,MemWrite,rdata);
    mux2 mu2(rdata,Aluout,MemtoReg,dataout);
    // regfile regfile1(clk,RegWrite,5'b0,5'b0,rd,dataout,busA,busB);
    assign RegWrite_out=RegWrite;
    assign rd_out=rd;
endmodule
