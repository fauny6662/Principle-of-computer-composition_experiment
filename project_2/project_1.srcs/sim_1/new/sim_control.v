`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/07 14:09:50
// Design Name: 
// Module Name: sim_control
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


module sim_control;
    wire RegDst,
    Branch,
    MemtoReg,
    Alusrc,
    MemWrite,
    RegWrite,
    Jump,
    Extop;
    reg [31:0]instruction;
    wire [2:0]Aluctr;
    control control1(instruction,
    RegDst,
    Branch,
    MemtoReg,
    Alusrc,
    MemWrite,
    RegWrite,
    Jump,
    Extop,
    Aluctr);
    initial 
        begin
            instruction={{26{1'b0}},6'b100000};
        end
endmodule
