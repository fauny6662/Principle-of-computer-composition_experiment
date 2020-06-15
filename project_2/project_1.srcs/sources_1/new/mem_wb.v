`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/12 23:37:33
// Design Name: 
// Module Name: mem_wb
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


module mem_wb(
    input clk,reset,
    input 
    MemtoReg,
    RegWrite,
    input [31:0]Rdata,Aluout,
    input [4:0]rd,
    output reg MemtoReg_out ,
    RegWrite_out,
    output reg [31:0]Rdata_out,Aluout_out,
    output reg [4:0]rd_out 
    );
    always @(posedge clk)
        begin
            if(reset==1)
                begin
                    MemtoReg_out<=0;
                    RegWrite_out<=0;
                    Rdata_out<=32'b0;
                    Aluout_out<=32'b0;
                    rd_out<=5'b0;
                end
            else 
                begin
                    MemtoReg_out<=MemtoReg;
                    RegWrite_out<=RegWrite;
                    Rdata_out<=Rdata;
                    Aluout_out<=Aluout;
                    rd_out<=rd;
                end
        end
endmodule
