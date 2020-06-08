`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/07 14:44:19
// Design Name: 
// Module Name: Mips
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


module Mips(
    input clk,reset
    );
    wire
    RegDst,
    AluSrc,
    MemtoReg,
    RegWrite,
    MemWrite,
    Branch,
    Jump,
    ExtOp;
    wire [2:0]ALUctr;
    wire [31:0]instruction;
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
    instruction);
    control control1(instruction,
    RegDst,
    Branch,
    MemtoReg,
    AluSrc,
    MemWrite,
    RegWrite,
    Jump,
    ExtOp,
    ALUctr);
endmodule
