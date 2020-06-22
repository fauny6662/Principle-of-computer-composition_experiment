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
    input [31:0]Rdata,Aluout,
    input [4:0]rd,
    output RegWrite_out,
    output [31:0]dataout,
    output [4:0]rd_out
    );
    // wire [31:0]busA,busB;
    mux2 mu2(Rdata,Aluout,MemtoReg,dataout);
    // regfile regfile1(clk,RegWrite,5'b0,5'b0,rd,dataout,busA,busB);
    assign RegWrite_out=RegWrite;
    assign rd_out=rd;
endmodule
