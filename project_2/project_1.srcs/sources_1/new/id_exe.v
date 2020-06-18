`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/12 20:42:20
// Design Name: 
// Module Name: id_exe
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


module id_exe(
    input clk,reset,
    input RegDst,
    Branch,
    MemtoReg,
    Alusrc1,
    Alusrc2,
    MemWrite,
    MemRead,
    RegWrite,
    input [4:0]Aluctr,
    input [4:0]rt,rd,
    input [31:0]immi1,immi2,busA,busB,pc_4,
    output reg RegDst_out,
    Branch_out,
    MemtoReg_out,
    Alusrc1_out,
    Alusrc2_out,
    MemWrite_out,
    MemRead_out,
    RegWrite_out,
    output reg[4:0]Aluctr_out,
    output reg [4:0]rt_out,rd_out,
    output reg [31:0]pc_4_out,busA_out,busB_out,immi1_out,immi2_out
    );
    always @(posedge clk)
        begin
            if(reset==1)
                begin
                    Branch_out<=0;
                    MemtoReg_out<=0;
                    Alusrc1_out<=0;
                    Alusrc2_out<=0;
                    MemWrite_out<=0;
                    RegWrite_out<=0;
                    MemRead_out<=0;
                    RegDst_out<=0;
                    Aluctr_out<=5'b0;
                    rd_out<=5'b0;
                    rt_out<=5'b0;
                    pc_4_out<=32'b0;
                    busA_out<=32'b0;
                    busB_out<=32'b0;
                    immi1_out<=32'b0;
                    immi2_out<=32'b0;
                end
            else
                begin
                    RegDst_out<=RegDst;
                    Branch_out<=Branch;
                    MemtoReg_out<=MemtoReg;
                    Alusrc1_out<=Alusrc1;
                    Alusrc2_out<=Alusrc2;
                    MemWrite_out<=MemWrite;
                    MemRead_out<=MemRead;
                    RegWrite_out<=RegWrite;
                    Aluctr_out<=Aluctr;
                    rd_out=rd;
                    rt_out=rt;
                    pc_4_out<=pc_4;
                    busA_out<=busA;
                    busB_out<=busB;
                    immi1_out<=immi1;
                    immi2_out<=immi2;
                end

        end
endmodule
