`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/05 18:44:53
// Design Name: 
// Module Name: regfile
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


module regfile(
    input clk,we,
    input [4:0] rs,rt,rd,
    input [31:0]wd,
    output [32:0] busA,busB
    );
    reg[31:0]rf[31:0]; //寄存器一共32个单元，每个单元32位
    always @(posedge clk)
        if (we) rf[rd]<=wd;
    assign busA=(rs!=0)?rf[rs]:0;
    assign busB=(rt!=0)?rf[rt]:0;
endmodule
