`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/07 14:31:41
// Design Name: 
// Module Name: sim_crtl
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


module sim_crtl;
    reg [5:0]op;
    wire RegDst,
    Branch,
    MemtoReg,
    Alusrc,
    MemWrite,
    RegWrite,
    Jump,
    Extop;
    wire [1:0]Aluop;
    wire r_type;
    ctrl ctrl1(op, RegDst,
    Branch,
    MemtoReg,
    Alusrc,
    MemWrite,
    RegWrite,
    Jump,
    Extop,
    Aluop,
    r_type);
    initial 
        begin
            op=0;
        end
endmodule
