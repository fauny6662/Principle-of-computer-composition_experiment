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
    input clk,reset,exe_flush,
    input 
    Branch,
    MemtoReg,
    input [1:0]MemWrite,MemRead,
    input RegWrite,
    input [31:0]Aluout,busB,pc,
    input zero,
    input [4:0]rd,
    output reg Branch_out,
    MemtoReg_out,
    output reg [1:0]MemWrite_out,MemRead_out,
    output reg RegWrite_out,
    output reg [31:0]Aluout_out,busB_out,pc_out,
    output reg zero_out,
    output reg [4:0]rd_out 
    );
    always @(posedge clk)
        begin
            if(reset==1|exe_flush==1)
                begin
                    Branch_out<=0;
                    MemtoReg_out<=0;
                    MemWrite_out<=2'b00;
                    RegWrite_out<=0;
                    MemRead_out<=2'b00;
                    busB_out<=32'b0;
                    Aluout_out<=32'b0;
                    zero_out<=0;
                    rd_out<=5'b0;
                    pc_out<=32'b0;
                end
            else
                begin
                    Branch_out<=Branch;
                    MemtoReg_out<=MemtoReg;
                    MemWrite_out<=MemWrite;
                    MemRead_out<=MemRead;
                    RegWrite_out<=RegWrite;
                    busB_out<=busB;
                    Aluout_out<=Aluout;
                    zero_out<=zero;
                    rd_out<=rd;
                    pc_out<=pc;
                end
        end
endmodule
