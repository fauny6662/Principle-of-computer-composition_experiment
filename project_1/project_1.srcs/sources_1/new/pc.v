`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/05 13:52:10
// Design Name: 
// Module Name: pc
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


module pc #(parameter width = 32)
    (input ena,clk,rst,
    input [width-1:0] data,
    output reg [width-1:0] out);
always @(posedge clk)
 if(rst)
    begin
        out<=32'h0x0000_30000;
    end
 else if(ena)
    out<=data;
endmodule
