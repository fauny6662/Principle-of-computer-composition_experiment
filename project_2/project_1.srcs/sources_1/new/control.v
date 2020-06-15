`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/07 13:58:31
// Design Name: 
// Module Name: control
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


module control(
    input [31:0]instruction,
    output RegDst,
    Branch,
    MemtoReg,
    Alusrc,
    MemWrite,
    MemRead,
    RegWrite,
    Jump,
    Extop,
    output [2:0]Aluctr
    );
    wire [1:0]Aluop;
    wire r_type;
    ctrl ctrl1(instruction[31:26],
    RegDst,
    Branch,
    MemtoReg,
    Alusrc,
    MemWrite,
    MemRead,
    RegWrite,
    Jump,
    Extop,
    Aluop,
    r_type);
    Aluctr Aluctr1(r_type,instruction[5:0],Aluop,Aluctr);
endmodule
