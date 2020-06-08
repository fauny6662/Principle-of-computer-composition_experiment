`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/05 19:04:40
// Design Name: 
// Module Name: left2
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


module sl2 # (parameter width=32)
(
    input [width-1:0]a,
    output [width-1:0]y
    );
    assign y={a[width-3:0],2'b00};
endmodule
