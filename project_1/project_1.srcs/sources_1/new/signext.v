`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/05 18:59:39
// Design Name: 
// Module Name: signext
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

module signext # (parameter width=16)
(
    input [width-1:0]a,
    input f,
    output [31:0]y
    );
    assign y=(f==1)?{{32-width{a[width-1]}},a}:{{32-width{0}},a};
endmodule
