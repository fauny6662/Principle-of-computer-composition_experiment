`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/06 13:16:16
// Design Name: 
// Module Name: test_datapath
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


module test_datapath;
    reg clk,reset,RegWrite,RegDst,AluSrc,ExtOp,Branch,
    Jump,MemWrite,MemtoReg;
    reg [2:0]ALUctr;
    wire  [31:0]instrution;
    wire  [31:0]immi,result;
    datapath datapath1(clk,
    reset,
    RegDst,
    AluSrc,
    MemtoReg,
    RegWrite,
    MemWrite,
    Branch,
    Jump,
    ExtOp,
    ALUctr,
    instrution
    );
    initial
        begin:Clocking
            RegWrite=1;
            AluSrc=1;
            RegDst=0;
            ExtOp=1;
            MemtoReg=1;
            ALUctr=3'b000;
            MemWrite=0;
            Branch=0;
            Jump=0;
            clk=0;
            forever #10 clk =!clk;
        end
    initial
        begin
            reset=1;
            #20 reset=0;
        end
endmodule
