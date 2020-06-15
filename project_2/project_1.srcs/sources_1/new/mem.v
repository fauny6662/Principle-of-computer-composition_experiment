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
    MemWrite,
    MemRead,
    RegWrite,
    input [31:0]Aluout,busB,
    input zero,
    input [4:0]rd,
    output br,
    MemtoReg_out,
    RegWrite_out,
    output [31:0]Rdata,Aluout_out,
    output [4:0]rd_out
    );
    assign MemtoReg_out=MemtoReg;
    assign RegWrite_out=RegWrite;
    assign Aluout_out=Aluout;
    assign br=Branch&zero;
    assign rd_out=rd;
    dm_4k dm1(Aluout[11:0],busB,MemWrite,MemRead,clk,Rdata);
endmodule
