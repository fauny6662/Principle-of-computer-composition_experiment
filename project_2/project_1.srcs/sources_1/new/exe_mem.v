`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/12 23:42:39
// Design Name: 
// Module Name: exe_mem
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


module exe_mem(
    input clk,reset,
    input 
    Branch,
    MemtoReg,
    MemWrite,
    MemRead,
    RegWrite,
    input [31:0]npc,Aluout,busB,
    input zero,
    input [4:0]rd,
    output reg Branch_out,
    MemtoReg_out,
    MemWrite_out,
    MemRead_out,
    RegWrite_out,
    output reg [31:0]npc_out,Aluout_out,busB_out,
    output reg zero_out,
    output reg [4:0]rd_out 
    );
    always @(posedge clk)
        begin
            if(reset==1)
                begin
                    Branch_out<=0;
                    MemtoReg_out<=0;
                    MemWrite_out<=0;
                    RegWrite_out<=0;
                    MemRead_out<=0;
                    busB_out<=32'b0;
                    npc_out<=32'b0;
                    Aluout_out<=32'b0;
                    zero_out<=0;
                    rd_out<=5'b0;
                end
            else
                begin
                    Branch_out<=Branch;
                    MemtoReg_out<=MemtoReg;
                    MemWrite_out<=MemWrite;
                    MemRead_out<=MemRead;
                    RegWrite_out<=RegWrite;
                    busB_out<=busB;
                    npc_out<=npc;
                    Aluout_out<=Aluout;
                    zero_out<=zero;
                    rd_out<=rd;
                end
        end
endmodule
