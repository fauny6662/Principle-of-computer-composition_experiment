`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/12 21:46:14
// Design Name: 
// Module Name: exe
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


module exe(
    input clk,reset,
    input RegDst,
    Branch,
    MemtoReg,
    Alusrc,
    MemWrite,
    MemRead,
    RegWrite,
    input [2:0]Aluctr,
    input [4:0]rt,rd,
    input [31:0]pc_4,
    input [31:0]busA,busB,
    input [31:0]immi,
    output 
    Branch_out,
    MemtoReg_out,
    MemWrite_out,
    MemRead_out,
    RegWrite_out,
    output [31:0]Aluout,busB_out,
    output zero,
    output [4:0]rd_out
    );
    wire [31:0]busC;
    assign rd_out=(RegDst==0)?rt:rd;
    assign Branch_out=Branch;
    assign MemtoReg_out=MemtoReg;
    assign MemWrite_out=MemWrite;
    assign MemRead_out=MemRead;
    assign RegWrite_out=RegWrite;
    assign busB_out=busB;
    mux2 mu1(immi,busB,Alusrc,busC);
    alu alu1(Aluctr,busA,busC,zero,Aluout);
    // npc npc1(immi,Branch,zero,pc_4,npc);
endmodule
