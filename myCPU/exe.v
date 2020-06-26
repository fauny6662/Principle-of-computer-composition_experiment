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
    input clk,reset,exe_flush,
    input RegDst,
    Branch,
    MemtoReg,
    Alusrc1,
    Alusrc2,
    input [1:0]MemWrite,MemRead,
    input RegWrite,
    input [4:0]Aluctr,
    input [4:0]rt,rd,
    input [31:0]pc_4,
    input [31:0]busA,busB,
    input [31:0]immi1,immi2,
    output reg 
    Branch_out,
    MemtoReg_out,
    output reg [1:0]MemWrite_out,MemRead_out,
    output reg RegWrite_out,
    output [31:0]Aluout,
    output reg [31:0]busB_out,
    output zero,overflow,
    output reg [4:0]rd_out
    );
    wire [31:0]busC,busD;
    always @(*)
        if(exe_flush==1)
            begin
                rd_out=0;
                Branch_out=0;
                MemtoReg_out=0;
                MemWrite_out=0;
                MemRead_out=0;
                RegWrite_out=0;
                busB_out=0;
            end
        else
            begin
                rd_out=(RegDst==0)?rt:rd;
                Branch_out=Branch;
                MemtoReg_out=MemtoReg;
                MemWrite_out=MemWrite;
                MemRead_out=MemRead;
                RegWrite_out=RegWrite;
                busB_out=busB;
            end
    mux2 mu1(immi1,busA,Alusrc1,busC);
    mux2 mu2(immi2,busB,Alusrc2,busD);
    alu alu1(Aluctr,busC,busD,zero,overflow,Aluout);
endmodule
