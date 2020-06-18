`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/15 14:00:53
// Design Name: 
// Module Name: epc
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


module epc(
    input clk,reset,
    input [31:0]pc,
    output reg [31:0]pc_out
    );
    always @(posedge clk)
        begin
            pc_out<=pc;
        end
endmodule
